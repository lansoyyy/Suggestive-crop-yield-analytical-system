import 'package:crop_analytical_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String? hint;
  bool? isObscure;
  final TextEditingController controller;
  final double? width;
  final double? height;
  final int? maxLine;
  final TextInputType? inputType;
  final bool? isPassword;

  TextFieldWidget(
      {super.key,
      required this.label,
      this.hint = '',
      required this.controller,
      this.isObscure = false,
      this.width = 300,
      this.height = 40,
      this.maxLine = 1,
      this.isPassword = false,
      this.inputType = TextInputType.text});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextRegular(text: widget.label, fontSize: 12, color: Colors.black),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            keyboardType: widget.inputType,
            decoration: InputDecoration(
              suffixIcon: widget.isPassword!
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget.isObscure = !widget.isObscure!;
                        });
                      },
                      icon: widget.isObscure!
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.visibility_off),
                    )
                  : const SizedBox(),
              hintText: widget.hint,
              border: InputBorder.none,
            ),
            maxLines: widget.maxLine,
            obscureText: widget.isObscure!,
            controller: widget.controller,
          ),
        ),
      ],
    );
  }
}
