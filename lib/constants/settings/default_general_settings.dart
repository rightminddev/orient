import 'package:easy_localization/easy_localization.dart';
import 'package:orient/constants/app_strings.dart';

import '../../models/settings/general_settings.model.dart';
import '../app_images.dart';

/// getter for default [generalSettings].
final GeneralSettingsModel defaultGeneralSettings =
    GeneralSettingsModel.fromJson(_defaultGeneralSettingsMap);

Map<String, dynamic> _defaultGeneralSettingsMap = {
  "last_update_date": "2022-02-16",
  "item_per_page": 9,
  "popup": null,
  "mandatory_updates_alert_build": "0",
  "mandatory_updates_end_build": "10",
  "store_url": {
    "app_store": "https://apps.apple.com/eg/xx",
    "play_store": "https://play.google.com/"
  },
  "general_message_by_screen": [
    {
      "screen_id": null,
      "screen_message": null
    }
  ],
  "features": {
    "date": "2022-02-10",
    "items": [
      {
        "image": [
          {
            "id": 955,
            "type": "png",
            "title": "orient-viza",
            "alt": "orient-viza",
            "file": AppImages.onboardingBackground1,
            "thumbnail": "https://lab.r-m.dev/files/2024/orient-viza_thumbnail.png",
            "sizes": {
              "thumbnail": "https://lab.r-m.dev/files/2024/orient-viza_thumbnail.png",
              "medium": "https://lab.r-m.dev/files/2024/orient-viza_thumbnail.png",
              "large": "https://lab.r-m.dev/files/2024/orient-viza_thumbnail.png",
              "1200_800": "https://lab.r-m.dev/files/2024/orient-viza_thumbnail.png",
              "800_1200": "https://lab.r-m.dev/files/2024/orient-viza_thumbnail.png",
              "1200_300": "https://lab.r-m.dev/files/2024/orient-viza_thumbnail.png",
              "300_1200": "https://lab.r-m.dev/files/2024/orient-viza_thumbnail.png"
            }
          }
        ],
        "title": {
          "en": AppStrings.completeControlOverVacationBalance,
          "ar": AppStrings.completeControlOverVacationBalance
        },
        "info": {
          "en": AppStrings.knowYourBalanceMomentByMomentRequestLeaveFromYourManagerAndControlYourPermissions,
          "ar": AppStrings.knowYourBalanceMomentByMomentRequestLeaveFromYourManagerAndControlYourPermissions
        }
      },
      {
        "image": [
          {
            "id": 956,
            "type": "jpg",
            "title": "Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84",
            "alt": AppImages.onboardingBackground2,
            "file": AppImages.onboardingBackground2,
            "thumbnail": "https://lab.r-m.dev/files/2024/Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84_thumbnail.jpg",
            "sizes": {
              "thumbnail": "https://lab.r-m.dev/files/2024/Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84_thumbnail.jpg",
              "medium": "https://lab.r-m.dev/files/2024/Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84_medium.jpg",
              "large": "https://lab.r-m.dev/files/2024/Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84_large.jpg",
              "1200_800": "https://lab.r-m.dev/files/2024/Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84_1200_800.jpg",
              "800_1200": "https://lab.r-m.dev/files/2024/Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84_800_1200.jpg",
              "1200_300": "https://lab.r-m.dev/files/2024/Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84_1200_300.jpg",
              "300_1200": "https://lab.r-m.dev/files/2024/Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84_300_1200.jpg",
              "Screenshot_webp": "https://lab.r-m.dev/LabRMDev/files/2024/Screenshot_2024-11-13-16-47-21-51_d5157721fcece791f24fd9f6acabdb84_thumbnail.webp"
            }
          }
        ],
        "title": {
          "en": AppStrings.smartFingerprint,
          "ar": AppStrings.smartFingerprint
        },
        "info": {
          "en": AppStrings.recordAttendanceInMultipleWaysAndWatchLiveAllAttendanceRecordsAndTheirDates,
          "ar": AppStrings.recordAttendanceInMultipleWaysAndWatchLiveAllAttendanceRecordsAndTheirDates
        }
      }
    ]
  },
  // "features": {
  //   "date": "2022-02-10",
  //   "items": [
  //     {
  //       "title": AppStrings.completeControlOverVacationBalance,
  //       "image": AppImages.onboardingBackground1,
  //       "info": AppStrings.knowYourBalanceMomentByMomentRequestLeaveFromYourManagerAndControlYourPermissions,
  //     },
  //     {
  //       "title": AppStrings.smartFingerprint,
  //       "image": AppImages.onboardingBackground2,
  //       "info": AppStrings.recordAttendanceInMultipleWaysAndWatchLiveAllAttendanceRecordsAndTheirDates,
  //     }
  //   ]
  // },
  "appearance": {
    "colors": {
      "c1": "#000",
      "c2": "#333",
      "c3": "#fff",
      "c1_bg": "#000",
      "c1_bg_text": "#fff",
      "c2_bg": "#fff",
      "c2_bg_text": "#333"
    },
    "logo": "https://lab.r-m.dev/storage/admin/logo.png"
  },
  "company_contacts": {
    "phone": "19842",
    "otherphones": [
      "0273424267"
    ],
    "whatassp": "https://wa.me/",
    "whatsapp": "https://wa.me/",
    "working_hours": "",
    "facebook": "https://www.facebook.com/orient.paints",
    "tiktok": "",
    "twitter": "",
    "instagram": "https://www.instagram.com/orientpaintseg/",
    "linkedin": "https://www.linkedin.com/company/orient-paints/",
    "youtube": "",
    "messenger": "",
    "branches": [
      {
        "title": {
          "en": "HEAD OFFICE",
          "ar": "المكتب الرئيسي"
        },
        "is_main_branch": false,
        "co_info_email": "info@orient-paints.com",
        "co_info_phone": "19842",
        "co_info_address": {
          "en": "Building 6058 beside Carrefour City Center, Maadi, Cairo",
          "ar": "مبنى 6058, شارع السعادة المعراج العلوي بجوار كارفور سيتي سنتر المعادي, القاهرة"
        },
        "co_info_location": "https://maps.app.goo.gl/ZcHdDh1MXVy5aB6R8",
        "co_info_location_url": "https://maps.app.goo.gl/ZcHdDh1MXVy5aB6R8",
        "lat": "29.977241",
        "lng": "31.316373"
      },
      {
        "title": {
          "en": "Factory",
          "ar": "المصنع"
        },
        "is_main_branch": false,
        "co_info_email": "info@orient-paints.com",
        "co_info_phone": "19842",
        "co_info_address": {
          "en": "SHOUBRA EL-KHEIMA, QALIUBIYA",
          "ar": "شبرا الخيمة, القليوبية"
        },
        "co_info_location": "https://maps.app.goo.gl/BJBeXGaUFk3qeHkh9",
        "co_info_location_url": "https://maps.app.goo.gl/BJBeXGaUFk3qeHkh9",
        "lat": "29.977241",
        "lng": "31.316373"
      }
    ]
  },
  "available_lang": [
    "en",
    "ar"
  ],
  "visitors_create_order": true,
  "is_store_active": false,
  "check_cart_prepare_min": null,
  "weekends": [
    "saturday",
    "friday"
  ],
  "holidays": [
    {
      "name": "crishmas",
      "from": "2025-01-01",
      "to": "2025-01-07"
    },
    {
      "name": "Ad-Haaa",
      "from": "2024-06-19",
      "to": "2024-06-24"
    },
    {
      "name": "testhiol",
      "from": "2024-06-03",
      "to": "2024-06-04"
    }
  ],
  "worktime": {
    "from": "",
    "to": ""
  },
  "request_types": {
    "1": {
      "id": 1,
      "title": "Sick Days",
      "type": "days",
      "acceptance_time": 24,
      "maximum": -1,
      "counting_type": "monthly",
      "fields": {
        "attaching_file": "inactive",
        "money_value": "inactive"
      },
      "rules_message": null
    },
    "2": {
      "id": 2,
      "title": "Mother day",
      "type": "days",
      "acceptance_time": null,
      "maximum": 3,
      "counting_type": "monthly",
      "fields": {
        "attaching_file": "inactive",
        "money_value": "inactive"
      },
      "rules_message": null
    },
    "3": {
      "id": 3,
      "title": "Honney Moon",
      "type": "days",
      "acceptance_time": null,
      "maximum": -1,
      "counting_type": "monthly",
      "fields": {
        "attaching_file": "inactive",
        "money_value": "inactive"
      },
      "rules_message": null
    },
    "4": {
      "id": 4,
      "title": "other deparrtment only",
      "type": "days",
      "acceptance_time": null,
      "maximum": -1,
      "counting_type": "monthly",
      "fields": {
        "attaching_file": "inactive",
        "money_value": "inactive"
      },
      "rules_message": null
    }
  },
  "fingerprint_must_upload_image": true,
  "fp_scan_steps": true,
  "default_currency": {
    "id": 35,
    "name": "Egyptian Pound",
    "code": "EGP",
    "precision": "2",
    "symbol": "EGP",
    "symbol_native": "ج.م."
  },
  "supported_currencies": [
    {
      "id": 4,
      "name": "United Arab Emirates Dirham",
      "code": "AED",
      "precision": "2",
      "symbol": "AED",
      "symbol_native": "د.إ."
    },
    {
      "id": 60,
      "name": "Kuwaiti Dinar",
      "code": "KWD",
      "precision": "3",
      "symbol": "KD",
      "symbol_native": "د.ك."
    },
    {
      "id": 95,
      "name": "Saudi Riyal",
      "code": "SAR",
      "precision": "2",
      "symbol": "SR",
      "symbol_native": "ر.س."
    }
  ],
  "currencies_rates": {
    "USD": 1,
    "KWD": 0.3086,
    "SAR": 3.75,
    "AED": 3.6725,
    "EGP": 49.6541
  },
  "default_country": {
    "id": 66,
    "title": {
      "en": "Egypt",
      "ar": "Egypt"
    },
    "iso2": "EG",
    "phone_code": 20,
    "currency_id": 35
  },
  "supported_countries": [
    {
      "id": 195,
      "title": {
        "en": "Saudi Arabia",
        "ar": "Saudi Arabia"
      },
      "iso2": "SA",
      "phone_code": 966,
      "currency_id": 95
    },
    {
      "id": 234,
      "title": {
        "en": "United Arab Emirates",
        "ar": "United Arab Emirates"
      },
      "iso2": "AE",
      "phone_code": 971,
      "currency_id": 4
    }
  ],
  "timezone": "Africa/Cairo",
  "web_services": [
    {
      "main_url": null,
      "merchant_id": null,
      "account_id": "13216496",
      "pixle_code": null,
      "client_id": null,
      "client_secret": null,
      "token": null,
      "webhook_secret_token": null,
      "username": null,
      "password": null,
      "sender_id": null,
      "country_codes": [],
      "port": null,
      "notification_max": null,
      "notification_max_live": null,
      "notification_provider_limits": null,
      "notification_delay_seconds": null,
      "notification_tries": null,
      "countries": [],
      "excluded_countries": [],
      "available_payment_min": null,
      "available_payment_max": null,
      "thisis mew": "thisis mew"
    }
  ],
  "offer_cancelled_after": "9",
  "min_days_before_cancel_offer": "4",
  "classifications": [
    {
      "id": 1,
      "company_id": 6,
      "name": "Good",
      "created_by": 1,
      "updated_by": null,
      "created_at": "2024-10-08T12:08:18.000000Z",
      "updated_at": "2024-10-08T12:08:18.000000Z",
      "deleted_at": null
    },
    {
      "id": 2,
      "company_id": 17,
      "name": "Poor",
      "created_by": 1,
      "updated_by": null,
      "created_at": "2024-10-08T12:13:27.000000Z",
      "updated_at": "2024-10-08T12:13:27.000000Z",
      "deleted_at": null
    },
    {
      "id": 3,
      "company_id": 17,
      "name": "Shortlist",
      "created_by": 1,
      "updated_by": null,
      "created_at": "2024-10-08T12:13:43.000000Z",
      "updated_at": "2024-10-08T12:13:43.000000Z",
      "deleted_at": null
    },
    {
      "id": 4,
      "company_id": 17,
      "name": "Rejected",
      "created_by": 1,
      "updated_by": null,
      "created_at": "2024-10-08T12:14:11.000000Z",
      "updated_at": "2024-10-08T12:14:11.000000Z",
      "deleted_at": null
    }
  ],
  "latest_jobs": [
    {
      "id": 82,
      "job_title": "cats doctor",
      "career_type_id": 3,
      "career_level_id": 21,
      "career_type": {
        "id": 3,
        "title": "Health care specialist"
      },
      "career_level": {
        "id": 21,
        "title": "Mid-Level s"
      }
    },
    {
      "id": 81,
      "job_title": "frontend doctor developer",
      "career_type_id": 1,
      "career_level_id": 9,
      "career_type": {
        "id": 1,
        "title": "Doctor"
      },
      "career_level": {
        "id": 9,
        "title": "Attending Physician"
      }
    },
    {
      "id": 80,
      "job_title": "frontend doctor developer 11111111111111111",
      "career_type_id": 1,
      "career_level_id": 13,
      "career_type": {
        "id": 1,
        "title": "Doctor"
      },
      "career_level": {
        "id": 13,
        "title": "Consultant Nephrologist"
      }
    },
    {
      "id": 79,
      "job_title": "dentist",
      "career_type_id": 2,
      "career_level_id": 1,
      "career_type": {
        "id": 2,
        "title": "Nurse"
      },
      "career_level": {
        "id": 1,
        "title": "doctor"
      }
    },
    {
      "id": 77,
      "job_title": "dentist high level doctor 22",
      "career_type_id": 1,
      "career_level_id": 1,
      "career_type": {
        "id": 1,
        "title": "Doctor"
      },
      "career_level": {
        "id": 1,
        "title": "doctor"
      }
    },
    {
      "id": 76,
      "job_title": "General Practitioner (GPة)",
      "career_type_id": 2,
      "career_level_id": 18,
      "career_type": {
        "id": 2,
        "title": "Nurse"
      },
      "career_level": {
        "id": 18,
        "title": "Mid-Level"
      }
    },
    {
      "id": 75,
      "job_title": "ffffffffffffffffffffffff",
      "career_type_id": 1,
      "career_level_id": 7,
      "career_type": {
        "id": 1,
        "title": "Doctor"
      },
      "career_level": {
        "id": 7,
        "title": "Charge"
      }
    },
    {
      "id": 72,
      "job_title": "teeeeeeeeeeest",
      "career_type_id": 1,
      "career_level_id": 12,
      "career_type": {
        "id": 1,
        "title": "Doctor"
      },
      "career_level": {
        "id": 12,
        "title": "Pathologist"
      }
    },
    {
      "id": 71,
      "job_title": "frontend doctor developer",
      "career_type_id": 2,
      "career_level_id": 17,
      "career_type": {
        "id": 2,
        "title": "Nurse"
      },
      "career_level": {
        "id": 17,
        "title": "Entry-Level"
      }
    }
  ],
  "can_new_register": true,
  "can_visit": true,
  "login_types": [
    "username",
    "phone",
    "email",
    "social_google",
    "social_facebook",
    "social_linkedin-openid"
  ]
};
