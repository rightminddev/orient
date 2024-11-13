import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/info/cities/view_models/cities.viewmodel.dart';
import 'package:orient/info/countries/view_models/countries.viewmodel.dart';
import 'package:orient/info/states/view_models/states.viewmodel.dart';
import 'package:orient/merchant/stores/widgets/city_drop_down_widget.dart';
import 'package:orient/merchant/stores/widgets/state_drop_down_widget.dart';
import 'package:orient/models/info/city_model.dart';
import 'package:orient/models/info/country_model.dart';
import 'package:orient/models/info/state_model.dart';
import 'package:orient/modules/authentication/views/widgets/phone_number_field.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/modules/ecommerce/checkout/model/get_address_model.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';
import '../../../../merchant/stores/widgets/country_drop_down_widget.dart';

class CreateEditAddressScreen extends StatefulWidget {
  final UserAddressModel? userAddressModel;
  var countryIdModel;
  var countryCodeModel;
  var phoneModel;
  var addressModel;
  var stateIdModel;
  var cityIdModel;
  var id;
  bool addAdress = true;
  CreateEditAddressScreen({super.key,
      this.id,
      this.userAddressModel,
      this.countryIdModel,
      this.countryCodeModel,
      this.phoneModel,
       required this.addAdress,
      this.addressModel,
      this.stateIdModel,
      this.cityIdModel});
  @override
  State<CreateEditAddressScreen> createState() => _CreateEditAddressScreenState();
}

class _CreateEditAddressScreenState extends State<CreateEditAddressScreen> {
  late final CountriesViewModel countriesViewModel;
  late final StatesViewModel statesViewModel;
  late final CitiesViewModel citiesViewModel;
  final ValueNotifier<bool?> areCountriesLoaded = ValueNotifier<bool?>(false);
  final ValueNotifier<bool?> toggleCountrySelected =
  ValueNotifier<bool?>(false);
  final ValueNotifier<bool?> toggleStateSelected = ValueNotifier<bool?>(false);
  final ValueNotifier<String?> countrySelected = ValueNotifier<String?>(null);
  final ValueNotifier<String?> stateSelected = ValueNotifier<String?>(null);
  final ValueNotifier<String?> citySelected = ValueNotifier<String?>(null);
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? countryId;
  String? cityId;
  String? stateId;
  String? countryCode;
  @override
  void initState() {
    super.initState();
    countriesViewModel = CountriesViewModel();
    statesViewModel = StatesViewModel();
    citiesViewModel = CitiesViewModel();
    if(widget.countryCodeModel != null) countryCodeController = TextEditingController(text: (widget.countryCodeModel ?? 0).toString());
    if(widget.phoneModel != null) phoneController = TextEditingController(text: widget.phoneModel.toString());
    if(widget.addressModel != null) addressController = TextEditingController(text: widget.addressModel.toString());
    // if(widget.countryCodeModel != null) countryCode = widget.countryCodeModel;
    // if(widget.countryIdModel != null) countryId = widget.countryIdModel;

  }
  @override
  void didChangeDependencies() {
    if (widget.userAddressModel == null) {
      countriesViewModel.initializeCountries(context).then((_) {
        areCountriesLoaded.value = true;
        final country = countriesViewModel.countries.firstWhere((element) => element.id == widget.countryIdModel);
        countrySelected.value = country.title;
        statesViewModel.initializeStates(context, country.iso2 ?? '').then((_) {
          toggleCountrySelected.value = true;
          final state = statesViewModel.states.firstWhere((element) => element.id == widget.stateIdModel);
          citiesViewModel.initializeCities(context, state.id ?? 0).then((_) {
            CityModel storeCities = CityModel();
          });
        });
      });
    }
    else {
      countriesViewModel.initializeCountries(context).then((_) {
        final country = countriesViewModel.countries
            .firstWhere((element) => element.title?.toLowerCase() == 'egypt');
        countrySelected.value = country.title;
        countryCode = country.phoneCode.toString();
        countryId = country.id.toString();
        areCountriesLoaded.value = true;
        statesViewModel.initializeStates(context, country.iso2 ?? '').then((_) {
          toggleCountrySelected.value = true;
        });
      });
    }
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    toggleCountrySelected.dispose();
    toggleStateSelected.dispose();
    countrySelected.dispose();
    stateSelected.dispose();
    phoneController.dispose();
    addressController.dispose();
    countryCodeController.dispose();
    areCountriesLoaded.dispose();
    super.dispose();
  }

