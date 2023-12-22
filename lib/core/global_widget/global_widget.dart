import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.type,
    required this.prefix,
    required this.controllerName,
    required this.label,
    required this.validate,
    this.suffix,
    this.textColor,
    this.readOnly = false,
  });
  final Icon? suffix;
  final Function validate;
  final String label;
  final Icon prefix;
  final TextEditingController controllerName;
  final TextInputType type;
  final Color? textColor;
  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = false;
  @override
  void initState() {
    if (widget.type == TextInputType.visiblePassword) obscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      style: StylesText.newDefaultTextStyle.copyWith(
        color:
            widget.textColor ?? context.read<ThemeCubit>().globalAppTheme.text,
      ),
      cursorColor: Colors.blue,
      controller: widget.controllerName,
      keyboardType: widget.type,
      validator: (val) {
        return widget.validate(val);
      },
      obscureText: obscure,
      decoration: InputDecoration(
        fillColor: Colors.white12,
        filled: true,
        prefixIconColor: Colors.grey,
        labelText: widget.label,
        border: InputBorder.none,
        suffixIconColor: Colors.grey,
        prefixIcon: widget.prefix,
        prefixStyle: const TextStyle(color: Colors.blue),
        suffixIcon: widget.suffix != null
            ? IconButton(
                onPressed: () {
                  obscure = !obscure;
                  setState(() {});
                },
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : Container(
                width: 0,
              ),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 0,
            )),
        labelStyle: StylesText.newDefaultTextStyle.copyWith(color: Colors.grey),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1,
            )),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final double height;
  final double? width;
  final String text;
  final Function onPress;
  final Color borderColor;
  final TextStyle textStyleForButton;
  final List<Color>? colors;
  const CustomButton({
    super.key,
    required this.text,
    required this.height,
    this.width,
    required this.onPress,
    required this.borderColor,
    required this.textStyleForButton,
    this.colors,
  });
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          onPress();
        },
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 0),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: colors ??
                  [
                    theme.primary,
                    theme.secondary,
                  ],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
              child: Text(
            text,
            style: textStyleForButton,
          )),
        ));
  }
}
