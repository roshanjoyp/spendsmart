import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final double width;
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;

  const CustomElevatedButton({
    super.key,
    required this.width,
    required this.text,
    required this.onTap,
    required this.isLoading,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  CustomElevatedButtonState createState() => CustomElevatedButtonState();
}

class CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: widget.isLoading ? null : widget.onTap,
        child: widget.isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(widget.textColor),
              )
            : Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                ),
              ),
      ),
    );
  }
}
