class CityModel {
  int? id;
  String? title;
  String? state;
  int? stateId;
  int? status;

  CityModel({this.id, this.title, this.state, this.stateId, this.status});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    state = json['state'];
    stateId = json['state_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['state'] = state;
    data['state_id'] = stateId;
    data['status'] = status;
    return data;
  }
}
