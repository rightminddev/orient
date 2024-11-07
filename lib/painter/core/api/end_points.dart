import 'package:orient/general_services/app_config.service.dart';
import 'package:provider/provider.dart';

class EndPoints {
  String postId = '';
  static const String baseUrl = 'https://lab.r-m.dev/';
  ///replace with token after login
  ///replace with deviceId after login
  static const String getHistory = 'api/rm_pointsys/v1/history';
  static const String getPrize = 'api/rm_pointsys/v1/prizes';
  static const String coupoun = 'api/rm_pointsys/v1/redeem_gift_card';
  static const String conditions = 'api/rm_page/v1/show?slug=points-terms-and-conditions';
  static const String postGroups = 'api/social-groups/entities-operations';
  static const String postPrize = 'api/redeem-requests/entities-operations/store';
  static  String addComment = 'api/social-posts/entities-operations/:id/comments';
  static const String postsInGroup= 'api/social-posts/entities-operations?with=social_group_id,user_id';
}
