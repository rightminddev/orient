abstract class AppSettingsModel {
  final String? lastUpdateDate;
  AppSettingsModel({this.lastUpdateDate});
  Map<String, dynamic> toJson();
}
