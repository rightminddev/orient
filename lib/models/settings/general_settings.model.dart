import '../../general_services/model_helpers.service.dart';
import 'app_settings_model.dart';

class GeneralSettingsModel extends AppSettingsModel {
  final Popup? popup;
  final String? mandatoryUpdatesAlertBuild;
  final String? mandatoryUpdatesEndBuild;
  final StoreUrl? storeUrl;
  final List<GeneralMessageByScreen>? generalMessageByScreen;
  final List<Menu>? menu;
  final Features? features;
  final Appearance? appearance;
  final CompanyContacts? companyContacts;
  final List<String>? availableLang;
  final List<String>? weekends;
  final List<HolidayOrString>? holidays;
  final WorktimeOrInt? worktime;
  final Map<String, RequestTypeOrList>? requestTypes;
  final bool? fingerprintMustUploadImage;
  final bool? fpScanSteps;
  final bool? canNewRegister;
  final bool? canVisit;
  final bool? payrollScreenProtection;
  final List<String>? loginTypes;

  GeneralSettingsModel(
      {required super.lastUpdateDate,
      this.popup,
      this.mandatoryUpdatesAlertBuild,
      this.mandatoryUpdatesEndBuild,
      this.storeUrl,
      this.canVisit,
      this.generalMessageByScreen,
      this.menu,
      this.features,
      this.appearance,
      this.companyContacts,
      this.availableLang,
      this.weekends,
      this.holidays,
      this.worktime,
      this.requestTypes,
      this.fingerprintMustUploadImage,
      this.fpScanSteps,
      this.canNewRegister,
      this.payrollScreenProtection,
      this.loginTypes});

  factory GeneralSettingsModel.fromJson(Map<String, dynamic> json) {
    return GeneralSettingsModel(
      lastUpdateDate: json['last_update_date'],
      popup: json['popup'] is List ? null : Popup.fromJson(json['popup']),
      mandatoryUpdatesAlertBuild: json['mandatory_updates_alert_build'],
      mandatoryUpdatesEndBuild: json['mandatory_updates_end_build'],
      storeUrl: json['store_url'] != null
          ? StoreUrl.fromJson(json['store_url'])
          : null,
      generalMessageByScreen: json['general_message_by_screen'] != null
          ? List<GeneralMessageByScreen>.from(json['general_message_by_screen']
              .map((x) => GeneralMessageByScreen.fromJson(x)))
          : null,
      menu: json['menu'] != null
          ? List<Menu>.from(json['menu'].map((x) => Menu.fromJson(x)))
          : null,
      features:
          json['features'] == null ? null : Features.fromJson(json['features']),
      appearance: json['appearance'] != null
          ? Appearance.fromJson(json['appearance'])
          : null,
      companyContacts: json['company_contacts'] != null
          ? CompanyContacts.fromJson(json['company_contacts'])
          : null,
      availableLang: json['available_lang'] != null
          ? List<String>.from(json['available_lang'])
          : null,
      weekends:
          json['weekends'] != null ? List<String>.from(json['weekends']) : null,
      holidays: json['holidays'] != null
          ? (json['holidays'] is List
              ? List<HolidayOrString>.from(
                  json['holidays'].map((x) => HolidayOrString.fromJson(x)))
              : null)
          : null,
      worktime: json['worktime'] != null
          ? WorktimeOrInt.fromJson(json['worktime'])
          : null,
      requestTypes: json['request_types'] != null
          ? Map<String, RequestTypeOrList>.from(json['request_types'].map(
              (k, v) => MapEntry<String, RequestTypeOrList>(
                  k, RequestTypeOrList.fromJson(v))))
          : null,
      fingerprintMustUploadImage: ModelHelpersService.getBoolValue(
          json['fingerprint_must_upload_image']),
      fpScanSteps: ModelHelpersService.getBoolValue(json['fp_scan_steps']),
      canVisit: ModelHelpersService.getBoolValue(json['can_visit']),
      canNewRegister:
          ModelHelpersService.getBoolValue(json['can_new_register']),
      payrollScreenProtection: json['payroll_screen_protection'],
      loginTypes: json['login_types'] != null
          ? (json['login_types'] as List<dynamic>)
              .map((item) => item as String)
              .toList()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'last_update_date': lastUpdateDate,
      'popup': popup?.toJson(),
      'mandatory_updates_alert_build': mandatoryUpdatesAlertBuild,
      'mandatory_updates_end_build': mandatoryUpdatesEndBuild,
      'store_url': storeUrl?.toJson(),
      'general_message_by_screen': generalMessageByScreen != null
          ? List<dynamic>.from(generalMessageByScreen!.map((x) => x.toJson()))
          : null,
      'menu': menu != null
          ? List<dynamic>.from(menu!.map((x) => x.toJson()))
          : null,
      'features': features?.toJson(),
      'appearance': appearance?.toJson(),
      'company_contacts': companyContacts?.toJson(),
      'available_lang':
          availableLang != null ? List<dynamic>.from(availableLang!) : null,
      'weekends': weekends != null ? List<dynamic>.from(weekends!) : null,
      'holidays': holidays != null
          ? List<dynamic>.from(holidays!.map((x) => x.toJson()))
          : null,
      'worktime': worktime?.toJson(),
      'request_types': requestTypes != null
          ? Map<String, dynamic>.from(requestTypes!
              .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))
          : null,
      'fingerprint_must_upload_image': fingerprintMustUploadImage,
      'fp_scan_steps': fpScanSteps,
      'can_new_register': canNewRegister,
      'payroll_screen_protection': payrollScreenProtection,
    };
  }
}

