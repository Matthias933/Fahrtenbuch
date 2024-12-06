import 'package:flutter/material.dart';

class CustomDropdownInput extends StatefulWidget {
  final String title;
  final List<String> items;

  CustomDropdownInput({Key? key, required this.items, required this.title});

  @override
  _CustomDropdownInputState createState() => _CustomDropdownInputState();
}

class _CustomDropdownInputState extends State<CustomDropdownInput> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(widget.title),
        ),
        Center(
          child: DropdownButton<String>(
            isExpanded: true,
            items: widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedValue = newValue;
                });
              }
            },
            value: selectedValue,
            dropdownColor: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}
