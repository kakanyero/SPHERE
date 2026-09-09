import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:sphere/models/address_model.dart';
import 'address_map_screen.dart';
import 'address_form_screen.dart';

/// Lists saved addresses with set-default / delete actions, and an
/// "Add New Address" button that opens the map pin-drop flow.
class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  Future<void> _addNewAddress() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(builder: (_) => const AddressMapScreen()),
    );
    if (pickedLocation == null || !mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddressFormScreen(
          location: pickedLocation,
          // TODO: swap in real reverse-geocoded address text.
          detectedAddress:
              '${pickedLocation.latitude.toStringAsFixed(5)}, ${pickedLocation.longitude.toStringAsFixed(5)}',
        ),
      ),
    );
    setState(() {}); // refresh list after returning
  }

  void _delete(String id) {
    setState(() => AddressRepository.instance.remove(id));
  }

  void _setDefault(String id) {
    setState(() => AddressRepository.instance.setDefault(id));
  }

  IconData _iconFor(AddressLabel label) {
    switch (label) {
      case AddressLabel.home:
        return Icons.home_outlined;
      case AddressLabel.office:
        return Icons.business_outlined;
      case AddressLabel.other:
        return Icons.place_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final addresses = AddressRepository.instance.all;
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Shipping Address', style: TextStyle(color: Colors.black87)),
      ),
      body: addresses.isEmpty
          ? Center(
              child: Text('No saved addresses yet', style: TextStyle(color: Colors.grey.shade500)),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: addresses.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F7),
                    borderRadius: BorderRadius.circular(16),
                    border: address.isDefault
                        ? Border.all(color: primary, width: 1.5)
                        : null,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(_iconFor(address.label), color: primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  address.labelText,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                if (address.isDefault) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primary.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Default',
                                      style: TextStyle(fontSize: 10, color: primary, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              address.fullAddress,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                if (!address.isDefault)
                                  TextButton(
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                    onPressed: () => _setDefault(address.id),
                                    child: const Text('Set as default', style: TextStyle(fontSize: 12)),
                                  ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                                  onPressed: () => _delete(address.id),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _addNewAddress,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add New Address', style: TextStyle(fontSize: 15, color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
