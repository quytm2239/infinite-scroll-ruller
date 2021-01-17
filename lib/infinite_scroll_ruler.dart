import 'package:flutter/material.dart';
import 'package:infinite_scroll_ruler/ruler_step_view.dart';

class InfiniteScrollRuler extends StatefulWidget {
  InfiniteScrollRuler({Key key}) : super(key: key);

  @override
  _InfiniteScrollRulerState createState() => _InfiniteScrollRulerState();
}

class _InfiniteScrollRulerState extends State<InfiniteScrollRuler> {
  var scrollController = ScrollController();
  var itemCount = 10;

  @override
  void initState() {
    super.initState();
    // scrollController.addListener(() {
    //   print(scrollController.position);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return NotificationListener<ScrollEndNotification>(
    //   onNotification: (scrollEnd) {
    //     var metrics = scrollEnd.metrics;
    //     if (metrics.atEdge) {
    //       if (metrics.pixels == 0)
    //         print('At top');
    //       else
    //         print('At bottom');
    //     }
    //     return true;
    //   },
    //   child: ListView.builder(
    //       physics: ClampingScrollPhysics(),
    //       controller: scrollController,
    //       itemCount: 20,
    //       itemBuilder: (context, index) {
    //         return RulerStepView(
    //           value: index.toDouble(),
    //         );
    //       }),
    // );

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollEnd) {
        if (scrollEnd is ScrollUpdateNotification) {
          var metric = scrollEnd.metrics;
          print(metric.pixels);
          print(metric.viewportDimension);
        }
        var metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          if (metrics.pixels == 0)
            print('At top');
          else
            print('At bottom');
        }
        return true;
      },
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: (index) {
          print(index);
        },
        itemExtent: RulerStepView.stepCount * RulerStepView.stepHeight,
        squeeze: 1.05, // adjust space of each item
        controller: scrollController,
        childDelegate: ListWheelChildBuilderDelegate(
            childCount: itemCount,
            builder: (context, index) {
              return RulerStepView(
                value: index.toDouble() + 1,
                isFirst: index == 0,
                isLast: index == itemCount - 1,
              );
            }),
      ),
    );
  }
}
