import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpd2/src/libs/auth.dart';
import 'package:gpd2/src/pages/home_page.dart';
import 'package:gpd2/src/utils/extras.dart';
import 'package:gpd2/src/utils/responsive.dart';
import 'package:gpd2/src/widgets/input_text_login.dart';
import 'package:gpd2/src/widgets/redes_boxtton.dart';
import 'package:gpd2/src/widgets/rounderd_button.dart';


class Loginform extends StatefulWidget {
  final VoidCallback onGoToResgister, onGoToForgotPassword;

  const Loginform(
    {Key key,
    @required this.onGoToResgister, 
    @required this.onGoToForgotPassword}) 
    : super(key: key);

  @override
  _LoginformState createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  final GlobalKey<InputTextLoginState> _emailKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _passwordKey = GlobalKey();

  void _goTo(FirebaseUser user){
   if (user != null){
     Navigator.pushReplacementNamed(context, Homepage.routeName);
   }else{
     print('login failed');
   }
  }

  Future<void> _submit() async{
    final String email = _emailKey.currentState.value;
    final String password = _passwordKey.currentState.value;

    final bool emailOk = _emailKey.currentState.isOK;
    final bool passwordOk = _passwordKey.currentState.isOK;

    if(emailOk && passwordOk) {
     final FirebaseUser user = await Auth.instance
     .loginByPassword(context, email: email, password: password);

     _goTo(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
          child: SafeArea(
          top: false,
          child: Container(
          width: 300,
          child: SingleChildScrollView(
                  child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 SizedBox(height:responsive.ip(4)),
                 InputTextLogin(
                   key: _emailKey,
                   iconpath: 'assets/icon/email.svg', 
                   placeholder: 'Email',
                   validator: (text) => Extras.isValidEmail(text),
                   ),
                  SizedBox(height:responsive.ip(2.7)),
                   InputTextLogin(
                     key: _passwordKey,
                   iconpath: 'assets/icon/key.svg', 
                   placeholder: 'Contraseña',
                   obscureText: true,
                   validator: (text) {
                    return text.trim().length >= 6;
                  },
                   ),
                   Container(
                     width: double.infinity,
                     alignment: Alignment.centerRight,
                     child: CupertinoButton(
                     padding: EdgeInsets.symmetric(vertical:15),
                     child: Text('Olvidate la Contraseña',
                       style: TextStyle(
                         fontFamily: 'sans'
                       ),
                       ), 
                     onPressed: widget.onGoToForgotPassword,
                     ),
                   ),
                     RounderdButton(
                       label: 'Iniciar',
                       onPressed: this._submit, 
                       ),

                  SizedBox(height:responsive.ip(2)),

                Text('Registrate con:'),
                SizedBox(height:responsive.ip(0.7)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RedesBotton(
                      size: 55,
                      iconPath: 'assets/icon/face.svg',
                      backgroudColor: Color(0xff44BAFF),
                      onPressed: () async{
                       final user = await Auth.instance.facebook(context);
                        _goTo(user);
                      },
                      
                    ),
                    SizedBox(width:20),
                    RedesBotton(
                      size: 55,
                      iconPath: 'assets/icon/google.svg',
                      backgroudColor: Color(0xffE53935),
                      onPressed: () async{
                      final user = await Auth.instance.google(context);
                       _goTo(user);
                      },
                    ),
                  ],
                ),
                SizedBox(height:responsive.ip(2.7)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Si no tiene cuenta?'),
                    CupertinoButton(
                      child: Text(
                        'Regístrate',
                        style: TextStyle(
                          fontFamily:'sans',
                          fontWeight: FontWeight.w600,
                        ),
                        ), 
                      onPressed: widget.onGoToResgister,
                      )
                      
                  ],
                ),
                 SizedBox(height:responsive.ip(2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}