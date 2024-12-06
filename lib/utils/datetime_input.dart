// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDateTimeInput extends StatefulWidget {
  final String labelText;
  const CustomDateTimeInput({super.key, required this.labelText});

  @override
  State<CustomDateTimeInput> createState() => _CustomDateTimeInput();
}

class _CustomDateTimeInput extends State<CustomDateTimeInput> {

  late TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),
      ),
      readOnly: true,
      onTap: () {
        print('clicked me');
        selectDate();
      },
    );
  }

  Future<void> selectDate() async{
    DateTime? pickedDate =  await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100),
    );
    
    if(pickedDate != null){
      setState(() {
        dateController.text = pickedDate.toString().split(" ")[0];
      });
    }
  }
}