import 'package:flutter/material.dart';

import 'package:bar_assignment/model/bar_section_model.dart';

class BarWidget extends StatefulWidget {
  final List<BarSection> sections;
  final int arrowPositionValue;

  const BarWidget(
      {super.key, required this.sections, required this.arrowPositionValue});

  static int value = 0;

  static void updateValue(int newValue) {
    value = newValue;
    print("VALUE--> $value");
  }

  @override
  _BarWidgetState createState() => _BarWidgetState();
}

class _BarWidgetState extends State<BarWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("Value --> ${widget.arrowPositionValue}");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sectionWidgets = [];

    for (var section in widget.sections) {
      sectionWidgets.add(
        Expanded(
          flex: ((section.end - section.start) * 10).toInt(),
          child: Container(
            color: section.color,
          ),
        ),
      );
    }

    List<Widget> labels = [];

    // add the labels at the bottom
    labels = getLebels(widget.sections);
    double arrowLeftPosition = calculatePosition(
        widget.sections[0].start.toString(),
        widget.sections.last.end.toString(),
        widget.arrowPositionValue.toString());

    // print(
    //     "Value Pos --> ${widget.arrowPositionValue} --> $arrowLeftPosition-->");

    return Column(
      children: [
        Align(
          // bottom: 0,

          alignment: Alignment(arrowLeftPosition, 0),
          child: Container(
            height: 30,
            child: const Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: sectionWidgets,
                  ),
                ),
              ),
              ...labels,
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> getLebels(List<BarSection> sections) {
    List<Widget> labels = [];
    for (var section in widget.sections) {
      labels.add(
        Positioned(
          bottom: -20,
          left: section.start * 3.1,
          child: Text(
            section.start.toInt().toString(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    }
    labels.add(
      Positioned(
        bottom: -20,
        left: widget.sections.last.end * 3.05,
        child: Text(
          widget.sections.last.end.toInt().toString(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
    return labels;
  }

  double calculatePosition(String min, String max, String value) {
    if ((max.isEmpty || max == "0.0") && (min.isEmpty || min == "0.0")) {
      return double.tryParse(value) ?? 0.0;
    }

    var maxDouble = double.parse(max);
    var minDouble = double.parse(min);
    var valueDouble = double.parse(value);

    double result = 0;

    double normalized_value =
        (valueDouble - minDouble) / (maxDouble - minDouble);

//     # Scale the value to the range [-1, 1]
    result = (2 * normalized_value - 1);
    print(
        "Normalize $normalized_value ---> $result --> ${(2 * normalized_value)}");

    if (result < -1) {
      return -1;
    } else if (result > 1) {
      return 1;
    }

    return result;
  }
}
