import 'package:flutter/material.dart';


class PaginaPrin extends StatelessWidget {
  const PaginaPrin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return AspectRatio(
      aspectRatio: 28/11,
          child: LayoutBuilder(
            builder: (_, contraints){
              return Container(
               child: Stack(
                 children: <Widget>[
                   
                   Positioned(
                     top:0,
                     left: 0,
                     right: 0,
                     child: Image.asset('assets/img/gpd3.png'),
                     ),
                  
                 ],
               ),
             );
            }
          ),
    );
  }
}