import 'package:ecommerce/const/color.dart';
import 'package:ecommerce/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/string.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final double? verticalPadding;
  final TextInputType? inputType;
  final bool? isError;
  final bool? isEnabled;
  final int? length;
  final bool? compulsory;
  final double? horizontalPadding;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormat;
  final double? borderRadius;
  final AutovalidateMode? autoValidateMode;
  final Widget? prefix;
  final Color? color;
  final int? line;
  final bool? enableInteractiveSelection;

  const TextFieldWidget(
      {super.key,
      this.textFieldName,
      required this.textController,
      this.hintText,
      this.verticalPadding,
      this.autoValidateMode,
      this.focusNode,
      this.inputType,
      this.isError,
      this.isEnabled,
      this.length,
      this.borderRadius,
      this.compulsory,
      this.onChanged,
      this.horizontalPadding,
      this.inputFormat,
      this.prefix,
      this.color,
      this.validator,
      this.line,
      this.enableInteractiveSelection});

  final String? textFieldName;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final textTheme = theme.textTheme;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textFieldName != null)
          Padding(
            padding: const EdgeInsets.only(left: 14.0, bottom: 3),
            child: Row(
              children: [
                Text(textFieldName ?? '',
                    style: GoogleFonts.nunito(
                        color: kTextColor, fontWeight: FontWeight.w800)),
                if (compulsory == null || compulsory == true)
                  Text(
                    ' *',
                    style: textTheme.bodySmall
                        ?.merge(const TextStyle(color: Colors.red)),
                  )
              ],
            ),
          ),
        SizedBox(
          width: width - 16,
          child: TextFormField(
            focusNode: focusNode,
            maxLength: length,
            controller: textController..text,
            textInputAction: TextInputAction.next,
            keyboardType: inputType ?? TextInputType.text,
            enabled: isEnabled,
            onChanged: onChanged,
            validator: validator,
            maxLines: line,
            inputFormatters: inputFormat,
            decoration: InputDecoration(
                hintText: hintText,
                counterText: "",
                prefixIcon: prefix,
                prefixStyle: const TextStyle(color: Colors.black),
                suffixIcon: (isError ?? false)
                    ? const Icon(Icons.error_outline, color: Colors.red)
                    : null,
                border: border(color, theme, borderRadius),
                enabledBorder: border(color, theme, borderRadius),
                errorBorder: border(color, theme, borderRadius),
                focusedErrorBorder: border(color, theme, borderRadius),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                contentPadding: const EdgeInsets.only(left: 20.0, top: 10),
                focusedBorder: border(color, theme, borderRadius)),
          ),
        ),
      ],
    );
  }
}

class LoginTextField extends StatelessWidget {
  final String? hintText;
  final double? verticalPadding;
  final TextInputType? inputType;
  final bool? isError;
  final bool? isEnabled;
  final int? length;
  final bool? isMandatory;
  final double? horizontalPadding;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormat;
  final double? borderRadius;
  final AutovalidateMode? autoValidateMode;
  final Widget? prefix;
  final Widget? suffix;
  final Color? color;
  final int? line;

  const LoginTextField(
      {super.key,
      this.textFieldName,
      required this.textController,
      this.hintText,
      this.verticalPadding,
      this.autoValidateMode,
      this.focusNode,
      this.inputType,
      this.isError,
      this.isEnabled,
      this.length,
      this.borderRadius,
      this.isMandatory,
      this.onChanged,
      this.horizontalPadding,
      this.inputFormat,
      this.prefix,
      this.color,
      this.validator,
      this.line,
      this.suffix});

  final String? textFieldName;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final textTheme = theme.textTheme;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: focusNode,
          maxLength: length,
          controller: textController..text,
          textInputAction: TextInputAction.next,
          keyboardType: inputType ?? TextInputType.text,
          enabled: isEnabled,
          onChanged: onChanged,
          validator: validator,
          maxLines: line,
          inputFormatters: inputFormat,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: "",
            hintStyle: const TextStyle(color: Color(0xffC9C9C9)),
            filled: true,
            fillColor: kContainerColor,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField(
      {super.key,
      required this.obscureText,
      required this.textController,
      this.onFieldSubmitted,
      this.validator,
      this.verticalPadding,
      required this.onEnter,
      this.borderRadius,
      this.hintText,
      this.passwordFocus});

  final TextEditingController textController;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEnter;
  final double? verticalPadding;
  final bool obscureText;
  final String? Function(String?)? validator;
  final FocusNode? passwordFocus;
  final double? borderRadius;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: passwordFocus,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(fontSize: 15),
      controller: textController..text,
      obscureText: obscureText,
      obscuringCharacter: '*',
      validator: validator,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: "",
          suffixIcon: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onEnter,
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xffC9C9C9),
                size: 18,
              ),
            ),
          ),
        hintStyle: const TextStyle(color: Color(0xffC9C9C9)),
        filled: true,
        fillColor: kContainerColor,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
      ),

    );
  }
}

class SearchField extends StatelessWidget {
  final double? horizontalPadding;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormat;
  final double? borderRadius;
  final bool? filled;
  final String? hintText;
  final double? height;
  final double? widthField;
  final void Function()? onMicTap;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffix;

  const SearchField(
      {super.key,
        required this.textController,
        this.focusNode,
        this.borderRadius,
        this.onChanged,
        this.horizontalPadding,
        this.inputFormat,
        this.validator,
        this.filled,
        this.hintText,
        this.height,
        this.onMicTap,
        this.widthField,
        this.onFieldSubmitted,
        this.suffix});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color = const Color(0xffD9D9D9);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 16, vertical: 8),
      child: SizedBox(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: focusNode,
          controller: textController,
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: inputFormat,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            enabled: true,
            suffixIcon: suffix,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14, color: kGrey),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SvgPicture.asset(SvgPictures.search, color: theme.primaryColor),
            ),
            filled:  true,
            fillColor: Colors.white,
            border: searchBorder(color, theme, borderRadius ?? 15, filled),
            enabledBorder: searchBorder(color, theme, borderRadius ?? 15, filled),
            errorBorder: searchBorder(color, theme, borderRadius ?? 15, filled),
            focusedErrorBorder: searchBorder(color, theme, borderRadius ?? 15, filled),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            focusedBorder: searchBorder(color, theme, borderRadius ?? 15, filled),
          ),
        ),
      ),
    );
  }
}

InputBorder? searchBorder(
        Color? color, ThemeData theme, double? borderRadius, bool? filled) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
      borderSide: BorderSide(
          color:
              filled == true || filled == null ? Colors.white : color ?? kGrey),
    );

InputBorder? border(Color? color, ThemeData theme, double? borderRadius) =>
    OutlineInputBorder(
        borderSide: BorderSide(color: color ?? theme.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 25)));
