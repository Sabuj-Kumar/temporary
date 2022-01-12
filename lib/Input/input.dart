import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField(
      {Key? key,
      this.keyboardType,
      this.controller,
      this.inputAction,
      this.level,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      required this.obscured})
      : super(key: key);
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? obscured;
  final String? hint;
  final String? level;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool obscured;
  @override
  void initState() {
    obscured = widget.obscured!;
    super.initState();
  }

  String validityCheck(String s) {
    if (s == "Username") {
      return "Enter The First Name.";
    } else if (s == "Email") {
      return "Enter The Email";
    } else if (s == "Password") {
      return "Enter The Password";
    } else if (s == "Salary") {
      return "Enter The Salary";
    } else {
      return "Enter Password Again";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10, bottom: 0.8, top: 0.8),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 5,
        shadowColor: Colors.black,
        child: TextFormField(
            controller: widget.controller,
            textInputAction: widget.inputAction,
            keyboardType: widget.keyboardType,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
            obscureText: obscured,
            obscuringCharacter: '*',
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: widget.level,
                labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
                hintText: widget.hint,
                hintStyle: const TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    letterSpacing: 1),
                prefixIcon: Icon(widget.prefixIcon),
                suffixIcon: !widget.obscured!
                    ? Icon(widget.suffixIcon)
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            obscured = !obscured;
                          });
                        },
                        icon: obscured
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                errorStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2, style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                        style: BorderStyle.solid)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Colors.lightBlue,
                        width: 2,
                        style: BorderStyle.solid))),
            validator: (value) {
              if (value!.isEmpty) {
                return validityCheck(widget.hint.toString());
              }
              return null;
            }),
      ),
    );
  }
}
