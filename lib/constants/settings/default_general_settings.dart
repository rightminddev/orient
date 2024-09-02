import '../../models/settings/general_settings.model.dart';
import '../app_images.dart';

/// getter for default [generalSettings].
final GeneralSettingsModel defaultGeneralSettings =
    GeneralSettingsModel.fromJson(_defaultGeneralSettingsMap);

Map<String, dynamic> _defaultGeneralSettingsMap = {
  "last_update_date": "2022-02-16",
  "popup": {
    "id": "urtyn_3",
    "user_state": "all",
    "again_after": "16",
    "image":
        "https://ri-mind.net/test1/wp-content/uploads/2022/02/image_07.jpg",
    "link_type": "url",
    "link": "https://ri-mind.net/test1/"
  },
  "mandatory_updates_alert_build": "110",
  "mandatory_updates_end_build": "105",
  "store_url": {
    "app_store": "https://appstoreconnect.apple.com/",
    "play_store":
        "https://play.google.com/store/movies/details/Kingsman_The_Secret_Service?id=ncNLOZHrzpM"
  },
  "can_new_register": true,
  "login_types": ["username", "phone", "email", "social"],
  "menu": [
    {
      "for": ["any"],
      "icon": "bookmark",
      "title": {"en": "News", "ar": "الأخبار"},
      "link": "/xxx/sss",
      "link_type": "screen"
    },
    {
      "for": ["not_user"],
      "icon": "phone",
      "title": {"en": "Register Now", "ar": "سجل الآن"},
      "link": "/xxx/sss",
      "link_type": "screen"
    },
    {
      "for": ["user"],
      "icon": "book",
      "title": {"en": "Posts", "ar": "المقالات"},
      "link": "/xxx/sss",
      "link_type": "screen"
    },
    {
      "for": ["administrator", "editor"],
      "icon": "contact",
      "title": {"en": "Contact Us", "ar": "أتصل بنا"},
      "link": "/xxx/sss",
      "link_type": "screen"
    }
  ],
  "features": {
    "date": "2022-02-10",
    "items": [
      {
        "title": "COMPLETE CONTROL OVER VACATION BALANCE",
        "image": AppImages.onboardingBackground1,
        "info":
            "Know your balance moment by moment, request leave from your manager, and control your permissions",
      },
      {
        "title": "SMART FINGERPRINT",
        "image": AppImages.onboardingBackground2,
        "info":
            "Record attendance in multiple ways, and watch live all attendance records and their dates",
      }
    ]
  },
  "appearance": {
    "colors": {"main": "#2271b1", "main_2": "#3c434a", "login_bg": "#3e4c56"},
    "logo": "https://ri-mind.net/test1/wp-content/uploads/2022/02/logotype.png"
  },
  "thumbnails": {
    "default": "thumb2",
    "post": "thumb1",
    "real-estate": "thumb2",
    "events": "thumb3",
    "notifications": "lines"
  },
  "holidays": ["friday", "saturday"],
  "worktime": {"from": 10, "to": 18},
  "request_types": {
    "542": [
      {
        "title": {"en": "Annual Leave"},
        "type": "days",
        "not_after": "-1",
        "max": "15",
        "counting": "annual",
        "fields": {
          "reason": {
            "valid": ["notEmpty"]
          },
          "date_from": {
            "valid": ["notEmpty", "dateTime"]
          },
          "date_to": {
            "valid": ["notEmpty", "dateTime"]
          },
          "for": {
            "valid": ["notEmpty", "digit"]
          }
        },
        "custom_message": "Custom message custom message ccccccccccccc ",
        "reason_to_report": "1"
      }
    ],
    "544": [
      {
        "title": {"en": "Sick leave"},
        "type": "days",
        "not_after": "5",
        "max": "-1",
        "counting": "annual",
        "fields": {
          "reason": {
            "valid": ["notEmpty"]
          },
          "date_from": {
            "valid": ["notEmpty", "dateTime"]
          },
          "date_to": {
            "valid": ["notEmpty", "dateTime"]
          },
          "for": {
            "valid": ["notEmpty", "digit"]
          },
          "attachments": {
            "valid": {
              "0": "notEmpty",
              "fileType": "PDF|JPG|JPEG|PNG",
              "maxSize": "5MB",
              "maxFiles": 3
            }
          }
        },
        "custom_message": "Custom message custom message ccccccccccccc ",
        "reason_to_report": "1"
      }
    ]
  },
  "new_posts": {
    "ticket": {
      "fields": [
        {
          "type": "select",
          "name": "ticket_type",
          "label": {"en": "Ticket type", "ar": "نوع التذكرة"},
          "values": {
            "suggestion": {"en": "Suggestion", "ar": "اقتراح"},
            "complaint": {"en": "complaint", "ar": "شكوى"},
            "redemption": {
              "en": "Point redemption request",
              "ar": "طلب استبدال نقاط"
            }
          },
          "icon": "name",
          "placeholder": "",
          "description": "",
          "valid": ["notEmpty"]
        },
        {
          "type": "text",
          "name": "subject",
          "label": {"en": "Subject", "ar": "عنوان التذكرة"},
          "icon": "name",
          "placeholder": "",
          "description": "",
          "valid": {"0": "notEmpty", "minLength": 3, "maxLength": 20}
        },
        {
          "type": "textarea",
          "name": "message",
          "label": {"en": "Message", "ar": "الرسالة"},
          "icon": "name",
          "placeholder": "Enter your Message",
          "description":
              "Lorem Ipsum is simply dummy text of the printing 22222222222222",
          "valid": {"0": "notEmpty", "minLength": 10, "maxLength": 200}
        }
      ]
    }
  },
  "available_lang": ["en", "ar"],
  "notification_settings": {
    "posts": {"en": "Posts & news", "ar": "المقالات والأخبار"},
    "tickets": {"en": "Tickets", "ar": "تذاكر الدعم الفنى"},
    "general": {"en": "General", "ar": "التنبيهات العامة"}
  },
};
