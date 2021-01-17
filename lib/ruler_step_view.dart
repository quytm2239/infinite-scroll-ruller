import 'package:flutter/material.dart';

class RulerStepView extends StatelessWidget {
  static const double lineLength = 10;
  static const double mainLineLength = 30;
  static const double stepCount = 10;
  static const double stepHeight = 10;

  final double value;
  final bool isFirst;
  final bool isLast;

  const RulerStepView({Key key, this.value, this.isFirst = false, this.isLast = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainIndex = stepCount / 2;
    return Container(
      //   width: 100,
      height: stepHeight * stepCount,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text('$value KM', style: TextStyle(fontFamily: 'Verdana', fontSize: 15)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: Container(
            width: 30,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: stepCount.toInt(),
                itemBuilder: (context, index) {
                  if (isFirst && (index < 5 && index >= 0)) {
                    return makeStep(mainIndex.toInt() == index, Colors.transparent);
                  }
                  if (isLast && (index < stepCount.toInt() && index >= 6)) {
                    print(isLast);
                    return makeStep(mainIndex.toInt() == index, Colors.transparent);
                  }
                  return makeStep(mainIndex.toInt() == index, null);
                }),
          )),
        ],
      ),
    );
  }

  Widget makeStep(bool isMain, Color _color) {
    var width = isMain ? mainLineLength : lineLength;
    var color = _color ?? Colors.grey;

    return Container(
      alignment: Alignment.centerLeft,
      height: stepHeight,
      child: Column(
        children: [
          Container(
            width: width,
            height: 1,
            color: color,
          ),
          Container(
            width: 5,
            height: stepHeight - 1,
            color: Colors.transparent,
          )
        ],
      ),
    );
  }
}