class Popup {
  final String? id;
  final String? userState;
  final String? againAfter;
  final String? image;
  final String? linkType;
  final String? link;

  Popup({
    this.id,
    this.userState,
    this.againAfter,
    this.image,
    this.linkType,
    this.link,
  });

  factory Popup.fromJson(Map<String, dynamic> json) {
    return Popup(
      id: json['id'] as String?,
      userState: json['user_state'] as String?,
      againAfter: json['again_after'] as String?,
      image: json['image'] as String?,
      linkType: json['link_type'] as String?,
      link: json['link'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_state': userState,
      'again_after': againAfter,
      'image': image,
      'link_type': linkType,
      'link': link,
    };
  }
}

class StoreUrl {
  final String? appStore;
  final String? playStore;

  StoreUrl({
    this.appStore,
    this.playStore,
  });

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

class GeneralMessageByScreen {
  final String? screenId;
  final String? screenMessage;

  GeneralMessageByScreen({
    this.screenId,
    this.screenMessage,
  });

  factory GeneralMessageByScreen.fromJson(Map<String, dynamic> json) {
    return GeneralMessageByScreen(
      screenId: json['screen_id'],
      screenMessage: json['screen_message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'screen_id': screenId,
      'screen_message': screenMessage,
    };
  }
}

class Menu {
  final List<String>? forRoles;
  final String? icon;
  final Title? title;
  final String? link;
  final String? linkType;

  Menu({
    this.forRoles,
    this.icon,
    this.title,
    this.link,
    this.linkType,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      forRoles: json['for'] != null ? List<String>.from(json['for']) : null,
      icon: json['icon'],
      title: json['title'] != null ? Title.fromJson(json['title']) : null,
      link: json['link'],
      linkType: json['link_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'for': forRoles != null ? List<dynamic>.from(forRoles!) : null,
      'icon': icon,
      'title': title?.toJson(),
      'link': link,
      'link_type': linkType,
    };
  }
}

class Title {
  final String? en;
  final String? ar;

  Title({
    this.en,
    this.ar,
  });

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
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

class FeatureItem {
  final String? title;
  final String? image;
  final String? info;

  FeatureItem({this.title, this.image, this.info});

  factory FeatureItem.fromJson(Map<String, dynamic> json) {
    return FeatureItem(
      title: json['title'],
      image: json['image'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'info': info,
    };
  }
}

class Features {
  final String? date;
  final List<FeatureItem>? items;

