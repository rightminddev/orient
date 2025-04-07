abstract class AppSettingsModel {
   String? lastUpdateDate;
  AppSettingsModel({this.lastUpdateDate});
  Map<String, dynamic> toJson();
}
