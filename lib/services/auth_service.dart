import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService{
  final SupabaseClient _supabase= Supabase.instance.client; 

  //Sign in with email and password
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    //if (response.error != null) {
    //  throw Exception(response.error!.message);
    //}
  } 


//sign up with email and password

  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    //if (response.error != null) {
    //  throw Exception(response.error!.message);
    //}
  }
// sign out
  Future<void> signOut() async {
    return await _supabase.auth.signOut();

    //if (response.error != null) {
    //  throw Exception(response.error!.message);
    //}
  }

}