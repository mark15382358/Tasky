import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines,
     this.hintText,
    this.validator,
     this.title,
  });
  final TextEditingController controller;
  final int? maxLines;
  final String? hintText;
  final String? title;
  // final Function (String? value)?validator;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(title??"No title", style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(height: 8),

          TextFormField(
            validator: validator,
            maxLines: maxLines,
            controller: controller,

            decoration: InputDecoration(
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
