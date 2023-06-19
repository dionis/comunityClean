import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: ThemeWidget.colorPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fixedSize: Size(MediaQuery.of(context).size.width * 0.6, 50)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
