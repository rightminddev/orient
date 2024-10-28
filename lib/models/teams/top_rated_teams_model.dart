import 'package:orient/models/teams/team_model.dart';

class TopRatedTeamsModel {
  List<TeamModel>? teams;
  TeamModel? myTeam;

  TopRatedTeamsModel({this.teams, this.myTeam});

  TopRatedTeamsModel.fromJson(Map<String, dynamic> json) {
    if (json['teams'] != null) {
      teams = <TeamModel>[];
      json['teams'].forEach((v) {
        teams!.add(TeamModel.fromJson(v));
      });
    }
    myTeam =
        json['my_team'] != null ? TeamModel.fromJson(json['my_team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    if (myTeam != null) {
      data['my_team'] = myTeam!.toJson();
    }
    return data;
  }
}
