import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/painter/points/logic/history_cubit/history_provider.dart';

import 'package:provider/provider.dart';

class HistoryItem extends StatelessWidget {
  HistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 1: Parse the date string from the API

    return Consumer<HistoryProvider>(
      builder: (context, provider, child) {
        if (provider.state == HistoryState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.state == HistoryState.failure) {
          return Center(
            child: Text('Error: ${provider.errorMessage}'),
          );
        } else if (provider.state == HistoryState.success) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                children: provider.historyModel!.history!.map(
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
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 0,
                            offset: Offset(0, 1),
                            blurRadius: 10)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/png/gift.png'),
                            height: 40,
                            width: 40,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  e.title!,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff464646),
                                  ),
                                ),
                                SizedBox(
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
                                        ? Color(0xffE6007E)
                                        : Color(0xffFF0004),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  formattedDate,
                                  style: TextStyle(
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
          return Center(
            child: ElevatedButton(
              onPressed: () {
                provider.getHistory();
              },
              child: Text('Load History'),
            ),
          );
        }
      },
    );
  }
}
