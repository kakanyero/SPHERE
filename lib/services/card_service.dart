import 'package:supabase_flutter/supabase_flutter.dart';

/// Saves display-only card info (last 4 digits, expiry). The full card
/// number and CVV are NEVER sent to the database. To actually charge
/// cards, integrate a provider (Stripe, Flutterwave, ...) and store its
/// token in `provider_token`.
/// Put at lib/services/card_service.dart
class CardService {
  CardService._();
  static final CardService instance = CardService._();

  final SupabaseClient _db = Supabase.instance.client;

  static String _brand(String digits) {
    if (digits.startsWith('4')) return 'Visa';
    if (RegExp(r'^(5[1-5]|2[2-7])').hasMatch(digits)) return 'Mastercard';
    if (RegExp(r'^3[47]').hasMatch(digits)) return 'Amex';
    return 'Card';
  }

  /// [expiry] is "MM/YY" or "MMYY".
  Future<void> addCard({
    required String cardholder,
    required String cardNumber,
    required String expiry,
  }) async {
    final uid = _db.auth.currentUser?.id;
    if (uid == null) throw Exception('Not signed in');

    final digits = cardNumber.replaceAll(RegExp(r'\D'), '');
    final exp = expiry.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 12 || exp.length < 4) throw Exception('Invalid card details');

    await _db.from('saved_cards').insert({
      'user_id': uid,
      'cardholder': cardholder,
      'brand': _brand(digits),
      'last4': digits.substring(digits.length - 4),
      'expiry_month': int.parse(exp.substring(0, 2)),
      'expiry_year': 2000 + int.parse(exp.substring(2, 4)),
    });
  }

  Future<List<Map<String, dynamic>>> fetchCards() async {
    final rows = await _db.from('saved_cards').select().order('created_at');
    return List<Map<String, dynamic>>.from(rows);
  }
}