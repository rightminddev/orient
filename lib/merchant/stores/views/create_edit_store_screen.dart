import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/validation_service.dart';
import 'package:orient/info/countries/view_models/countries.viewmodel.dart';
import 'package:orient/info/states/view_models/states.viewmodel.dart';
import 'package:orient/models/info/city_model.dart';
import 'package:orient/models/info/country_model.dart';
import 'package:orient/models/stores/create_edit_store_model.dart';
import 'package:orient/models/info/state_model.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map/flutter_map.dart';
import 'package:orient/models/stores/store_model.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_strings.dart';
import '../../../info/cities/view_models/cities.viewmodel.dart';

import '../../../modules/authentication/views/widgets/phone_number_field.dart';
import '../../../utils/components/general_components/all_text_field.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../view_models/stores.create.edit.viewmodel.dart';
import '../widgets/city_drop_down_widget.dart';
import '../widgets/country_drop_down_widget.dart';
import '../widgets/custom_bottom_sheet_for_create_edit_store.dart';
import '../widgets/map_widget.dart';
import '../widgets/state_drop_down_widget.dart';

class CreateEditStoreScreen extends StatefulWidget {
  final StoreModel? storeModel;
  const CreateEditStoreScreen({super.key, this.storeModel});

  @override
  State<CreateEditStoreScreen> createState() => _CreateEditStoreScreenState();
}

class _CreateEditStoreScreenState extends State<CreateEditStoreScreen> {
  late final StoreCreateEditModel storeCreateEditModel;
  late final CountriesViewModel countriesViewModel;
  late final StatesViewModel statesViewModel;
  late final CitiesViewModel citiesViewModel;
  final MapController mapController = MapController();
  final ValueNotifier<bool?> areCountriesLoaded = ValueNotifier<bool?>(false);
  final ValueNotifier<bool?> toggleCountrySelected =
      ValueNotifier<bool?>(false);
  final ValueNotifier<bool?> toggleStateSelected = ValueNotifier<bool?>(false);
  final initialZoom = 2.0;

  final ValueNotifier<String?> countrySelected = ValueNotifier<String?>(null);
  final ValueNotifier<String?> stateSelected = ValueNotifier<String?>(null);
  final ValueNotifier<String?> citySelected = ValueNotifier<String?>(null);

