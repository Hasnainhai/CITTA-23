import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({
    super.key,
    this.hintText,
    required int maxLines,
    required this.text,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  final String text;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? Function(String?)? validator;
  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: GoogleFonts.getFont(
              "Gothic A1",
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.fontColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            color: const Color(0xfff1f1f1),
            child: TextFormField(
              keyboardType: widget.keyboardType,
              obscureText: (widget.obscureText && hidden),
              style: const TextStyle(fontSize: 15),
              controller: widget.controller,
              decoration: InputDecoration(
                // prefixText:  widget.hintText,
                hintText: widget.hintText,
                filled: true,
                suffixIcon: widget.obscureText
                    ? GestureDetector(
                        onTap: () {
                          setState(() => hidden = !hidden);
                        },
                        child: Icon(
                          hidden ? Icons.visibility_off : Icons.visibility,
                          color: hidden ? null : AppColor.primaryColor,
                          size: 30,
                        ),
                      )
                    : null,
                fillColor: const Color(0xfff1f1f1),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfff1f1f1)),
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfff1f1f1)),
                  borderRadius: BorderRadius.zero,
                ),
              ),
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