  Features({this.date, this.items});

  factory Features.fromJson(Map<String, dynamic> json) {
    return Features(
      date: json['date'],
      items: json['items'] == null
          ? null
          : List<FeatureItem>.from(
              json['items'].map((x) => FeatureItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'items': items == null
          ? null
          : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
  }
}

class Appearance {
  final ColorsModel? colors;
  final String? logo;

  Appearance({
    this.colors,
    this.logo,
  });

  factory Appearance.fromJson(Map<String, dynamic> json) {
    return Appearance(
      colors:
          json['colors'] != null ? ColorsModel.fromJson(json['colors']) : null,
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colors': colors?.toJson(),
      'logo': logo,
    };
  }
}

class ColorsModel {
  final String? c1;
  final String? c2;
  final String? c3;
  final String? c1Bg;
  final String? c1BgText;
  final String? c2Bg;
  final String? c2BgText;

  ColorsModel({
    this.c1,
    this.c2,
    this.c3,
    this.c1Bg,
    this.c1BgText,
    this.c2Bg,
    this.c2BgText,
  });

  factory ColorsModel.fromJson(Map<String, dynamic> json) {
    return ColorsModel(
      c1: json['c1'],
      c2: json['c2'],
      c3: json['c3'],
      c1Bg: json['c1_bg'],
      c1BgText: json['c1_bg_text'],
      c2Bg: json['c2_bg'],
      c2BgText: json['c2_bg_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'c1': c1,
      'c2': c2,
      'c3': c3,
      'c1_bg': c1Bg,
      'c1_bg_text': c1BgText,
      'c2_bg': c2Bg,
      'c2_bg_text': c2BgText,
    };
  }
}

class CompanyContacts {
  final String? phone;
  final List<String?>? otherphones;
  final String? whatassp;
  final String? whatsapp;
  final String? workingHours;
  final Address? address;
  final String? location;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedin;
  final String? youtube;
  final String? messenger;
  final List<BranchModel>? branches;

  CompanyContacts({
    this.phone,
    this.branches,
    this.otherphones,
    this.whatassp,
    this.whatsapp,
    this.workingHours,
    this.address,
    this.location,
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.youtube,
    this.messenger,
  });

  factory CompanyContacts.fromJson(Map<String, dynamic> json) {
    return CompanyContacts(
      phone: json['phone'],
      otherphones: json['otherphones'] != null
          ? (json['otherphones'] as List<dynamic>)
              .map((e) => e?.toString())
              .toList()
          : null,
      whatassp: json['whatassp'],
      branches: json['branches'] != null
          ? (json['branches'] as List<dynamic>)
              .map((branch) =>
                  BranchModel.fromJson(branch as Map<String, dynamic>))
              .toList()
          : null,
      whatsapp: json['whatsapp'],
      workingHours: json['working_hours'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      location: json['location'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      instagram: json['instagram'],
      linkedin: json['linkedin'],
      youtube: json['youtube'],
      messenger: json['messenger'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'otherphones': otherphones,
      'whatassp': whatassp,
      'whatsapp': whatsapp,
      'working_hours': workingHours,
      'address': address?.toJson(),
      'location': location,
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'linkedin': linkedin,
      'youtube': youtube,
      'messenger': messenger,
      'branches': branches?.map((branch) => branch.toJson()).toList()
    };
  }
}

class Address {
  final String? en;
  final String? ar;

  Address({
    this.en,
    this.ar,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
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

class Holiday {
  final String? name;
  final String? from;
  final String? to;

  Holiday({
    this.name,
    this.from,
    this.to,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      name: json['name'],
      from: json['from'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'from': from,
      'to': to,
    };
  }
}

class HolidayOrString {
  final String? string;
  final Holiday? holiday;

  HolidayOrString({this.string, this.holiday});

  factory HolidayOrString.fromJson(dynamic json) {
    if (json is String) {
      return HolidayOrString(string: json);
    } else if (json is Map<String, dynamic>) {
      return HolidayOrString(holiday: Holiday.fromJson(json));
    } else {
      throw Exception("Invalid type for holiday");
    }
  }

  dynamic toJson() {
    if (string != null) {
      return string;
    } else if (holiday != null) {
      return holiday!.toJson();
    } else {
      throw Exception("Invalid type for holiday");
    }
  }
}

class Worktime {
  final String? from;
  final String? to;

  Worktime({
    this.from,
    this.to,
  });

  factory Worktime.fromJson(Map<String, dynamic> json) {
    return Worktime(
      from: json['from']?.toString(),
      to: json['to']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}

class WorktimeOrInt {
  final Worktime? worktime;
  final int? intValue;

  WorktimeOrInt({this.worktime, this.intValue});

  factory WorktimeOrInt.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return WorktimeOrInt(worktime: Worktime.fromJson(json));
    } else if (json is int) {
      return WorktimeOrInt(intValue: json);
    } else if (json is String) {
      return WorktimeOrInt(intValue: int.tryParse(json));
    } else {
      throw Exception("Invalid type for worktime");
    }
  }

  dynamic toJson() {
    if (worktime != null) {
      return worktime!.toJson();
    } else if (intValue != null) {
      return intValue;
    } else {
      throw Exception("Invalid type for worktime");
    }
  }
}

class RequestType {
  final int? id;
  final String? title;
  final String? type;
  final int? acceptanceTime;
  final int? maximum;
  final String? countingType;
  final Fields? fields;
  final String? rulesMessage;

  RequestType({
    this.id,
    this.title,
    this.type,
    this.acceptanceTime,
    this.maximum,
    this.countingType,
    this.fields,
    this.rulesMessage,
  });

  factory RequestType.fromJson(Map<String, dynamic> json) {
    return RequestType(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      acceptanceTime: json['acceptance_time'],
      maximum: json['maximum'],
      countingType: json['counting_type'],
      fields: json['fields'] != null ? Fields.fromJson(json['fields']) : null,
      rulesMessage: json['rules_message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'acceptance_time': acceptanceTime,
      'maximum': maximum,
      'counting_type': countingType,
      'fields': fields?.toJson(),
      'rules_message': rulesMessage,
    };
  }
}

class RequestTypeOrList {
  final RequestType? requestType;
  final List<RequestTypeList>? requestTypeList;

  RequestTypeOrList({this.requestType, this.requestTypeList});

  factory RequestTypeOrList.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return RequestTypeOrList(requestType: RequestType.fromJson(json));
    } else if (json is List) {
      return RequestTypeOrList(
          requestTypeList: json
              .map<RequestTypeList>((x) => RequestTypeList.fromJson(x))
              .toList());
    } else {
      throw Exception("Invalid type for request type");
    }
  }

  dynamic toJson() {
    if (requestType != null) {
      return requestType!.toJson();
    } else if (requestTypeList != null) {
      return requestTypeList!.map((x) => x.toJson()).toList();
    } else {
      throw Exception("Invalid type for request type");
    }
  }
}

class RequestTypeList {
  final Title? title;
  final String? type;
  final String? notAfter;
  final String? max;
  final String? counting;
  final Fields? fields;
  final String? customMessage;
  final String? reasonToReport;

  RequestTypeList({
    this.title,
    this.type,
    this.notAfter,
    this.max,
    this.counting,
    this.fields,
    this.customMessage,
    this.reasonToReport,
  });

  factory RequestTypeList.fromJson(Map<String, dynamic> json) {
    return RequestTypeList(
      title: json['title'] != null ? Title.fromJson(json['title']) : null,
      type: json['type'],
      notAfter: json['not_after'],
      max: json['max'],
      counting: json['counting'],
      fields: json['fields'] != null ? Fields.fromJson(json['fields']) : null,
      customMessage: json['custom_message'],
      reasonToReport: json['reason_to_report'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title?.toJson(),
      'type': type,
      'not_after': notAfter,
      'max': max,
      'counting': counting,
      'fields': fields?.toJson(),
      'custom_message': customMessage,
      'reason_to_report': reasonToReport,
    };
  }
}

class Fields {
  final String? attachingFile;
  final String? moneyValue;
  final Validations? validations;

  Fields({
    this.attachingFile,
    this.moneyValue,
    this.validations,
  });

  factory Fields.fromJson(Map<String, dynamic> json) {
    return Fields(
      attachingFile: json['attaching_file'],
      moneyValue: json['money_value'],
      validations:
          json['valid'] != null ? Validations.fromJson(json['valid']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attaching_file': attachingFile,
      'money_value': moneyValue,
      'valid': validations?.toJson(),
    };
  }
}

class Validations {
  final List<String>? attachingFile;
  final List<String>? moneyValue;

  Validations({this.attachingFile, this.moneyValue});

  factory Validations.fromJson(Map<String, dynamic> json) {
    return Validations(
      attachingFile: json['attaching_file'] != null
          ? List<String>.from(json['attaching_file'])
          : null,
      moneyValue: json['money_value'] != null
          ? List<String>.from(json['money_value'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attaching_file':
          attachingFile != null ? List<dynamic>.from(attachingFile!) : null,
      'money_value':
          moneyValue != null ? List<dynamic>.from(moneyValue!) : null,
    };
  }
}

class BranchModel {
  final bool? isMainBranch;
  final String? coInfoEmail;
  final String? coInfoPhone;
  final CoInfoAddress? coInfoAddress;
  final String? coInfoLocation;
  final String? coInfoLocationUrl;
  final String? lat;
  final String? lng;

  BranchModel({
    this.isMainBranch,
    this.coInfoEmail,
    this.coInfoPhone,
    this.coInfoAddress,
    this.coInfoLocation,
    this.coInfoLocationUrl,
    this.lat,
    this.lng,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      isMainBranch: json['is_main_branch'] as bool?,
      coInfoEmail: json['co_info_email'] as String?,
      coInfoPhone: json['co_info_phone'] as String?,
      coInfoAddress: json['co_info_address'] != null
          ? CoInfoAddress.fromJson(json['co_info_address'])
          : null,
      coInfoLocation: json['co_info_location'] as String?,
      coInfoLocationUrl: json['co_info_location_url'] as String?,
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_main_branch': isMainBranch,
      'co_info_email': coInfoEmail,
      'co_info_phone': coInfoPhone,
      'co_info_address': coInfoAddress?.toJson(),
      'co_info_location': coInfoLocation,
      'co_info_location_url': coInfoLocationUrl,
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  String toString() {
    return 'BranchModel(isMainBranch: $isMainBranch, coInfoEmail: $coInfoEmail, coInfoPhone: $coInfoPhone, coInfoAddress: $coInfoAddress, coInfoLocation: $coInfoLocation, coInfoLocationUrl: $coInfoLocationUrl, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BranchModel &&
        other.isMainBranch == isMainBranch &&
        other.coInfoEmail == coInfoEmail &&
        other.coInfoPhone == coInfoPhone &&
        other.coInfoAddress == coInfoAddress &&
        other.coInfoLocation == coInfoLocation &&
        other.coInfoLocationUrl == coInfoLocationUrl &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return isMainBranch.hashCode ^
        coInfoEmail.hashCode ^
        coInfoPhone.hashCode ^
        coInfoAddress.hashCode ^
        coInfoLocation.hashCode ^
        coInfoLocationUrl.hashCode ^
        lat.hashCode ^
        lng.hashCode;
  }
}

class CoInfoAddress {
  final String? en;
  final String? ar;

  CoInfoAddress({this.en, this.ar});

  factory CoInfoAddress.fromJson(Map<String, dynamic> json) {
    return CoInfoAddress(
      en: json['en'] as String?,
      ar: json['ar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }

  @override
  String toString() => 'CoInfoAddress(en: $en, ar: $ar)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoInfoAddress && other.en == en && other.ar == ar;
  }

  @override
  int get hashCode => en.hashCode ^ ar.hashCode;
}