  final ValueNotifier<latLng.LatLng> latLngSelected =
      ValueNotifier<latLng.LatLng>(latLng.LatLng(0, 0));
  late final TextEditingController countryCodeController;
  late final TextEditingController nameEnController;
  late final TextEditingController nameArController;
  late final TextEditingController phoneController;
  List<String> initialCitiesSelected = List.empty(growable: true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? countryCode;
  @override
  void initState() {
    super.initState();
    storeCreateEditModel = StoreCreateEditModel();
    countriesViewModel = CountriesViewModel();
    statesViewModel = StatesViewModel();
    citiesViewModel = CitiesViewModel();
    if (widget.storeModel != null) {
      countryCodeController = TextEditingController(
          text: (widget.storeModel?.countryKey ?? 0).toString());
      nameEnController = TextEditingController(text: widget.storeModel!.name);
      nameArController = TextEditingController(text: widget.storeModel!.name);
      phoneController = TextEditingController(
          text: widget.storeModel!.phoneNumber.toString());

      storeCreateEditModel.createEditStoreModel.id = widget.storeModel!.id;
      storeCreateEditModel.createEditStoreModel.name = NameModel(
        ar: nameArController.text.trim(),
        en: nameEnController.text.trim(),
      );
      storeCreateEditModel.createEditStoreModel.lat = widget.storeModel!.lat;
      storeCreateEditModel.createEditStoreModel.lng = widget.storeModel!.lng;

      storeCreateEditModel.createEditStoreModel.countryKey =
          widget.storeModel!.countryKey;
      storeCreateEditModel.createEditStoreModel.phoneNumber =
          widget.storeModel!.phoneNumber.toString();

      latLngSelected.value = latLng.LatLng(
          double.parse(widget.storeModel!.lat ?? '0'),
          double.parse(widget.storeModel!.lng ?? '0'));
    } else {
      countryCodeController = TextEditingController(text: '+20');
      nameEnController = TextEditingController();
      nameArController = TextEditingController();
      phoneController = TextEditingController();

      storeCreateEditModel.createEditStoreModel.name = NameModel(
        ar: nameArController.text.trim(),
        en: nameEnController.text.trim(),
      );
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.storeModel != null) {
      countriesViewModel.initializeCountries(context).then((_) {
        areCountriesLoaded.value = true;
        final country = countriesViewModel.countries.firstWhere(
            (element) => element.id == widget.storeModel!.countryId);
        countrySelected.value = country.title;
        storeCreateEditModel.createEditStoreModel.countryId =
            (country.id ?? 0).toString();
        statesViewModel.initializeStates(context, country.iso2 ?? '').then((_) {
          toggleCountrySelected.value = true;
          final state = statesViewModel.states.firstWhere(
              (element) => element.id == widget.storeModel!.stateId);
          stateSelected.value = state.title;
          storeCreateEditModel.createEditStoreModel.stateId =
              (state.id ?? 0).toString();
          citiesViewModel.initializeCities(context, state.id ?? 0).then((_) {
            CityModel storeCities = CityModel();
            final cities = citiesViewModel.cities;

            storeCities = cities
                .firstWhere((city) => widget.storeModel?.cityId == city.id);

            // storeCreateEditModel.createEditStoreModel.cityId = storeCities
            //     .map((element) => (element.id ?? 0).toString())
            //     .toList();
            // initialCitiesSelected = storeCities
            //     .map((element) => (element.title ?? 0).toString())
            //     .toList();
            citySelected.value = storeCities.title;
            toggleStateSelected.value = true;
          });
        });
      });
    } else {
      countriesViewModel.initializeCountries(context).then((_) {
        areCountriesLoaded.value = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    toggleCountrySelected.dispose();
    toggleStateSelected.dispose();
    mapController.dispose();
    countrySelected.dispose();
    stateSelected.dispose();
    nameEnController.dispose();
    nameArController.dispose();
    phoneController.dispose();
    countryCodeController.dispose();
    areCountriesLoaded.dispose();
    super.dispose();
  }

  void setCountryChanged(CountryModel element) {
    if (element.iso2 != storeCreateEditModel.createEditStoreModel.countryId) {
      toggleCountrySelected.value = false;
      if (citiesViewModel.cities.isNotEmpty) {
        citySelected.value = null;
        toggleStateSelected.value = false;
        citiesViewModel.cities = List.empty(growable: true);
      }

      storeCreateEditModel.createEditStoreModel.cityId = null;
      countrySelected.value = element.title;
      storeCreateEditModel.createEditStoreModel.countryId =
          (element.id ?? 0).toString();
      countryCode = element.phoneCode;
      storeCreateEditModel.createEditStoreModel.stateId = null;

      statesViewModel.initializeStates(context, element.iso2 ?? '').then((_) {
        toggleCountrySelected.value = true;
        stateSelected.value = null;
        storeCreateEditModel.createEditStoreModel.stateId = null;
        storeCreateEditModel.createEditStoreModel.cityId = null;

        // toggleCountrySelected.value = toggleCountrySelected.value != null
        //     ? !toggleCountrySelected.value!
        //     : true;

        // toggleStateSelected.value = citiesViewModel.cities.isEmpty
        //     ? null
        //     : toggleStateSelected.value != null
        //         ? !toggleStateSelected.value!
        //         : true;
      });
    } else {}
  }

  void setStateChanged(StateModel element) {
    if (element.iso2 != storeCreateEditModel.createEditStoreModel.stateId) {
      final beforeToggling = toggleStateSelected.value;
      toggleStateSelected.value = false;

      stateSelected.value = element.title;
      storeCreateEditModel.createEditStoreModel.stateId =
          (element.id ?? 0).toString();

      storeCreateEditModel.getPlaceByName(context, element.title!).then((_) {
        beforeToggling != false
            ? mapController.move(storeCreateEditModel.finalLatLng, initialZoom)
            : null;
        latLngSelected.value = storeCreateEditModel.finalLatLng;
      });
      storeCreateEditModel.createEditStoreModel.cityId = null;
      citiesViewModel.initializeCities(context, element.id ?? 0).then((_) {
        citySelected.value = null;
        toggleStateSelected.value = true;
        storeCreateEditModel.createEditStoreModel.cityId = null;
      });
    } else {}
  }

  bool checkValidation() {
    if (widget.storeModel != null) {
      return true;
    } else {
      if (countryCode == int.parse(countryCodeController.text.substring(1))) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      backgroundColor: Colors.white,
      pageContext: context,
      title: widget.storeModel != null
          ? AppStrings.editStore.tr()
          : AppStrings.addStore.tr(),
      bottomSheet: ChangeNotifierProvider(
        create: (_) => storeCreateEditModel,
        child: Consumer<StoreCreateEditModel>(
          builder: (context, viewModel, child) {
            return CustomBottomSheetForCreateEditStore(
              onPressed: () {
                if (_formKey.currentState!.validate() && checkValidation()) {
                  storeCreateEditModel
                      .getPlaceByLatAndLong(
                    context,
                    latLngSelected.value.latitude,
                    latLngSelected.value.longitude,
                  )
                      .then((value) {
                    if (value == true) {
                      storeCreateEditModel.createEditStoreModel.name =
                          NameModel(
                        ar: nameArController.text.trim(),
                        en: nameEnController.text.trim(),
                      );
                      storeCreateEditModel.createEditStoreModel.lat =
                          latLngSelected.value.latitude.toString();
                      storeCreateEditModel.createEditStoreModel.lng =
                          latLngSelected.value.longitude.toString();

                      storeCreateEditModel.createEditStoreModel.countryKey =
                          int.parse(countryCodeController.text.trim());
                      storeCreateEditModel.createEditStoreModel.phoneNumber =
                          phoneController.text.trim();
                      widget.storeModel != null
                          ? storeCreateEditModel.updateStore(context)
                          : storeCreateEditModel.addStore(context);
                    }
                  });
                } else {
                  AlertsService.warning(
                    context: context,
                    message: AppStrings.formIsInvalid.tr(),
                    title: AppStrings.formValidation.tr(),
                  );
                }
              },
              isLoading: viewModel.isLoading,
              title: widget.storeModel != null
                  ? AppStrings.editStore.tr()
                  : AppStrings.createStore.tr(),
            );
          },
        ),
      ),
      body: GradientBgImage(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SizedBox(height: 24),
                defaultTextFormField(
                  controller: nameArController,
                  hintText: AppStrings.storeNameInArabic.tr(),
                  validator: ValidationService.validateRequired,
                ),
                SizedBox(height: 18),
                defaultTextFormField(
                  controller: nameEnController,
                  hintText: AppStrings.storeNameInEnglish.tr(),
                  validator: ValidationService.validateRequired,
                ),
                SizedBox(height: 18),
                PhoneNumberField(
                  controller: phoneController,
                  countryCodeController: countryCodeController,
                ),
                SizedBox(height: 18),
                ValueListenableBuilder(
                  valueListenable: areCountriesLoaded,
                  builder: (context, isSelected, child) {
                    return CountryDropDownWidget(
                      countrySelected: countrySelected,
                      countries: countriesViewModel.countries,
                      isSelected: isSelected,
                      onTap: setCountryChanged,
                    );
                  },
                ),
                SizedBox(height: 18),
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
                SizedBox(height: 18),
                ValueListenableBuilder(
                  valueListenable: toggleStateSelected,
                  builder: (context, isSelected, child) {
                    return CityDropDownWidget(
                      isSelected: isSelected,
                      citySelected: citySelected,
                      cities: citiesViewModel.cities,
                      setCityChanged: (element) {
                        storeCreateEditModel.createEditStoreModel.cityId =
                            (element.id ?? 0).toString();
                        citySelected.value = element.title;

                        // storeCreateEditModel.createEditStoreModel.cities =
                        //     element;
                      },
                    );
                  },
                ),
                SizedBox(height: 18),
                ValueListenableBuilder(
                  valueListenable: toggleStateSelected,
                  builder: (context, isSelected, child) {
                    return isSelected == true //    latLngSelected.value
                        ? ValueListenableBuilder(
                            valueListenable: latLngSelected,
                            builder: (context, positionSelected, child) {
                              return MapWidget(
                                mapController: mapController,
                                positionSelected: positionSelected,
                                initialZoom: initialZoom,
                                onMapTap: (_, latlong) {
                                  latLngSelected.value = latlong;
                                  // mapController.move(latlong, 5.0);
                                },
                              );
                            },
                          )
                        : SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//defaultTextFormField
