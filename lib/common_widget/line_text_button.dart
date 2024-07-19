import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class LineTextButton extends StatelessWidget {
  final String title;
  final String placeholder;
  final String value;
  final VoidCallback onPressed;

  const LineTextButton({
    super.key,
    required this.title,
    required this.placeholder,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
              color: TColor.textTittle,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              value == "" ? placeholder : value,
              style: TextStyle(
                  color: value == "" ? TColor.placeholder : TColor.textTittle,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 1,
          color: const Color(0xffE2E2E2),
        )
      ],
    );
  }
}
