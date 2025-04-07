import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
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
import 'package:orient/modules/home/view_models/user_cont.dart';
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
  bool? checkout = true;
  bool? addAddress = true;
  bool addAdress = true;
  CreateEditAddressScreen({super.key,
      this.id,
      this.userAddressModel,
      this.countryIdModel,
      this.countryCodeModel,
      this.phoneModel,
    this.checkout,
    this.addAddress,
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
        //final state = statesViewModel.states.firstWhere((element) => element.id == widget.stateIdModel);
        countrySelected.value = country.title;
        countryId = country.id.toString();
        countryCode = country.phoneCode.toString();
        statesViewModel.initializeStates(context, country.iso2 ?? '').then((_) {
          toggleCountrySelected.value = true;
          final state = statesViewModel.states.firstWhere((element) => element.id == widget.stateIdModel);
          stateSelected.value = state.title;
          stateId = state.id.toString();
          toggleStateSelected.value = true;
          citiesViewModel.initializeCities(context, state.id ?? 0).then((_) {
            final city = citiesViewModel.cities.firstWhere((element) => element.id == widget.cityIdModel);
            citySelected.value = city.title;
            cityId = city.id.toString();
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
          print("SUCCESS");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            value.isAddAddressSuccess = false;
            value.isUpdateAddressSuccess = false;
          });
        }if(value.isSuccess == true){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            value.isSuccess = false;
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
              defaultTextFormField(context: context,hintText: "*${AppStrings.address.tr()}".toUpperCase(), containerHeight: 50, controller:addressController),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                valueListenable: areCountriesLoaded,
                builder: (context, isSelected, child) {
                  return CountryDropDownWidget(
                    countrySelected: countrySelected,
                    title: "*${AppStrings.country.tr()}",
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
                    title: "*${AppStrings.governorate.tr()}",
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
                    title: "*${AppStrings.city.tr()}",
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
              if(value.isAddAddressLoading || value.isUpdateAddressLoading || value.isLoading)const CircularProgressIndicator(),
              if(!value.isAddAddressLoading && !value.isUpdateAddressLoading && !value.isLoading) Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ButtonWidget(
                    onPressed: (){
                      print(widget.addAdress);
                      if(widget.addAdress == true){
                        print("object object object object");
                        if (phoneController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: AppStrings.phoneNumberIsRequired.tr(),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          return;
                        }if (addressController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: AppStrings.addressIsRequired.tr(),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          return;
                        }
                        if (countrySelected.value == null) {
                          Fluttertoast.showToast(
                              msg: AppStrings.countryIsRequired.tr(),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          return;
                        }if (citySelected.value == null) {
                          Fluttertoast.showToast(
                              msg: AppStrings.cityIsRequired.tr(),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          return;
                        }if (stateSelected.value == null) {
                          Fluttertoast.showToast(
                              msg: AppStrings.stateIsRequired.tr(),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          return;
                        }
                        value.addAddressCheckout(
                            context: context,
                            phone: phoneController.text,
                            address: addressController.text,
                            user_id: UserSettingConst.userSettings!.userId,
                            state_id: stateId.toString(),
                            city_id: cityId.toString(),
                            country_key: countryCode.toString(),
                            country_id: countryId.toString()
                        );
                      }
                      if(widget.addAdress == false){
                        print(phoneController.text);
                        print(addressController.text);
                        print(UserSettingConst.userSettings!.userId);
                        print(stateId.toString());
                        print(cityId.toString());
                        print(countryCode.toString());
                        print(countryId.toString());
                        print(countryCodeController.text );
                        print(widget.countryIdModel);
                        print(widget.id);
                        if(widget.addAddress == true){
                          if (phoneController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: AppStrings.phoneNumberIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }if (addressController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: AppStrings.addressIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          if (countrySelected.value == null) {
                            Fluttertoast.showToast(
                                msg: AppStrings.countryIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }if (citySelected.value == null) {
                            Fluttertoast.showToast(
                                msg: AppStrings.cityIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }if (stateSelected.value == null) {
                            Fluttertoast.showToast(
                                msg: AppStrings.stateIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          value.addAddressCheckout(
                            context: context,
                            phone: phoneController.text,
                            address: addressController.text,
                            user_id: UserSettingConst.userSettings!.userId,
                            state_id: stateId.toString(),
                            city_id: cityId.toString(),
                            country_key: (countryCode != null)? countryCode.toString() : countryCodeController.text ,
                            country_id: (countryId != null) ? countryId.toString() : widget.countryIdModel,
                          );
                        }
                        if (widget.checkout == true) {
                          if (phoneController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: AppStrings.phoneNumberIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }if (addressController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: AppStrings.addressIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          if (countrySelected.value == null) {
                            Fluttertoast.showToast(
                                msg: AppStrings.countryIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }if (citySelected.value == null) {
                            Fluttertoast.showToast(
                                msg: AppStrings.cityIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }if (stateSelected.value == null) {
                            Fluttertoast.showToast(
                                msg: AppStrings.stateIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          value.updateAddressCheckout(
                              context: context,
                              phone: phoneController.text,
                              address: addressController.text,
                              user_id: UserSettingConst.userSettings!.userId,
                              state_id: stateId.toString(),
                              city_id: cityId.toString(),
                              country_key: (countryCode != null)? countryCode.toString() : countryCodeController.text ,
                              country_id: (countryId != null) ? countryId.toString() : widget.countryIdModel,
                              id: widget.id
                          );}else{
                          if (phoneController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: AppStrings.phoneNumberIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }if (addressController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: AppStrings.addressIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          if (countrySelected.value == null) {
                            Fluttertoast.showToast(
                                msg: AppStrings.countryIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }if (citySelected.value == null) {
                            Fluttertoast.showToast(
                                msg: AppStrings.cityIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }if (stateSelected.value == null) {
                            Fluttertoast.showToast(
                                msg: AppStrings.stateIsRequired.tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return;
                          }
                          value.updateShippingAddress(
                              context: context,
                              phone: phoneController.text,
                              address: addressController.text,
                              user_id: UserSettingConst.userSettings!.userId,
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
