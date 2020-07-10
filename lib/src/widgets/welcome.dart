import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpd2/src/utils/responsive.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return AspectRatio(
      aspectRatio: 16/10,
          child: LayoutBuilder(
            builder: (_, contraints){
              return Container(
               child: Stack(
                 children: <Widget>[                   Positioned(
                     top: contraints.maxHeight*0.68,
                     child: Column(
                       children: <Widget>[
                         Container(
                          height: 3,
                          width: contraints.maxWidth,
                          color: Color(0xffeeeeee),
                         ),
                         SizedBox(height: 10,
                         ),
                         Text('Bienvenido!',
                         style: TextStyle(
                           fontSize: responsive.ip(3),
                           fontWeight: FontWeight.bold,
                           fontFamily: 'releway',
                         ),
                         )
                       ],
                     ),
                   ),
                   Positioned(
                     top:0,
                     left: 0,
                     right: 0,
                     child: SvgPicture.asset('assets/img/clouds1.svg',
                     width: contraints.maxWidth,
                     height: contraints.maxHeight*0.68,
                     )),
                   Positioned(
                     top: contraints.maxHeight*0.215,
                     left: 10,
                     child: SvgPicture.asset('assets/img/men2.svg',
                     width: contraints.maxWidth*0.25,
                     )),
                   Positioned(
                     top: contraints.maxHeight*0.25,
                     right: -3,
                     child: SvgPicture.asset('assets/img/woman3.svg',
                     width: contraints.maxWidth*0.40,
                     )),
                 ],
               ),
             );
            }
          ),
    );
  }
}