import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_sizes.dart';

class TemplatePage extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final BuildContext pageContext;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottomAppbarWidget;
  final Widget? bottomSheet;

  /// used if you want to active [PULLTOREFRESH] option to page.
  final Future<void> Function()? onRefresh;
  const TemplatePage(
      {super.key,
      this.actions,
      this.bottomAppbarWidget,
      this.backgroundColor,
      this.bottomSheet,
      required this.pageContext,
      required this.title,
      required this.body,
      this.floatingActionButton,
      this.onRefresh});

  @override
  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      bottomSheet: bottomSheet,
      appBar: AppBar(
        actions: actions,
        backgroundColor:
            backgroundColor ?? Theme.of(pageContext).scaffoldBackgroundColor,
        title: Text(
          title,
          style: Theme.of(pageContext)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Theme.of(pageContext).colorScheme.primary),
        ),
        bottom: bottomAppbarWidget,
        leading: context.canPop()
            ? Padding(
                padding: const EdgeInsets.all(AppSizes.s10),
                child: InkWell(
                  onTap: () => pageContext.pop(),
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: Theme.of(pageContext).primaryColor,
                    size: AppSizes.s18,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
      body: onRefresh != null
          ? RefreshIndicator.adaptive(
              onRefresh: onRefresh!,
              child: ListView(
                children: [
                  body,
                ],
              ),
            )
          : SafeArea(child: body),
    );
  }
}
