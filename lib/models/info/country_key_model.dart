class CountryKeyModel {
  int? key;
  String? value;

  CountryKeyModel({this.key, this.value});

  CountryKeyModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
