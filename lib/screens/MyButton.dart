import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressedMy,
    required this.buttonText,
    required this.buttonWidth
  });

  final void Function() onPressedMy;
  final String buttonText;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: FilledButton.styleFrom(

            backgroundColor: Colors.green,
            minimumSize: Size(buttonWidth,50)
        ),
        onPressed:onPressedMy, child: Text(buttonText));
  }
}
