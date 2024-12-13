import 'package:flutter/material.dart';

class AutoCompleteInput extends StatefulWidget {
  final List<String> names;
  final String labelText;
  const AutoCompleteInput({super.key, required this.names, required this.labelText});

  @override
  State<AutoCompleteInput> createState() => _AutoCompleteInputState();
}

class _AutoCompleteInputState extends State<AutoCompleteInput> {
  @override
  Widget build(BuildContext context) {
  return Autocomplete<String>(
    optionsBuilder: (TextEditingValue nameTextEditingValue) {
      if (nameTextEditingValue.text == '') {
        return const Iterable<String>.empty();
      }
      return widget.names.where(
        (x) => x.toLowerCase().contains(nameTextEditingValue.text.toLowerCase()),
      );
    },
    onSelected: (String value) {
      debugPrint('You just selected $value');
    },
    fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
      return TextField(
        controller: textEditingController,
        focusNode: focusNode,
        onSubmitted: (String value) {
          onFieldSubmitted();
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.labelText
        ),
      );
    },
  );
}
}
