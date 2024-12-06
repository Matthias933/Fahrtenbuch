import 'package:flutter/material.dart';

class CustomNumberInput extends StatefulWidget {
  final String labelText;
  CustomNumberInput({super.key, required this.labelText});

  @override
  State<CustomNumberInput> createState() => _CustomNumberInputState();
}

class _CustomNumberInputState extends State<CustomNumberInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.labelText
      ),
    );
  }
}