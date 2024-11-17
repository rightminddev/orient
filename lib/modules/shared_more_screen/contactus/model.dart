class GeneralSettings {
  final bool status;
  final GeneralData data;

  GeneralSettings({required this.status, required this.data});

  factory GeneralSettings.fromJson(Map<String, dynamic> json) {
    return GeneralSettings(
      status: json['status'],
      data: GeneralData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class GeneralData {
  final String lastUpdateDate;
  final int itemPerPage;
  final dynamic popup;
  final String mandatoryUpdatesAlertBuild;
  final String mandatoryUpdatesEndBuild;
  final StoreUrl storeUrl;
  final List<GeneralMessageByScreen> generalMessageByScreen;
  final Features features;
  final Appearance appearance;
  final CompanyContacts companyContacts;
  final List<String> availableLang;
  final bool visitorsCreateOrder;
  final bool isStoreActive;
  final dynamic checkCartPrepareMin;
  final List<String> weekends;
  final List<Holiday> holidays;
  final WorkTime worktime;
  final Map<String, RequestType> requestTypes;
  final bool fingerprintMustUploadImage;
  final bool fpScanSteps;
  final Currency defaultCurrency;
  final List<Currency> supportedCurrencies;
  final Country defaultCountry;
  final List<Country> supportedCountries;
  final String timezone;
  final List<WebService> webServices;
  final List<Classification> classifications;
  final bool canNewRegister;
  final bool canVisit;
  final List<String> loginTypes;

  GeneralData({
    required this.lastUpdateDate,
    required this.itemPerPage,
    this.popup,
    required this.mandatoryUpdatesAlertBuild,
    required this.mandatoryUpdatesEndBuild,
    required this.storeUrl,
    required this.generalMessageByScreen,
    required this.features,
    required this.appearance,
    required this.companyContacts,
    required this.availableLang,
    required this.visitorsCreateOrder,
    required this.isStoreActive,
    this.checkCartPrepareMin,
    required this.weekends,
    required this.holidays,
    required this.worktime,
    required this.requestTypes,
    required this.fingerprintMustUploadImage,
    required this.fpScanSteps,
    required this.defaultCurrency,
    required this.supportedCurrencies,
    required this.defaultCountry,
    required this.supportedCountries,
    required this.timezone,
    required this.webServices,
    required this.classifications,
    required this.canNewRegister,
    required this.canVisit,
    required this.loginTypes,
  });

  factory GeneralData.fromJson(Map<String, dynamic> json) {
    return GeneralData(
      lastUpdateDate: json['last_update_date'],
      itemPerPage: json['item_per_page'],
      popup: json['popup'],
      mandatoryUpdatesAlertBuild: json['mandatory_updates_alert_build'],
      mandatoryUpdatesEndBuild: json['mandatory_updates_end_build'],
      storeUrl: StoreUrl.fromJson(json['store_url']),
      generalMessageByScreen: (json['general_message_by_screen'] as List)
          .map((e) => GeneralMessageByScreen.fromJson(e))
          .toList(),
      features: Features.fromJson(json['features']),
      appearance: Appearance.fromJson(json['appearance']),
      companyContacts: CompanyContacts.fromJson(json['company_contacts']),
      availableLang: List<String>.from(json['available_lang']),
      visitorsCreateOrder: json['visitors_create_order'],
      isStoreActive: json['is_store_active'],
      checkCartPrepareMin: json['check_cart_prepare_min'],
      weekends: List<String>.from(json['weekends']),
      holidays: (json['holidays'] as List)
          .map((e) => Holiday.fromJson(e))
          .toList(),
      worktime: WorkTime.fromJson(json['worktime']),
      requestTypes: (json['request_types'] as Map)
          .map((key, value) =>
          MapEntry(key, RequestType.fromJson(value))),
      fingerprintMustUploadImage: json['fingerprint_must_upload_image'],
      fpScanSteps: json['fp_scan_steps'],
      defaultCurrency: Currency.fromJson(json['default_currency']),
      supportedCurrencies: (json['supported_currencies'] as List)
          .map((e) => Currency.fromJson(e))
          .toList(),
      defaultCountry: Country.fromJson(json['default_country']),
      supportedCountries: (json['supported_countries'] as List)
          .map((e) => Country.fromJson(e))
          .toList(),
      timezone: json['timezone'],
      webServices: (json['web_services'] as List)
          .map((e) => WebService.fromJson(e))
          .toList(),
      classifications: (json['classifications'] as List)
          .map((e) => Classification.fromJson(e))
          .toList(),
      canNewRegister: json['can_new_register'],
      canVisit: json['can_visit'],
      loginTypes: List<String>.from(json['login_types']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_update_date': lastUpdateDate,
      'item_per_page': itemPerPage,
      'popup': popup,
      'mandatory_updates_alert_build': mandatoryUpdatesAlertBuild,
      'mandatory_updates_end_build': mandatoryUpdatesEndBuild,
      'store_url': storeUrl.toJson(),
      'general_message_by_screen': generalMessageByScreen
          .map((e) => e.toJson())
          .toList(),
      'features': features.toJson(),
      'appearance': appearance.toJson(),
      'company_contacts': companyContacts.toJson(),
      'available_lang': availableLang,
      'visitors_create_order': visitorsCreateOrder,
      'is_store_active': isStoreActive,
      'check_cart_prepare_min': checkCartPrepareMin,
      'weekends': weekends,
      'holidays': holidays.map((e) => e.toJson()).toList(),
      'worktime': worktime.toJson(),
      'request_types': requestTypes.map((key, value) => MapEntry(key, value.toJson())),
      'fingerprint_must_upload_image': fingerprintMustUploadImage,
      'fp_scan_steps': fpScanSteps,
      'default_currency': defaultCurrency.toJson(),
      'supported_currencies': supportedCurrencies.map((e) => e.toJson()).toList(),
      'default_country': defaultCountry.toJson(),
      'supported_countries': supportedCountries.map((e) => e.toJson()).toList(),
      'timezone': timezone,
      'web_services': webServices.map((e) => e.toJson()).toList(),
      'classifications': classifications.map((e) => e.toJson()).toList(),
      'can_new_register': canNewRegister,
      'can_visit': canVisit,
      'login_types': loginTypes,
    };
  }
}

// Define the nested classes
class StoreUrl {
  final String appStore;
  final String playStore;

  StoreUrl({required this.appStore, required this.playStore});

  factory StoreUrl.fromJson(Map<String, dynamic> json) {
    return StoreUrl(
      appStore: json['app_store'],
      playStore: json['play_store'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'app_store': appStore,
      'play_store': playStore,
    };
  }
}

// Other classes go here (GeneralMessageByScreen, Features, Appearance, CompanyContacts, Holiday, WorkTime, RequestType, Currency, Country, WebService, Classification)

// Example:
class CompanyContacts {
  final String phone;
  final List<String> otherPhones;
  final String whatsapp;
  final String workingHours;
  final String facebook;
  final String twitter;
  final String instagram;
  final String linkedin;
  final String youtube;
  final String messenger;
  final List<Branch> branches;

  CompanyContacts({
    required this.phone,
    required this.otherPhones,
    required this.whatsapp,
    required this.workingHours,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.linkedin,
    required this.youtube,
    required this.messenger,
    required this.branches,
  });

  factory CompanyContacts.fromJson(Map<String, dynamic> json) {
    return CompanyContacts(
      phone: json['phone'],
      otherPhones: List<String>.from(json['otherphones']),
      whatsapp: json['whatassp'],
      workingHours: json['working_hours'] ?? '',
      facebook: json['facebook'],
      twitter: json['twitter'] ?? '',
      instagram: json['instagram'],
      linkedin: json['linkedin'],
      youtube: json['youtube'] ?? '',
      messenger: json['messenger'] ?? '',
      branches: (json['branches'] as List)
          .map((e) => Branch.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'otherphones': otherPhones,
      'whatassp': whatsapp,
      'working_hours': workingHours,
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'linkedin': linkedin,
      'youtube': youtube,
      'messenger': messenger,
      'branches': branches.map((e) => e.toJson()).toList(),
    };
  }
}

class Branch {
  final Map<String, String> title;
  final bool isMainBranch;
  final String coInfoEmail;
  final String coInfoPhone;
  final CoInfoAddress coInfoAddress;
  final String coInfoLocation;
  final String coInfoLocationUrl;
  final String lat;
  final String lng;

  Branch({
    required this.title,
    required this.isMainBranch,
    required this.coInfoEmail,
    required this.coInfoPhone,
    required this.coInfoAddress,
    required this.coInfoLocation,
    required this.coInfoLocationUrl,
    required this.lat,
    required this.lng,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      title: {
        'en': json['title']['en'],
        'ar': json['title']['ar'],
      },
      isMainBranch: json['is_main_branch'],
      coInfoEmail: json['co_info_email'],
      coInfoPhone: json['co_info_phone'],
      coInfoAddress: CoInfoAddress.fromJson(json['co_info_address']),
      coInfoLocation: json['co_info_location'],
      coInfoLocationUrl: json['co_info_location_url'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'is_main_branch': isMainBranch,
      'co_info_email': coInfoEmail,
      'co_info_phone': coInfoPhone,
      'co_info_address': coInfoAddress.toJson(),
      'co_info_location': coInfoLocation,
      'co_info_location_url': coInfoLocationUrl,
      'lat': lat,
      'lng': lng,
    };
  }
}

class CoInfoAddress {
  final String en;
  final String ar;

  CoInfoAddress({required this.en, required this.ar});

  factory CoInfoAddress.fromJson(Map<String, dynamic> json) {
    return CoInfoAddress(
      en: json['en'],
      ar: json['ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}
class GeneralMessageByScreen {
  final String screen;
  final String message;

  GeneralMessageByScreen({required this.screen, required this.message});

  factory GeneralMessageByScreen.fromJson(Map<String, dynamic> json) {
    return GeneralMessageByScreen(
      screen: json['screen'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'screen': screen,
      'message': message,
    };
  }
}

class Features {
  final bool fingerprintEnabled;
  final bool canTrackOrder;
  // Add more feature flags as needed

  Features({required this.fingerprintEnabled, required this.canTrackOrder});

  factory Features.fromJson(Map<String, dynamic> json) {
    return Features(
      fingerprintEnabled: json['fingerprint_enabled'],
      canTrackOrder: json['can_track_order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fingerprint_enabled': fingerprintEnabled,
      'can_track_order': canTrackOrder,
    };
  }
}

class Appearance {
  final String theme;
  final bool showSplashScreen;

  Appearance({required this.theme, required this.showSplashScreen});

  factory Appearance.fromJson(Map<String, dynamic> json) {
    return Appearance(
      theme: json['theme'],
      showSplashScreen: json['show_splash_screen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': theme,
      'show_splash_screen': showSplashScreen,
    };
  }
}

class Holiday {
  final String date;
  final String description;

  Holiday({required this.date, required this.description});

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      date: json['date'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'description': description,
    };
  }
}

class WorkTime {
  final String openingTime;
  final String closingTime;

  WorkTime({required this.openingTime, required this.closingTime});

  factory WorkTime.fromJson(Map<String, dynamic> json) {
    return WorkTime(
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'opening_time': openingTime,
      'closing_time': closingTime,
    };
  }
}

class RequestType {
  final String type;
  final String description;

  RequestType({required this.type, required this.description});

  factory RequestType.fromJson(Map<String, dynamic> json) {
    return RequestType(
      type: json['type'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'description': description,
    };
  }
}

class Currency {
  final String code;
  final String symbol;
  final String name;

  Currency({required this.code, required this.symbol, required this.name});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      symbol: json['symbol'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'symbol': symbol,
      'name': name,
    };
  }
}

class Country {
  final String name;
  final String code;

  Country({required this.name, required this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}

class WebService {
  final String name;
  final String url;

  WebService({required this.name, required this.url});

  factory WebService.fromJson(Map<String, dynamic> json) {
    return WebService(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

class Classification {
  final String category;
  final String description;

  Classification({required this.category, required this.description});

  factory Classification.fromJson(Map<String, dynamic> json) {
    return Classification(
      category: json['category'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
    };
  }
}

