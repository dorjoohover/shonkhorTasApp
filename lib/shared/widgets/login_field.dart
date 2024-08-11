import 'package:app/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const LoginField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Pallete.borderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Pallete.gradient2,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
