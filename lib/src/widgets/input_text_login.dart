import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gpd2/src/utils/app_colors.dart';


class InputTextLogin extends StatefulWidget {
  final String iconpath, placeholder, initValue;
  final bool Function(String text) validator;
  final bool obscureText;

  const InputTextLogin(
    {Key key, 
    @required this.iconpath, 
    @required this.placeholder, 
     this.validator, 
     this.initValue = '', 
     this.obscureText = false
     }) 
    : assert(iconpath != null && placeholder != null), 
     super(key: key);

  @override
  InputTextLoginState createState() => InputTextLoginState();
}

class InputTextLoginState extends State<InputTextLogin> {
  TextEditingController _controller;
  bool _validtionOK = false;

bool get isOK => _validtionOK;
String get value => _controller.text;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initValue);
    checkValidation();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void checkValidation(){
    if(widget.validator!= null){
     final bool isOK= widget.validator(_controller.text);
     if(_validtionOK != isOK){
       setState(() {
         _validtionOK = isOK;
       });
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _controller,
      obscureText: widget.obscureText,
      onChanged: (text) => checkValidation(),
             padding: EdgeInsets.symmetric(vertical: 7, horizontal:5),
             prefix: Container(
               width: 40,
               height: 30,
               padding: EdgeInsets.all(2),
               child: SvgPicture.asset(
                 this.widget.iconpath,
               color: Color(0xffdddddd),
               ),
             ),
             suffix: widget.validator != null?Icon(
               Icons.
               check_circle,
               color: _validtionOK ? AppColors.primary : Colors.black12,
               ):null,
             placeholder: this.widget.placeholder,
             style:TextStyle(fontFamily:'sans'),
             placeholderStyle: TextStyle(fontFamily:'sans', color: Color(0xffcccccc)),
             decoration: BoxDecoration(
               border: Border(
                 bottom: BorderSide(
                   width: 1,
                   color: Color(0xffdddddd),
                 ),
                 ),
             ),
           );
    
  }
}