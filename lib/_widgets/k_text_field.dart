import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:peanut_api_test/main.export.dart';

class KTextField extends HookWidget {
  final String? name;
  final TextEditingController? controller;
  final String? initialValue;
  final bool isRequired;
  final String? title;
  final TextStyle? titleStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final int maxLines;
  final int? maxLength;
  final List<FormFieldValidator<String>> validators;
  final bool useShadow;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Function(String value)? onChanged;
  final Widget? suffixIcon;
  final bool isDance;

  const KTextField({
    super.key,
    this.name,
    this.controller,
    this.initialValue,
    this.isRequired = false,
    this.title,
    this.titleStyle,
    this.hintText,
    this.hintStyle,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.borderRadius,
    this.fillColor,
    this.maxLines = 1,
    this.maxLength,
    this.validators = const [],
    this.useShadow = true,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.onChanged,
    this.suffixIcon,
    this.isDance = false,
  });

  @override
  Widget build(BuildContext context) {
    final hidePass = useState(isPasswordField);

    final inputDecor = InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      fillColor: fillColor,
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      isDense: isDance,
      suffixIcon:
          suffixIcon ??
          (isPasswordField
              ? IconButton(
                  onPressed: () => hidePass.value = !hidePass.value,
                  icon: hidePass.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                )
              : null),
      border: KAppTheme.inputBorder().copyWith(borderRadius: borderRadius),
      enabledBorder: KAppTheme.inputBorder().copyWith(borderRadius: borderRadius),
      focusedBorder: KAppTheme.inputBorder(focus: true).copyWith(borderRadius: borderRadius),
      errorBorder: KAppTheme.inputBorder(error: true).copyWith(borderRadius: borderRadius),
    );
    Widget field = TextField(
      maxLines: maxLines,
      controller: controller,
      obscureText: hidePass.value,
      keyboardType: keyboardType,
      cursorHeight: 16,
      cursorWidth: 1.4,
      decoration: inputDecor,
      maxLength: maxLength,
      onChanged: onChanged,
    );
    if (name != null) {
      field = FormBuilderTextField(
        name: name!,
        initialValue: initialValue,
        maxLines: maxLines,
        maxLength: maxLength,
        controller: controller,
        obscureText: hidePass.value,
        keyboardType: keyboardType,
        cursorHeight: 16,
        cursorWidth: 1.4,
        decoration: inputDecor,
        validator: FormBuilderValidators.compose([if (isRequired) FormBuilderValidators.required(), ...validators]),
        onChanged: (v) => onChanged?.call(v ?? ''),
      );
    }

    return Column(
      crossAxisAlignment: .start,
      spacing: Insets.sm,
      children: [
        if (title != null)
          Text(
            title!,
            style: titleStyle ?? context.text.labelLarge?.bold.textColor(context.colors.outline.mat9),
          ).required(isRequired),

        field,
      ],
    );
  }
}