  void setCountryChanged(CountryModel element) {
    toggleCountrySelected.value = false;
    if (citiesViewModel.cities.isNotEmpty) {
      citySelected.value = null;
      toggleStateSelected.value = false;
      citiesViewModel.cities = List.empty(growable: true);
    }
    countrySelected.value = element.title;
    countryCode = element.phoneCode.toString();
    countryId = element.id.toString();
        print("countryCode -> $countryCode");
        print("countryId -> $countryId");
    statesViewModel.initializeStates(context, element.iso2 ?? '').then((_) {
      toggleCountrySelected.value = true;
      stateSelected.value = null;
    });
  }

  void setStateChanged(StateModel element) {
    final beforeToggling = toggleStateSelected.value;
    toggleStateSelected.value = false;
    stateSelected.value = element.title.toString();
    stateId = element.id.toString();
    print("stateSelected.value -> ${stateSelected.value}");
    print("stateId -> ${stateId}");
    print("countryCodeController.text -> ${countryCodeController.text}");
    citiesViewModel.initializeCities(context, element.id ?? 0).then((_) {
      citySelected.value = null;
      toggleStateSelected.value = true;
    });
  }

  bool checkValidation() {
    if (widget.userAddressModel != null) {
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
    return Consumer<CheckoutControllerProvider>(
      builder: (context, value, child) {
      return Consumer<HomeViewModel>(builder:
      (context, values, child) {
        if(value.isAddAddressSuccess == true || value.isUpdateAddressSuccess == true){
          print(value.isUpdateAddressSuccess);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            //Navigator.pop(context);
            value.isAddAddressSuccess = false;
            value.isUpdateAddressSuccess = false;
          });
        }
        return Form(
          key: _formKey,
          child: Column(
            children: [
              PhoneNumberField(
                controller: phoneController,
                countryCodeController: countryCodeController,
              ),
              defaultTextFormField(hintText: AppStrings.address.tr().toUpperCase(), containerHeight: 50, controller:addressController),
              const SizedBox(height: 10),
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
              const SizedBox(height: 18),
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
              const SizedBox(height: 18),
              ValueListenableBuilder(
                valueListenable: toggleStateSelected,
                builder: (context, isSelected, child) {
                  return CityDropDownWidget(
                    isSelected: isSelected,
                    citySelected: citySelected,
                    cities: citiesViewModel.cities,
                    setCityChanged: (element) {
                      citySelected.value = element.title.toString();
                      print("citySelected.value ${citySelected.value}");
                      cityId = element.id.toString();
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              if(value.isAddAddressLoading || value.isUpdateAddressLoading)const CircularProgressIndicator(),
              if(!value.isAddAddressLoading && !value.isUpdateAddressLoading) Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ButtonWidget(
                    onPressed: (){
                      print(widget.addAdress);
                      if(widget.addAdress == true){
                        if(phoneController.text.isNotEmpty &&addressController.text.isNotEmpty&&stateId != null
                            &&cityId != null && countryCode != null && countryId != null
                        ){
                          value.addAddressCheckout(
                              context: context,
                              phone: phoneController.text,
                              address: addressController.text,
                              user_id: values.userSettings!.userId,
                              state_id: stateId.toString(),
                              city_id: cityId.toString(),
                              country_key: countryCode.toString(),
                              country_id: countryId.toString()
                          );
                        }
                      }
                      if(widget.addAdress == false){
                        print(phoneController.text);
                        print(addressController.text);
                        print(values.userSettings!.userId);
                        print(stateId.toString());
                        print(cityId.toString());
                        print(countryCode.toString());
                        print(countryId.toString());
                        print(countryCodeController.text );
                        print(widget.countryIdModel);
                        print(widget.id);
                        if(phoneController.text.isNotEmpty &&addressController.text.isNotEmpty&&stateId != null
                            &&cityId != null && (countryCode != null ||countryCodeController.text.isNotEmpty) &&
                            (countryId != null || widget.countryIdModel != null) && widget.id != null
                        ){
                          value.updateAddressCheckout(
                              context: context,
                              phone: phoneController.text,
                              address: addressController.text,
                              user_id: values.userSettings!.userId,
                              state_id: stateId.toString(),
                              city_id: cityId.toString(),
                              country_key: (countryCode != null)? countryCode.toString() : countryCodeController.text ,
                              country_id: (countryId != null) ? countryId.toString() : widget.countryIdModel,
                            id: widget.id
                          );
                        }
                      }
                    },
                    padding: EdgeInsets.zero,
                    svgIcon: "assets/images/ecommerce/svg/verifiy.svg",
                    title: AppStrings.saveChanges.tr().toUpperCase()
                ),
              )
            ],
          ),
        );
      },
      );
    },);
  }
}
//defaultTextFormField
