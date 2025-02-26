import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/info/cities/view_models/cities.viewmodel.dart';
import 'package:orient/info/countries/view_models/countries.viewmodel.dart';
import 'package:orient/info/states/view_models/states.viewmodel.dart';
import 'package:orient/merchant/stores/widgets/city_drop_down_widget.dart';
import 'package:orient/merchant/stores/widgets/country_drop_down_widget.dart';
import 'package:orient/merchant/stores/widgets/state_drop_down_widget.dart';
import 'package:orient/models/info/country_model.dart';
import 'package:orient/models/info/state_model.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/validation_service.dart';
import '../view_models/create_account.viewmodel.dart';
import 'widgets/phone_number_field.dart';
import 'widgets/switch_row_widget.dart';

class CreateAccountModal extends StatefulWidget {
  const CreateAccountModal({super.key});

  @override
  State<CreateAccountModal> createState() => _CreateAccountModalState();
}

class _CreateAccountModalState extends State<CreateAccountModal> {
  bool _obscureText = true;
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
  String? countryId;
  String? cityId;
  String? stateId;
  @override
  void initState() {
    super.initState();
    if(CacheHelper.getString("role") == "merchant")countriesViewModel = CountriesViewModel();
    if(CacheHelper.getString("role") == "merchant")statesViewModel = StatesViewModel();
    if(CacheHelper.getString("role") == "merchant")citiesViewModel = CitiesViewModel();
  }
  @override
  void didChangeDependencies() {
    if(CacheHelper.getString("role") == "merchant"){
      countriesViewModel.initializeCountries(context).then((_) {
        var country ;
        if(LocalizationService.isArabic(context: context)){
          country = countriesViewModel.countries
              .firstWhere((element) => element.title?.toLowerCase() ==  'مصر');
        }else{
          country = countriesViewModel.countries
              .firstWhere((element) => element.title?.toLowerCase() ==  'egypt');
        }
        countrySelected.value = country.title;
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
    if(CacheHelper.getString("role") == "merchant"){
      toggleCountrySelected.dispose();
      toggleStateSelected.dispose();
      countrySelected.dispose();
      stateSelected.dispose();
      areCountriesLoaded.dispose();
    }
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
    countryId = element.id.toString();
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
    citiesViewModel.initializeCities(context, element.id ?? 0).then((_) {
      citySelected.value = null;
      toggleStateSelected.value = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateAccountViewModel>(
        create: (_) => CreateAccountViewModel(),
        child: Consumer<CreateAccountViewModel>(
            builder: (context, viewModel, child) {
          return Form(
            key: viewModel.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH20,
                PhoneNumberField(
                  controller: viewModel.phoneController,
                  countryCodeController: viewModel.countryCodeController,
                ),
                // gapH4,
                // SwitchRow(
                //   value: false,
                //   onChanged: (newValue) => setState(() {}),
                //   leftText: AppStrings.smsActive.tr(),
                //   rightText: AppStrings.whatsAppActive.tr(),
                // ),
                gapH20,
                TextFormField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                    hintText: AppStrings.yourEmail.tr(),
                  ),
                ),
                gapH20,
                TextFormField(
                  controller: viewModel.passwordController,
                  decoration: InputDecoration(
                    hintText: AppStrings.password.tr().toUpperCase(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) =>
                      ValidationService.validatePassword(value, login: false),
                  obscureText: _obscureText,
                ),
                gapH20,
                TextFormField(
                  controller: viewModel.nameController,
                  decoration: InputDecoration(
                    hintText: AppStrings.yourName.tr(),
                  ),
                  validator: (val) => ValidationService.validateRequired(val),
                ),
                gapH20,
                if(CacheHelper.getString("role") == "merchant") TextFormField(
                  controller: viewModel.locationAddressController,
                  decoration: InputDecoration(
                    hintText: AppStrings.address.tr(),
                  ),
                  validator: (val) => ValidationService.validateRequired(val),
                ),
                if(CacheHelper.getString("role") == "merchant")  gapH20,
                if(CacheHelper.getString("role") == "merchant") TextFormField(
                  controller: viewModel.nationalIdController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: AppStrings.nationalId.tr(),
                  ),
                  validator: (val) => ValidationService.validateRequired(val),
                ),
                if(CacheHelper.getString("role") == "merchant")  gapH20,
                if(CacheHelper.getString("role") == "merchant") TextFormField(
                  controller: viewModel.assignedByController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: AppStrings.assignedBy.tr(),
                  ),
                ),
                if(CacheHelper.getString("role") == "merchant")  gapH20,
                if(CacheHelper.getString("role") == "merchant") ValueListenableBuilder(
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
                if(CacheHelper.getString("role") == "merchant")  gapH20,
                if(CacheHelper.getString("role") == "merchant") ValueListenableBuilder(
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
                if(CacheHelper.getString("role") == "merchant")   gapH20,
                if(CacheHelper.getString("role") == "merchant") ValueListenableBuilder(
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
                Container(
                  height: 55,
                  alignment: LocalizationService.isArabic(context: context)
                      ?Alignment.centerRight : Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: AppSizes.s10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: ShapeDecoration(
                    color: AppThemeService.colorPalette.tertiaryColorBackground.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.s8),
                      side: const BorderSide(
                        color: Color(0xffE3E5E5),
                        width: 1.0,
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 10,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Directionality(
                    textDirection: LocalizationService.isArabic(context: context)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Text(
                         "${CacheHelper.getString("role")}".tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color:const Color(0xff000000)
                              .withOpacity(0.74)),
                    ),
                  ),
                ),
                gapH28,
                Center(
                    child: CustomElevatedButton(
                        isPrimaryBackground: false,
                        title: AppStrings.create.tr(),
                        onPressed: () async =>
                            viewModel.createAccount(context: context,
                            stateId: stateId,
                              cityId: cityId,
                              countryId: countryId
                            ))),
                gapH32,
              ],
            ),
          );
        }));
  }
}
