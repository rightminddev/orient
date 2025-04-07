import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/payroll.model.dart';
import '../view_models/payroll_details.viewmodel.dart';
import 'widgets/payroll_details_body.widget.dart';
import 'widgets/payroll_details_header.widget.dart';

class PayrollDetailsScreen extends StatefulWidget {
  final PayrollModel? payroll;
  const PayrollDetailsScreen({super.key, required this.payroll});

  @override
  State<PayrollDetailsScreen> createState() => _PayrollDetailsScreenState();
}

class _PayrollDetailsScreenState extends State<PayrollDetailsScreen> {
  late final PayrollDetailsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = PayrollDetailsViewModel();
    // viewModel.initializePayrollDetailsScreen(
    //     context: context,
    //     payrollId: widget.payroll?.id?.toString(),
    //     empId: widget.payroll?.userId?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<PayrollDetailsViewModel>(
          create: (_) => viewModel,
          child: Consumer<PayrollDetailsViewModel>(
              builder: (context, viewModel, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PayrollDetailsHeaderWidget(
                        payroll: widget.payroll,
                      ),
                      Expanded(
                          child:
                              PayrollDetailsBodyWidget(payroll: widget.payroll))
                    ],
                  ))),
    );
  }
}
