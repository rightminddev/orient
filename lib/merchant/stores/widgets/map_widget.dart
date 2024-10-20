import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/general_services/validation_service.dart';
import 'package:orient/info/countries/view_models/countries.viewmodel.dart';
import 'package:orient/info/states/view_models/states.viewmodel.dart';
import 'package:orient/models/stores/country_model.dart';
import 'package:orient/models/stores/create_edit_store_model.dart';
import 'package:orient/models/stores/state_model.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/settings/app_icons.dart';
import '../../../info/cities/view_models/cities.viewmodel.dart';

import '../../../modules/authentication/views/widgets/phone_number_field.dart';
import '../../../utils/components/general_components/all_text_field.dart';
import '../../../utils/components/general_components/button_widget.dart';
import '../view_models/stores.create.edit.viewmodel.dart';
import '../widgets/city_drop_down_widget.dart';
import '../widgets/country_drop_down_widget.dart';
import '../widgets/state_drop_down_widget.dart';

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
