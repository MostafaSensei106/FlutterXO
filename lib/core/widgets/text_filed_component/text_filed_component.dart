import 'package:flutter/material.dart'
    show
        StatelessWidget,
        TextEditingController,
        IconData,
        Widget,
        ValueChanged,
        BuildContext,
        Radius,
        AutovalidateMode,
        TextInputType,
        Icon,
        Theme,
        BorderRadius,
        BorderSide,
        OutlineInputBorder,
        InputDecoration,
        FocusScope,
        TextFormField;
import '../../config/const/sensei_const.dart' show SenseiConst;
import '../../config/fonts/fonts.dart' show AppTextStyle;

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    required this.controller,
    required this.icon,
    required this.hint,
    super.key,
    this.onChange,
    this.suffixIcon,
    this.isNumeric = false,
    this.errorText,
    this.readOnly = false,
    this.maxLength = 0,
    this.isExpands = false,
    this.largeField = false,
    this.useOutBorderRadius = false,
  });
  final TextEditingController controller;
  final IconData icon;
  final Widget? suffixIcon;
  final String hint;
  final String? errorText;
  final bool useOutBorderRadius;
  final bool isNumeric;
  final bool isExpands;
  final bool largeField;
  final int maxLength;
  final bool readOnly;

  final ValueChanged<String>? onChange;

  /// Validates the input value based on the component's configuration.
  ///
  /// Returns the [errorText] if the field is required and the value is null or empty.
  /// If the field is numeric, returns an error message if the value is not a valid number.
  /// Returns null if the value passes all validations.

  @override
  /// Builds a [TextFormField] based on the component's configuration.
  //
  /// The input value is validated based on the component's configuration.
  /// If the field is required and the value is null or empty, an error message is displayed.
  /// If the field is numeric, an error message is displayed if the value is not a valid number.
  //
  /// If the component is numeric, the [keyboardType] is set to [TextInputType.number],
  /// otherwise it is set to [TextInputType.text].
  //
  /// When the user taps outside the field, the focus is removed from the field.
  //
  /// The [prefixIcon] is used to display an icon based on the [icon] argument.
  /// The [suffixIcon] is used to display a suffix icon if provided.
  //
  /// The [decoration] is used to customize the appearance of the field.
  /// The [filled] property is set to true, and the [fillColor] is set to the surface color of the theme.
  /// The [focusedBorder] is set to an [OutlineInputBorder] with a primary color border and a width of 0.2.
  /// The [border] is set to an [OutlineInputBorder] with no border and a circular border radius of [SenseiConst.inBorderRadius.r].
  Widget build(final BuildContext context) => TextFormField(
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    cursorRadius: const Radius.circular(SenseiConst.inBorderRadius),
    keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    onFieldSubmitted: (final value) => FocusScope.of(context).nextFocus(),
    onTapOutside: (final event) => FocusScope.of(context).unfocus(),
    onChanged: onChange,
    readOnly: readOnly,
    maxLines: isExpands
        ? null
        : largeField
        ? 5
        : 1,
    minLines: 1,
    enableInteractiveSelection: true,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, size: SenseiConst.iconSize),
      hintText: hint,
      errorText: errorText,
      suffixIcon: suffixIcon,
      hintStyle: AppTextStyle(context).subtitle,
      errorStyle: AppTextStyle(
        context,
      ).subtitle.copyWith(color: Theme.of(context).colorScheme.error),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainer,
      focusedBorder: OutlineInputBorder(
        borderRadius: useOutBorderRadius
            ? BorderRadius.circular(SenseiConst.outBorderRadius)
            : BorderRadius.circular(SenseiConst.inBorderRadius),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: useOutBorderRadius
            ? BorderRadius.circular(SenseiConst.outBorderRadius)
            : BorderRadius.circular(SenseiConst.inBorderRadius),
      ),
    ),
  );
}
