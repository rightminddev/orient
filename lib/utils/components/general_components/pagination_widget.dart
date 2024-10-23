import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  final bool isLoading;
  final VoidCallback firstFetch;
  final VoidCallback paginationFetch;
  final Widget scrollableWidget;
  final ScrollController scrollController;
  final int flex;
  final int currentCount;
  const PaginationWidget({
    super.key,
    required this.isLoading,
    required this.firstFetch,
    required this.paginationFetch,
    required this.scrollableWidget,
    required this.scrollController,
    this.flex = 1,
    required this.currentCount,
  });

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  ValueNotifier<bool> optionToJumpToTop = ValueNotifier<bool>(false);

  @override
  void initState() {
    widget.scrollController.addListener(() {
      if (widget.scrollController.hasClients) {
        if (widget.scrollController.position.pixels >=
                widget.scrollController.position.maxScrollExtent &&
            !widget.isLoading) {
          widget.paginationFetch.call();
          optionToJumpToTop.value = true;
        } else if (widget.scrollController.offset ==
            widget.scrollController.initialScrollOffset) {
          optionToJumpToTop.value = false;
        }
      }
    });

    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   widget.firstFetch.call();
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    optionToJumpToTop.dispose();
    super.dispose();
  }

  Future<void> animateToTop() async {
    if (widget.scrollController.hasClients) {
      ///animate to top
      await widget.scrollController.animateTo(0,
          curve: Curves.bounceIn, duration: const Duration(milliseconds: 500));
    }
  }

  void jumpToTop() {
    if (widget.scrollController.hasClients) {
      ///animate to top
      widget.scrollController.jumpTo(0);
    }
  }

  void fetchData() {
    jumpToTop();
    widget.firstFetch.call();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: optionToJumpToTop,
      builder: (context, value, child) {
        return Expanded(
          child: Stack(
            children: [
              Column(
                children: [
                  widget.isLoading && widget.currentCount == 1
                      ? const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(child: CircularProgressIndicator()),
                            ],
                          ),
                        )
                      : Expanded(
                          flex: widget.flex,
                          child: RefreshIndicator(
                            onRefresh: () async => fetchData(),
                            child: widget.scrollableWidget,
                          ),
                        ),
                  if (widget.isLoading && widget.currentCount > 1)
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  //   SizedBox(height: 32),
                ],
              ),
              // if (optionToJumpToTop.value && widget.showFloatingButton == true)
              //   Positioned(
              //     bottom: 50.w,
              //     left: 30.w,
              //     child: FloatingActionButton(
              //       backgroundColor: AppColors.second500,
              //       onPressed: () {
              //         animateToTop();
              //       },
              //       child: Icon(
              //         Icons.arrow_upward_rounded,
              //         color: AppColors.primary500,
              //       ),
              //     ),
              //   ),
            ],
          ),
        );
      },
    );
  }
}
