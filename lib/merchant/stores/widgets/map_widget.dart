import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map/flutter_map.dart';


class MapWidget extends StatelessWidget {
  final MapController mapController;
  final latLng.LatLng positionSelected;
  final double initialZoom;
  final void Function(TapPosition, latLng.LatLng) onMapTap;
  const MapWidget({
    super.key,
    required this.mapController,
    required this.positionSelected,
    required this.initialZoom,
    required this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: positionSelected,
          initialZoom: initialZoom,
          onTap: onMapTap,

          // (_, latlong) {
          //   latLngSelected.value = latlong;
          //   // mapController.move(latlong, 5.0);
          // },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                // width: 20.0,
                // height: 20.0,
                point: positionSelected,
                child: Icon(
                  Icons.location_pin,
                  color: Color(AppColors.red1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
