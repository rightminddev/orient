import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../models/request.model.dart';

class CustomTabbarViewRequestDetails extends StatelessWidget {
  final RequestModel request;
  const CustomTabbarViewRequestDetails({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final mainTextStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(fontSize: AppSizes.s10);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s8, vertical: AppSizes.s12),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(AppSizes.s30),
              ),
              height: AppSizes.s64,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.s6, vertical: AppSizes.s6),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color(0xff9C4995),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                labelColor: Colors.white,
                labelStyle: mainTextStyle,
                unselectedLabelStyle: mainTextStyle,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: AppSizes.s6),
                      child: const Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'REASON',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppSizes.s6),
                    child: const Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'MANAGER RESPONSE',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: AppSizes.s6),
                      child: const Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'INFO',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s8, vertical: AppSizes.s8),
                child: TabBarView(
                  children: [
                    Text(
                      request.reason ?? '',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      request.theManagerReply ?? '',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      request.notes ?? '',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
