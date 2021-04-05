import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  var isSelected;

  GestureTapCallback onPressed;

  CheckBoxWidget({this.isSelected = false, @required this.onPressed});

  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        child: widget.isSelected
            ? AnimatedSwitcher(
                duration: const Duration(milliseconds: 2000),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              )
            : Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
      ),
    );
  }
}
