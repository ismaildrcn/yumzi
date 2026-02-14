import 'package:flutter/material.dart';

class AutocompleteController extends TextEditingController {
  String suggestion = ""; // backendden gelen tamamlayici

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final text = value.text;

    if (suggestion.isEmpty || !suggestion.startsWith(text)) {
      return TextSpan(text: text, style: style);
    }

    final remaining = suggestion.substring(text.length);

    return TextSpan(
      children: [
        TextSpan(
          text: text,
          style: style?.copyWith(
            color: Colors.black, // kullanicinin yazdigi
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: remaining,
          style: style?.copyWith(
            color: Colors.grey, // autocomplete kismi
          ),
        ),
      ],
    );
  }
}
