import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpd2/src/utils/app_colors.dart';


class RounderdButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final backgroundColor;
  const RounderdButton({
    Key key, 
    @required this.onPressed, 
    @required this.label, 
    this.backgroundColor}) 
    : assert(label != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Container( 
        child: Text(
          this.label, 
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'sans',
            letterSpacing: 1,
            fontSize: 15
          ),
          ),
          padding: EdgeInsets.symmetric(horizontal:55, vertical:10),
          decoration: BoxDecoration(
            color:this.backgroundColor ?? AppColors.primary, 
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius:5,
              )
            ],
            borderRadius: BorderRadius.circular(30)
          ),
      ), 
      onPressed:this.onPressed,
      );
  }
}