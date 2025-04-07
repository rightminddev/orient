import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../common_modules_widgets/custom_floating_action_button.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../models/request.model.dart';
import '../../../routing/app_router.dart';
import '../../../services/requests.services.dart';
import '../view_models/requests_calendar.viewmodel.dart';

class RequestsCalendarScreen extends StatelessWidget {
  final List<RequestModel>? requests;
  final GetRequestsTypes requestType;
  const RequestsCalendarScreen(
      {super.key, this.requests, required this.requestType});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RequestsCalendarViewModel>(
        create: (_) => RequestsCalendarViewModel(),
        child: Consumer<RequestsCalendarViewModel>(
            builder: (context, viewModel, child) {
          return TemplatePage(
              pageContext: context,
              floatingActionButton: CustomFloatingActionButton(
                iconPath: AppImages.addFloatingActionButtonIcon,
                onPressed: () async => await context
                    .pushNamed(AppRoutes.addRequest.name, pathParameters: {
                  'type': 'mine',
                  'lang': context.locale.languageCode
                }),
                tagSuffix: 'add',
                height: AppSizes.s16,
                width: AppSizes.s16,
              ),
              title: AppStrings.calendar.tr(),
              actions: [
                PopupMenuButton<CalendarView>(
                  initialValue: viewModel.calendarView,
                  onSelected: (val) => viewModel.updateCalendarView(val),
                  itemBuilder: (BuildContext context) {
                    return viewModel.calendarViews
                        .map((Map<String, dynamic> view) {
                      return PopupMenuItem<CalendarView>(
                        value: view['value'],
                        child: Text(
                          view['name'],
                          style: TextStyle(
                              color: viewModel.calendarView == view['value']
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.primary,
                              fontSize: AppSizes.s14,
                              fontWeight:
                                  viewModel.calendarView == view['value']
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                        ),
                      );
                    }).toList();
                  },
                  icon: Icon(
                    Icons.preview_outlined,
                    size: AppSizes.s32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.s12),
                  ),
                ),
              ],
              body: Padding(
                padding: const EdgeInsets.all(AppSizes.s12),
                child: SfCalendar(
                  backgroundColor: Colors.white,
                  key: UniqueKey(),
                  view: viewModel.calendarView ?? CalendarView.schedule,
                  dataSource: RequestDataSource(requests!),
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                    showAgenda: true,
                  ),
                  showNavigationArrow: true,
                  appointmentBuilder: (context, details) {
                    final request = details.appointments.first as RequestModel?;
                    return GestureDetector(
                      onTap: () async {
                        await context.pushNamed(
                          AppRoutes.requestDetails.name,
                          extra: request,
                          pathParameters: {
                            'type': RequestsServices.getRequestsTypeStr(
                                type: requestType),
                            'lang': context.locale.languageCode,
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.s4),
                          color: viewModel.getStatusColor(
                              request?.status?.value?.toLowerCase().trim()),
                        ),
                        child: viewModel.calendarView == CalendarView.month
                            ? null
                            : Center(
                                child: AutoSizeText(
                                  request?.user?.name ??
                                      request?.username ??
                                      request?.user?.username ??
                                      '',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ));
        }));
  }
}

class RequestDataSource extends CalendarDataSource {
  RequestDataSource(List<RequestModel> requests) {
    appointments = requests;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].dateFrom!);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments![index].dateTo!);
  }

  @override
  String getSubject(int index) {
    return appointments?[index]?.user?.name ?? '';
  }

  @override
  Color getColor(int index) {
    switch (
        (appointments![index].status.value as String).toLowerCase().trim()) {
      case 'approved':
        return Colors.green;
      case 'refused':
        return Colors.red;
      case 'canceled':
        return Colors.yellow;
      case 'seen':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
