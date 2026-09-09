import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:sphere/models/address_model.dart';

/// Collects label + details for a location just picked on AddressMapScreen,
/// then saves it via AddressRepository and pops back to the caller.
class AddressFormScreen extends StatefulWidget {
  final LatLng location;
  final String detectedAddress;

  const AddressFormScreen({
    super.key,
    required this.location,
    required this.detectedAddress,
  });

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _detailsController = TextEditingController();
  AddressLabel _selectedLabel = AddressLabel.home;
  bool _setAsDefault = false;

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  void _save() {
    final address = Address(
      id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
      label: _selectedLabel,
      fullAddress: _detailsController.text.trim().isEmpty
          ? widget.detectedAddress
          : '${_detailsController.text.trim()}, ${widget.detectedAddress}',
      latitude: widget.location.latitude,
      longitude: widget.location.longitude,
      isDefault: _setAsDefault,
    );

    AddressRepository.instance.add(address);
    if (_setAsDefault) {
      AddressRepository.instance.setDefault(address.id);
    }

    Navigator.of(context).pop(address);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Add New Address', style: TextStyle(color: Colors.black87)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(Icons.place_outlined, color: primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.detectedAddress,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Save As', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: AddressLabel.values.map((label) {
              final isSelected = label == _selectedLabel;
              return ChoiceChip(
                label: Text(_labelText(label)),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedLabel = label),
                selectedColor: primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 13,
                ),
                backgroundColor: const Color(0xFFF5F5F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide.none,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Apartment / Suite / Landmark (optional)',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _detailsController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'e.g. Apartment 4B, near the blue gate',
              filled: true,
              fillColor: const Color(0xFFF5F5F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Set as default address', style: TextStyle(fontSize: 14)),
            value: _setAsDefault,
            activeThumbColor: primary,
            onChanged: (v) => setState(() => _setAsDefault = v),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _save,
              child: const Text('Save Address', style: TextStyle(fontSize: 15, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  String _labelText(AddressLabel label) {
    switch (label) {
      case AddressLabel.home:
        return 'Home';
      case AddressLabel.office:
        return 'Office';
      case AddressLabel.other:
        return 'Other';
    }
  }
}
