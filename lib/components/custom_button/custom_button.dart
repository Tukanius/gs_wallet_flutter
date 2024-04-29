import 'package:flutter/material.dart';
import 'package:green_score/widget/ui/color.dart';

class CustomButton extends StatefulWidget {
  final String labelText;
  final Function()? onClick;
  final bool? isLoading;
  final Color? buttonColor;
  final Color? textColor;
  final double? height;
  CustomButton({
    this.textColor,
    this.isLoading,
    this.onClick,
    this.labelText = '',
    this.buttonColor,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: widget.height ?? 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.buttonColor,
        ),
        child: ElevatedButton(
          onPressed: widget.isLoading == false ? widget.onClick : () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading == true)
                Container(
                  margin: EdgeInsets.only(
                    right: 15,
                  ),
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: white,
                    strokeWidth: 2.5,
                  ),
                ),
              Text(
                widget.labelText.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: widget.textColor == null ? white : widget.textColor,
                ),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            shadowColor: Colors.transparent,
            backgroundColor: widget.buttonColor,
          ),
        ),
      ),
    );
  }
}
