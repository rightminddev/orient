// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:otient_test/points/logic/history_cubit/history_cubit.dart';
// import 'package:otient_test/points/logic/history_cubit/history_state.dart';
// import 'package:otient_test/points/widgets/history_list.dart';
//
//
// class HistorySection extends StatelessWidget {
//   const HistorySection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HistoryCubit,HistoryState>(
//       builder: (context, state) {
//         if (state is GetHistorySuccessState) {
//           return SizedBox(
//             height: 800,
//             width: double.infinity,
//             child: HistoryList(),
//           );
//         }  else if (state is GetHistoryFailureState) {
//           return Center(
//             child: Text(state.error),
//           );
//
//         }
//         else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//       }
//     );
//   }
// }
