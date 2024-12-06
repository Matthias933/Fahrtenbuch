import 'package:flutter/material.dart';

class CustomCheckBoxInput extends StatefulWidget {
  final String description;
  bool value;
  CustomCheckBoxInput({super.key, required this.description, required this.value});

  @override
  State<CustomCheckBoxInput> createState() => _CustomCheckBoxInputState();
}

class _CustomCheckBoxInputState extends State<CustomCheckBoxInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.value,
          onChanged: (value) {
            setState(() {
              widget.value = value ?? false;
            });
          },
        ),
        Text(widget.description)
      ],
    );
  }
}
