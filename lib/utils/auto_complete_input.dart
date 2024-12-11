import 'package:flutter/material.dart';

class AutoCompleteInput extends StatefulWidget {
  final List<String> names;
  const AutoCompleteInput({super.key, required this.names});

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
        return widget.names.where((x) => x.toLowerCase().contains(nameTextEditingValue.text.toLowerCase())).toList();
      },
      onSelected: (String value) {
        debugPrint('You just selected $value');
      },
    );
  }
}
