enum AddressLabel { home, office, other }

class Address {
  final String id;
  final AddressLabel label;
  final String fullAddress;
  final double latitude;
  final double longitude;
  final bool isDefault;

  const Address({
    required this.id,
    required this.label,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    this.isDefault = false,
  });

  String get labelText {
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

/// TODO: replace with a real ChangeNotifier-backed repository (mirroring
/// your CartModel singleton pattern) persisted via API or local storage.
class AddressRepository {
  AddressRepository._();
  static final AddressRepository instance = AddressRepository._();

  final List<Address> _addresses = [
    const Address(
      id: 'addr_1',
      label: AddressLabel.home,
      fullAddress: '221B Baker Street, Kampala, Uganda',
      latitude: 0.3476,
      longitude: 32.5825,
      isDefault: true,
    ),
    const Address(
      id: 'addr_2',
      label: AddressLabel.office,
      fullAddress: 'Plot 14 Nakasero Road, Kampala, Uganda',
      latitude: 0.3163,
      longitude: 32.5822,
    ),
  ];

  List<Address> get all => List.unmodifiable(_addresses);

  void add(Address address) => _addresses.add(address);

  void remove(String id) => _addresses.removeWhere((a) => a.id == id);

  void setDefault(String id) {
    for (var i = 0; i < _addresses.length; i++) {
      final a = _addresses[i];
      _addresses[i] = Address(
        id: a.id,
        label: a.label,
        fullAddress: a.fullAddress,
        latitude: a.latitude,
        longitude: a.longitude,
        isDefault: a.id == id,
      );
    }
  }
}
