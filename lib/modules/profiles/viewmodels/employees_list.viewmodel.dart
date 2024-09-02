import 'package:flutter/material.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../general_services/localization.service.dart';
import '../../../models/department.model.dart';
import '../../../services/crud_operation.service.dart';
import '../../../utils/animated_custom_dropdown/custom_dropdown.dart';
import '../../../utils/modal_sheet_helper.dart';
import '../models/employee_profile.model.dart';
import '../services/employee.service.dart';

class EmployeesListViewModel extends ChangeNotifier {
  List<EmployeeProfileModel>? employees;
  List<DepartmentModel>? departments;
  List<EmployeeProfileModel> filteredEmployees = [];
  bool isLoading = true;
  String searchQuery = '';
  DepartmentModel? selectedDepartment;

  void releaseSearchValuesAndFilters() {
    if (searchQuery == '' && selectedDepartment == null) return;
    searchQuery = '';
    selectedDepartment = null;
    filterEmployees();
  }

  Future<void> initializeEmployeesListScreen(BuildContext context) async {
    updateLoadingStatus(laodingValue: true);
    await _getEmployees(context);
    await _getDepartments(context);
    updateLoadingStatus(laodingValue: false);
  }

  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> _getEmployees(BuildContext context) async {
    try {
      final result = await EmployeeService.getEmployees(context: context);
      if (result.success && result.data != null) {
        var employeesData = result.data?['employees'] as List<dynamic>?;
        employees = employeesData
            ?.map((item) =>
                EmployeeProfileModel.fromJson(item as Map<String, dynamic>))
            .toList();
        filteredEmployees = employees!;
      }
    } catch (err, t) {
      debugPrint(
          "error while getting employee list ${err.toString()} at :- $t");
    }
  }
  //OLG GET EMPLOYEES LIST METHOD USING CRUD
  // Future<void> _getEmployees(BuildContext context) async {
  //   try {
  //     final result = await CrudOperationService.readEntities(
  //       context: context,
  //       slug: 'users',
  //     );
  //     if (result.success && result.data != null) {
  //       var employeesData = result.data?['data'] as List<dynamic>?;
  //       employees = employeesData
  //           ?.map(
  //               (item) => EmployeeModel.fromJson(item as Map<String, dynamic>))
  //           .toList();
  //       filteredEmployees = employees!;
  //     }
  //   } catch (err, t) {
  //     debugPrint(
  //         "error while getting user notification ${err.toString()} at :- $t");
  //   }
  // }

  Future<void> _getDepartments(BuildContext context) async {
    try {
      final result = await CrudOperationService.readEntities(
        context: context,
        slug: 'departments',
      );
      if (result.success && result.data != null) {
        var departmentsData = result.data?['data'] as List<dynamic>?;
        departments = departmentsData
            ?.map((item) =>
                DepartmentModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err, t) {
      debugPrint("error while getting departments ${err.toString()} at :- $t");
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    filterEmployees();
  }

  void filterEmployees() {
    filteredEmployees = employees!;
    if (searchQuery.isNotEmpty) {
      filteredEmployees = filteredEmployees
          .where((employee) =>
              employee.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    if (selectedDepartment != null) {
      filteredEmployees = filteredEmployees
          .where((employee) =>
              employee.departmentId?.key == selectedDepartment?.id.toString() &&
              selectedDepartment?.id != null &&
              employee.departmentId?.value != null)
          .toList();
    }
    notifyListeners();
  }

  Future<void> showDepartmentFilterModal(BuildContext context) async {
    await ModalSheetHelper.showModalSheet(
      context: context,
      height: AppSizes.s400,
      title: 'Filter',
      modalContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gapH20,
          // Dropdown of Departments
          CustomDropdown.search(
              selectedValue: selectedDepartment?.toJson(),
              borderRadius: BorderRadius.circular(AppSizes.s15),
              borderSide: Theme.of(context)
                  .inputDecorationTheme
                  .enabledBorder
                  ?.borderSide,
              hintText: 'Department',
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
              items: departments?.map((dep) => dep.toJson()).toList(),
              nameKey: "title",
              onChanged: (value) =>
                  selectedDepartment = DepartmentModel.fromJson(value),
              onRemoveClicked: () => selectedDepartment = null,
              contentPadding: Theme.of(context)
                  .inputDecorationTheme
                  .contentPadding
                  ?.resolve(LocalizationService.isArabic(context: context)
                      ? TextDirection.rtl
                      : TextDirection.ltr)),
          gapH32,
          Center(
              child: CustomElevatedButton(
                  title: 'FILTER',
                  onPressed: () async => Navigator.pop(context))),
        ],
      ),
    );
    filterEmployees();
  }
}















// import 'package:employees/modules/profiles/models/employee.model.dart';
// import 'package:employees/services/crud_operation.service.dart';
// import 'package:flutter/material.dart';

// class EmployeesListViewModel extends ChangeNotifier {
//   List<EmployeeModel>? employees;
//   bool isLoading = true;
//   void updateLoadingStatus({required bool laodingValue}) {
//     isLoading = laodingValue;
//     notifyListeners();
//   }

//   Future<void> initializeEmployeesListScreen(BuildContext context) async {
//     updateLoadingStatus(laodingValue: true);
//     await _getEmployees(context);
//     updateLoadingStatus(laodingValue: false);
//   }

//   Future<void> _getEmployees(BuildContext context) async {
//     // get user notification
//     try {
//       final result = (await CrudOperationService.readEntities(
//         context: context,
//         slug: 'users',
//         // queryParams: {
//         // 'page': 1,
//         // 'with': 'cate',
//         // 'trash': 1,
//         // 'scope': 'filter',
//         // },
//       ));
//       if (result.success && result.data != null) {
//         var employeesData = result.data?['data'] as List<dynamic>?;
//         employees = employeesData
//             ?.map(
//                 (item) => EmployeeModel.fromJson(item as Map<String, dynamic>))
//             .toList();
//       }
//     } catch (err, t) {
//       debugPrint("error while getting employees ${err.toString()} at :- $t");
//     }
//   }
// }
