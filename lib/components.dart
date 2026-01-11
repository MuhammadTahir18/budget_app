import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Opensans extends StatelessWidget {
  final text;
  final color;
  final size;
  final fontWeight;
  const Opensans({
    super.key,
    required this.text,
    this.color,
    required this.size,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color == null ? Colors.black : color,
        fontWeight: fontWeight == null ? FontWeight.normal : fontWeight,
      ),
    );
  }
}

DialogBox(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(32.0),
        actionsAlignment: MainAxisAlignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 2.0, color: Colors.black),
        ),
        title: Opensans(text: title, size: 20.0),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Colors.black,
            child: Opensans(text: "Ok", color: Colors.white, size: 20),
          ),
        ],
      );
    },
  );
}

snakBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      behavior: SnackBarBehavior.floating,

      duration: const Duration(seconds: 2),
    ),
  );
}

class Poppins extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontweight;
  const Poppins({
    super.key,
    required this.text,
    required this.size,
    this.color,
    this.fontweight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color == null ? Colors.black : color,
        fontSize: size,
        fontWeight: fontweight == null ? FontWeight.normal : fontweight,
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  final text;
  final containerWidth;
  final hintText;
  final controller;
  final validator;
  final digitsOnly;

  const TextForm({
    super.key,
    required this.text,
    required this.containerWidth,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.digitsOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Opensans(text: text, size: 14.0),
        SizedBox(height: 5.0),
        SizedBox(
          width: containerWidth,
          child: TextFormField(
            validator: validator,
            inputFormatters: digitsOnly != null
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            controller: controller,
            decoration: InputDecoration(
              errorBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedErrorBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              hintStyle: GoogleFonts.poppins(fontSize: 13.0),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
