import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpd2/src/utils/app_colors.dart';


class RedesBotton extends StatelessWidget {
  final String iconPath;
  final double size;
  final Color backgroudColor;
  final VoidCallback onPressed;
  const RedesBotton({
    Key key, 
    this.size = 50, 
    this.backgroudColor, 
    @required this.iconPath, 
    @required this.onPressed
    }) 
    : //assert(iconPath == null),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: this.onPressed,
      padding: EdgeInsets.zero,
      child: Container(
      width: this.size,
      height: this.size,
      padding: EdgeInsets.all(15),
      child: SvgPicture.asset(iconPath, color: Colors.white,),
      decoration: BoxDecoration(
        color: this.backgroudColor ?? AppColors.primary,
        shape: BoxShape.circle,
      ),
    ), 
      );
  }
}