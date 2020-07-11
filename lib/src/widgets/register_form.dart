import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpd2/src/libs/auth.dart';
import 'package:gpd2/src/pages/home_page.dart';
import 'package:gpd2/src/utils/app_colors.dart';
import 'package:gpd2/src/utils/responsive.dart';
import 'package:gpd2/src/widgets/input_text_login.dart';
import 'package:gpd2/src/widgets/rounderd_button.dart';


class Registerform extends StatefulWidget {
  final VoidCallback onGoToLogin;
  const Registerform({Key key,@required this.onGoToLogin}) : super(key: key);

  @override
  _RegisterformState createState() => _RegisterformState();
}

class _RegisterformState extends State<Registerform> {
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
      alignment: Alignment.bottomCenter,
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
                 Text('Crear tu Cuenta',
                 style: TextStyle(
                   color: AppColors.primary,
                   fontSize: 25,
                   fontFamily: 'raleway',
                   fontWeight: FontWeight.bold
                 ),
                 ),
                 Text('Nesecita un plomero, Electricista, Carpintero o algun otro tipo de servicio. Registrate Aqui..',
                 style: TextStyle(
                   fontWeight: FontWeight.w300,
                 ),
                 ),
                 SizedBox(height: responsive.ip(3),),
                 InputTextLogin(
                   iconpath: 'assets/icon/user.svg', 
                   placeholder: 'Nombre Usuario',
                   ),
                 SizedBox(height: responsive.ip(2),),
                 InputTextLogin(
                   iconpath: 'assets/icon/email.svg', 
                   placeholder: 'Email',
                   ),
                  SizedBox( height: responsive.ip(2),),
                   InputTextLogin(
                   iconpath: 'assets/icon/key.svg', 
                   placeholder: 'Contraseña',
                   ),
                    SizedBox( height: responsive.ip(2),),
                   InputTextLogin(
                   iconpath: 'assets/icon/key.svg', 
                   placeholder: 'Confimar Contraseña',
                   ),
                   DefaultTextStyle(
                     style: TextStyle(
                       fontSize: responsive.ip(1.8),
                       color: Theme.of(context).textTheme.subtitle.color
                     ), 
                     child: Wrap(
                     crossAxisAlignment: WrapCrossAlignment.center,
                     children: <Widget>[
                       Checkbox(
                         value: _agree, 
                         onChanged: (isCheked){
                           setState(() {
                             _agree = isCheked;
                           }
                           );
                         },
                         ),
                         Text('Acepto los '),
                         InkWell(
                           onTap:(){},
                           child: Text('Terminos del servicio ',
                           style: TextStyle(
                             color: AppColors.primary,
                             fontWeight: FontWeight.bold
                           ),
                           ),
                         ),
                         Text('& '),
                          InkWell(
                           onTap:(){},
                           child: Text('Politica',
                           style: TextStyle(
                             color: AppColors.primary,
                             fontWeight: FontWeight.bold
                           ),
                           ),
                         ),
                     ],
                   ),
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: widget.onGoToLogin, 
                          child: Text('<-Regresar')
                          ),
                       RounderdButton(
                       label: 'Crear',
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