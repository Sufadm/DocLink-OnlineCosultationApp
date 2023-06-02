import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldName extends StatelessWidget {
  const TextFormFieldName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is Required';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          hintText: 'Enter the name',
          hintStyle: GoogleFonts.lato()),
    );
  }
}

class TextFormFieldAge extends StatelessWidget {
  const TextFormFieldAge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Age is Required';
          } else {
            return null;
          }
        },
        maxLength: 2,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Enter your Age',
          hintStyle: GoogleFonts.lato(),
          border: const OutlineInputBorder(),
        ));
  }
}
