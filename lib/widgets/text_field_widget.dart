import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  Function(int) onChanged;
  TextFieldWidget({super.key, required this.onChanged});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Enter Value'),
      onChanged: (value) {
        widget.onChanged(int.tryParse(value) ?? 0);
        // BarWidget.updateValue(int.tryParse(value) ?? 0);
      },
    );
  }
}
