import 'package:flutter/material.dart';
//add to pubspec.yaml -> google_maps_flutter: ^2.18.0
// Android: add your Maps API key to android/app/src/main/AndroidManifest.xml
//   <meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_KEY"/>
// iOS: add to ios/Runner/AppDelegate.swift -> GMSServices.provideAPIKey("YOUR_KEY")
// Both platforms also need location permission entries if you use "locate me".
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Uber-style pin-drop map: a fixed center marker overlay that stays put
/// while the map pans underneath it. On Confirm, returns the LatLng
/// (and a placeholder address string) to the caller via Navigator.pop.
class AddressMapScreen extends StatefulWidget {
  final LatLng initialLocation;

  const AddressMapScreen({
    super.key,
    this.initialLocation = const LatLng(0.3476, 32.5825), // Kampala fallback
  });

  @override
  State<AddressMapScreen> createState() => _AddressMapScreenState();
}

class _AddressMapScreenState extends State<AddressMapScreen> {
  GoogleMapController? _mapController;
  late LatLng _centerLocation;
  bool _isMoving = false;

  @override
  void initState() {
    super.initState();
    _centerLocation = widget.initialLocation;
  }

  // TODO: replace with real reverse geocoding (e.g. `geocoding` package
  // or a Places API call) to turn _centerLocation into a readable address.
  String get _placeholderAddress =>
      '${_centerLocation.latitude.toStringAsFixed(5)}, '
      '${_centerLocation.longitude.toStringAsFixed(5)}';

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.initialLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) => _mapController = controller,
            onCameraMoveStarted: () => setState(() => _isMoving = true),
            onCameraMove: (position) => _centerLocation = position.target,
            onCameraIdle: () => setState(() => _isMoving = false),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),

          // Fixed center pin -- offset up so the pin *tip* sits at the
          // true map center rather than the pin's visual middle.
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                transform: Matrix4.translationValues(0, _isMoving ? -8 : 0, 0),
                child: Icon(Icons.location_on, size: 44, color: primary),
              ),
            ),
          ),

          // Back button.
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),

          // Bottom sheet: current address preview + confirm button.
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.place_outlined, color: primary, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _placeholderAddress,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop<LatLng>(_centerLocation);
                        },
                        child: const Text(
                          'Confirm Location',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
