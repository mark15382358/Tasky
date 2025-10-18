import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.value,required this.onChanged});
  final bool value;
 final Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value:value,
      activeColor: Color(0xff15B86C),
      onChanged: (value)=>onChanged(value),
    );
  }
}
