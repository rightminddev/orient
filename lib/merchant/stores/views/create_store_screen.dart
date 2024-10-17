import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/info/countries/view_models/countries.viewmodel.dart';
import 'package:orient/info/states/view_models/states.viewmodel.dart';
import 'package:orient/models/stores/country_model.dart';
import 'package:orient/models/stores/create_store_model.dart';
import 'package:orient/models/stores/state_model.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/settings/app_icons.dart';
import '../../../info/cities/view_models/cities.viewmodel.dart';

import '../../../utils/components/general_components/all_text_field.dart';
import '../../../utils/components/general_components/button_widget.dart';
import '../view_models/stores.actions.viewmodel.dart';
import '../widgets/city_drop_down_widget.dart';
import '../widgets/country_drop_down_widget.dart';
import '../widgets/state_drop_down_widget.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({super.key});

  @override
  State<CreateStoreScreen> createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  late final StoreActionsViewModel storeActionsViewModel;
  late final CountriesViewModel countriesViewModel;
  late final StatesViewModel statesViewModel;
  late final CitiesViewModel citiesViewModel;
  final MapController mapController = MapController();
  final ValueNotifier<bool?> toggleCountrySelected = ValueNotifier<bool?>(null);
  final ValueNotifier<bool?> toggleStateSelected = ValueNotifier<bool?>(null);
  final ValueNotifier<bool?> toggleCitySelected = ValueNotifier<bool?>(null);

  final ValueNotifier<String?> countrySelected = ValueNotifier<String?>(null);
  final ValueNotifier<String?> stateSelected = ValueNotifier<String?>(null);
  final ValueNotifier<String?> citySelected = ValueNotifier<String?>(null);
  final ValueNotifier<latLng.LatLng> latLngSelected =
      ValueNotifier<latLng.LatLng>(latLng.LatLng(0, 0));

  final TextEditingController nameEnController = TextEditingController();
  final TextEditingController nameArController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    storeActionsViewModel = StoreActionsViewModel();
    countriesViewModel = CountriesViewModel();
    statesViewModel = StatesViewModel();
    citiesViewModel = CitiesViewModel();
    countriesViewModel.initializeCountries(context);
  }

  @override
  void dispose() {
    toggleCountrySelected.dispose();
    toggleStateSelected.dispose();
    toggleCitySelected.dispose();
    mapController.dispose();
    countrySelected.dispose();
    stateSelected.dispose();
    citySelected.dispose();
    nameEnController.dispose();
    nameArController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void setCountryChanged(CountryModel element) {
    if (element.iso2 != storeActionsViewModel.createStoreModel.countryId) {
      countrySelected.value = element.title;
      storeActionsViewModel.createStoreModel.countryId = element.iso2;
      storeActionsViewModel.createStoreModel.countryKey = element.phoneCode;
      storeActionsViewModel.createStoreModel.stateId = null;
      stateSelected.value = null;
      storeActionsViewModel.createStoreModel.cities =
          List.empty(growable: true);
      statesViewModel.initializeStates(context, element.iso2 ?? '').then((_) {
        toggleCountrySelected.value = toggleCountrySelected.value != null
            ? !toggleCountrySelected.value!
            : true;
      });
    } else {}
  }

  void setStateChanged(StateModel element) {
    if (element.iso2 != storeActionsViewModel.createStoreModel.stateId) {
      stateSelected.value = element.title;
      storeActionsViewModel.createStoreModel.stateId = element.iso2;

      storeActionsViewModel.getPlaceByName(context, element.title!).then((_) {
        toggleStateSelected.value != null
            ? mapController.move(storeActionsViewModel.finalLatLng, 5.0)
            : null;
        latLngSelected.value = storeActionsViewModel.finalLatLng;
        // latLngSelected.value = latLng.LatLng(
        //     double.parse(storeActionsViewModel.mapPlaces
        //             .elementAt(0)
        //             .lat ??
        //         '0'),
        //     double.parse(storeActionsViewModel.mapPlaces
        //             .elementAt(0)
        //             .lon ??
        //         '0'));
      });
      storeActionsViewModel.createStoreModel.cities =
          List.empty(growable: true);
      citiesViewModel.initializeCities(context, element.id ?? 0).then((_) {
        toggleStateSelected.value = toggleStateSelected.value != null
            ? !toggleStateSelected.value!
            : true;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => countriesViewModel,
      child: Consumer<CountriesViewModel>(
        builder: (context, countriesViewModel, child) {
          return TemplatePage(
            backgroundColor: Colors.white,
            pageContext: context,
            title: AppStrings.addStore.tr(),
            bottomSheet: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 11,
                    offset: Offset(0, -4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonWidget(
                    onPressed: () {
                      storeActionsViewModel
                          .getPlaceByLatAndLong(
                        context,
                        latLngSelected.value.latitude,
                        latLngSelected.value.longitude,
                      )
                          .then((value) {
                        if (value == true) {
                          storeActionsViewModel.createStoreModel.name =
                              NameModel(
                            ar: nameArController.text.trim(),
                            en: nameEnController.text.trim(),
                          );
                          storeActionsViewModel.createStoreModel.lat =
                              latLngSelected.value.latitude.toString();
                          storeActionsViewModel.createStoreModel.lng =
                              latLngSelected.value.longitude.toString();
                          storeActionsViewModel.createStoreModel.phoneNumber =
                              phoneController.text.trim();
                          storeActionsViewModel.addStore(context);
                        }
                      });
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s48, vertical: AppSizes.s16),
                    title: "Create store",
                    svgIcon: AppIcons.checkMarkDashed,
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 24),
                defaultTextFormField(
                  controller: nameArController,
                  hintText: "name in arabic",
                ),
                defaultTextFormField(
                  controller: nameEnController,
                  hintText: "name in english",
                ),
                defaultTextFormField(
                  controller: phoneController,
                  hintText: "phone number",
                ),
                CountryDropDownWidget(
                  countrySelected: countrySelected,
                  countries: countriesViewModel.countries,
                  onTap: setCountryChanged,
                ),

                ValueListenableBuilder(
                  valueListenable: toggleCountrySelected,
                  builder: (context, isSelected, child) {
                    return StateDropDownWidget(
                      stateSelected: stateSelected,
                      states: statesViewModel.states,
                      isSelected: isSelected,
                      onTap: setStateChanged,
                    );
                  },
                ),

                ValueListenableBuilder(
                  valueListenable: toggleStateSelected,
                  builder: (context, isSelected, child) {
                    return CityDropDownWidget(
                      isSelected: isSelected,
                      citiesSelected: citySelected,
                      cities: citiesViewModel.cities,
                      onListChanged: (element) {
                        storeActionsViewModel.createStoreModel.cities = element;
                      },
                    );
                  },
                ),
                //Kl5szmd17siMI3P1iIb4gqz_wld1388qWUq88pgIU4Q
                ValueListenableBuilder(
                  valueListenable: toggleStateSelected,
                  builder: (context, isSelected, child) {
                    return isSelected != null //    latLngSelected.value
                        ? ValueListenableBuilder(
                            valueListenable: latLngSelected,
                            builder: (context, positionSelected, child) {
                              return SizedBox(
                                height: 250,
                                child: FlutterMap(
                                  mapController: mapController,
                                  options: MapOptions(
                                    initialCenter: positionSelected,
                                    initialZoom: 5.0,
                                    onTap: (_, latlong) {
                                      latLngSelected.value = latlong;
                                      // mapController.move(latlong, 5.0);
                                    },
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      subdomains: ['a', 'b', 'c'],
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          width: 20.0,
                                          height: 20.0,
                                          point: positionSelected,
                                          child: FlutterLogo(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
//defaultTextFormField
