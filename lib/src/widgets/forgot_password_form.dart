import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:gpd2/src/libs/auth.dart';
import 'package:gpd2/src/pages/home_page.dart';
import 'package:gpd2/src/utils/app_colors.dart';
import 'package:gpd2/src/utils/responsive.dart';
import 'package:gpd2/src/widgets/input_text_login.dart';
import 'package:gpd2/src/widgets/rounderd_button.dart';


class ForgotPasswordForm extends StatefulWidget {
  final VoidCallback onGoToLogin;
  const ForgotPasswordForm({Key key,@required this.onGoToLogin}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool _agree = false;

  void _goTo(BuildContext context, FirebaseUser user){
   if (user != null){
     Navigator.pushReplacementNamed(context, Homepage.routeName);
   }else{
     print('login failed');
   }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Align(
      alignment: Alignment.center,
          child: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:15),
          constraints: BoxConstraints(
            maxWidth: 400
          ),
          child: SingleChildScrollView(
                  child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text('Cambia tu Contraseña',
                 style: TextStyle(
                   color: AppColors.primary,
                   fontSize: 25,
                   fontFamily: 'raleway',
                   fontWeight: FontWeight.bold
                 ),
                 ),
                 Text('Nesecita un plomero, Electricista, Carpintero o algun otro tipo de servicio. Cambia tu Contraseña aqui..',
                 style: TextStyle(
                   fontWeight: FontWeight.w300,
                 ),
                 ),
                 SizedBox(height: responsive.ip(5),),
                 InputTextLogin(
                   iconpath: 'assets/icon/email.svg', 
                   placeholder: 'Email',
                   ),
                  SizedBox(height: responsive.ip(3),),
                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: widget.onGoToLogin, 
                          child: Text('<-Regresar')
                          ),
                       RounderdButton(
                       label: 'Enviar',
                       onPressed: (){}, 
                       ),
                      ],
                    ),             
                     
                       SizedBox( height: responsive.ip(2),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}