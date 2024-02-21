import 'package:bar_assignment/model/bar_section_model.dart';
import 'package:bar_assignment/widgets/arrow_notifier.dart';
import 'package:bar_assignment/widgets/bar_Widget.dart';
import 'package:bar_assignment/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ArrowValueNotifier arrowValueNotifier = ArrowValueNotifier();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
            valueListenable: arrowValueNotifier.valueNotifier,
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFieldWidget(
                    onChanged: (textValue) {
                      print("Value --> $textValue");
                      arrowValueNotifier.changePosition(value: textValue);
                    },
                  ),
                  const SizedBox(height: 20),
                  BarWidget(
                    arrowPositionValue: arrowValueNotifier.valueNotifier.value,
                    sections: [
                      BarSection(
                          label: 'Dangerous',
                          color: Colors.red,
                          start: 0,
                          end: 30),
                      BarSection(
                          label: 'Moderate',
                          color: Colors.orange,
                          start: 30,
                          end: 40),
                      BarSection(
                          label: 'Ideal',
                          color: Colors.green,
                          start: 40,
                          end: 60),
                      BarSection(
                          label: 'Moderate',
                          color: Colors.orange,
                          start: 60,
                          end: 70),
                      BarSection(
                          label: 'Dangerous',
                          color: Colors.red,
                          start: 70,
                          end: 120),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
