import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final String labelText;
  const CustomTextInput({super.key, required this.labelText});
  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.labelText
      ),
    );
  }
}