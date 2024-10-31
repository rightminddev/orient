import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/points/data/models/history_model.dart';
import 'package:orient/painter/points/logic/history_cubit/history_cubit.dart';
import 'package:orient/painter/points/logic/history_cubit/history_state.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 1: Parse the date string from the API

    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state is GetHistorySuccessState) {
          if (state.historyModel.history!.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  children:
                      HistoryCubit.get(context).historyModel!.history!.map(
                (e) {
                  String apiDate = e.createdAt!;
                  DateTime parsedDate =
                      DateTime.parse(apiDate); // Parses ISO 8601 format

                  // Step 2: Format the parsed date
                  String formattedDate =
                      DateFormat('MMM d, yyyy').format(parsedDate);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 0,
                              offset: const Offset(0, 1),
                              blurRadius: 10)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Image(
                              image: AssetImage('assets/images/png/gift.png'),
                              height: 40,
                              width: 40,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    e.title!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff464646),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  e.operation == 'deposit'
                                      ? "+${e.points} points"
                                      : "-${e.points} points",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: e.operation == 'deposit'
                                        ? const Color(0xffE6007E)
                                        : const Color(0xffFF0004),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    formattedDate,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList()),
            );
          } else {
            return const Center(
              child: Text("No History Found"),
            );
          }
        } else if (state is GetHistoryFailureState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
