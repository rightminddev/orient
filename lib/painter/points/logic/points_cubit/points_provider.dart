import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:dio/dio.dart';

class PointsProvider extends ChangeNotifier {
  int selectedIndex = 0;
  bool isLoading  = false;
  bool isSuccess = false;
  bool isRedeemLoading  = false;
  bool isRedeemSuccess = false;
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  var userName;
  List prizes = [];
  List newPrizes = [];
  int currentPage = 1;
  final int itemsCount = 9;
  bool hasMore = true;
  bool hasMorePrizes = true;
  final int expectedPageSize = 9;
  String? getPrizeErrorMessage;
  String? postPrizeErrorMessage;
  Set<int> prizeIds = {}; // Track unique product IDs
  int? selectIndex;
  bool hasMoreData(int length) {
    if (length < expectedPageSize) {
      return false;
    } else {
      currentPage += 1;
      return true;
    }
  }
  Future<void> refreshPaints(context) async{
    currentPage = 1;
    hasMore = true;
    await getPrize(page : 1,context);
  }
  Future<void> getPrize(BuildContext context, {int? page}) async {
    if(page != null){currentPage = page;}
    print("currentPage is --> $currentPage}");
    isLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.getData(
        url: "/prizes/entities-operations",
        context: context, // Pass this explicitly only if necessary
        query: {
          "itemsCount": itemsCount,
          "page": page ?? currentPage,
        },
      );

      newPrizes = response.data['data'] ?? [];
      List uniqueNotifications = newPrizes.where((p) => !prizeIds.contains(p['id'])).toList();
      if (page == 1) {
        prizes.clear(); // Clear only when loading the first page
      }
      if (newPrizes.isNotEmpty) {
        isLoading = false;
        prizes.addAll(uniqueNotifications);
        print("LENGTH IS --> ${newPrizes.length}");
        if (hasMore) currentPage++;
      } else {
        hasMorePrizes = false;

      }

      isLoading = true;
    } catch (error) {
      getPrizeErrorMessage = error is DioError
          ? error.response?.data['message'] ?? 'Something went wrong'
          : error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> postRedeemPrize(context, {id}) async {
    isRedeemLoading = true;
    notifyListeners();
    DioHelper.postData(
        url: "/rm_pointsys/v1/prizes",
        context: context,
        data: {
          "prize_id" :id
        },
    ).then((value){
      if(value.data["status"] == true){
        isRedeemSuccess = true;
        AlertsService.success(
            context: context,
            message: value.data['message'],
            title: AppStrings.success.tr());
      }else{
        AlertsService.error(
            context: context,
            message: value.data['message'],
            title: AppStrings.failed.tr());
      }
      isRedeemLoading = false;
      notifyListeners();
    }).catchError((error){
      if (error is DioError) {
        postPrizeErrorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        postPrizeErrorMessage = error.toString();
      }
      print("postPrizeErrorMessage --> $postPrizeErrorMessage");
      AlertsService.error(
          context: context,
          message: postPrizeErrorMessage!,
          title: AppStrings.failed.tr());
      isRedeemLoading = false;
      notifyListeners();
    });
  }
  Future<void> postTransferPoints(context, {confirmed = false, user, amount}) async {
    isRedeemLoading = true;
    notifyListeners();
    DioHelper.postData(
        url: "/rm_pointsys/v1/transfer-points",
        context: context,
        data: {
          "user" : (user != null && user.isNotEmpty)? user : countryCodeController.text.isEmpty ? '+20${phoneController.text}' : "${countryCodeController.text}${phoneController.text}",
          "amount" : (amount != null && amount.isNotEmpty)?amount : pointsController.text,
         if(confirmed == true) "confirmed" : confirmed
        },
    ).then((value){
      if(value.data["status"] == true){
        isRedeemSuccess = true;
       if(value.data['data'] != null){ userName = value.data['data']['user_namme'];}
      }else{
        Fluttertoast.showToast(
            msg: value.data['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        // AlertsService.error(
        //     context: context,
        //     message: value.data['message'],
        //     title: AppStrings.failed.tr());
      }
      isRedeemLoading = false;
      notifyListeners();
    }).catchError((error){
      if (error is DioError) {
        postPrizeErrorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        postPrizeErrorMessage = error.toString();
      }
      print("postPrizeErrorMessage --> $postPrizeErrorMessage");
      Fluttertoast.showToast(
          msg: postPrizeErrorMessage!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // AlertsService.error(
      //     context: context,
      //     message: postPrizeErrorMessage!,
      //     title: AppStrings.failed.tr());
      isRedeemLoading = false;
      notifyListeners();
    });
  }
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
