import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpd2/src/libs/auth.dart';
import 'package:gpd2/src/pages/home_page.dart';
import 'package:gpd2/src/utils/app_colors.dart';
import 'package:gpd2/src/utils/dialogs.dart';
import 'package:gpd2/src/utils/extras.dart';
import 'package:gpd2/src/utils/responsive.dart';
import 'package:gpd2/src/widgets/input_text_login.dart';
import 'package:gpd2/src/widgets/rounderd_button.dart';


class RegisterForm extends StatefulWidget {
  final VoidCallback onGoToLogin;
  final Alignment alignment;
  const RegisterForm(
      {Key key,
      @required this.onGoToLogin,
      this.alignment = Alignment.bottomCenter})
      : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _agree = false;

  final GlobalKey<InputTextLoginState> _usernameKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _emailKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _passwordKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _vpasswordKey = GlobalKey();

  void _goTo(FirebaseUser user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, Homepage.routeName);
    } else {
      print("register failed");
    }
  }

  _submit() async {
    final String username = _usernameKey.currentState.value;
    final String email = _emailKey.currentState.value;
    final String password = _passwordKey.currentState.value;
    final String vpassword = _vpasswordKey.currentState.value;

    final bool usernameOk = _usernameKey.currentState.isOK;
    final bool emailOk = _emailKey.currentState.isOK;
    final bool passwordOk = _passwordKey.currentState.isOK;
    final bool vpasswordOk = _vpasswordKey.currentState.isOK;

    if (usernameOk && emailOk && passwordOk && vpasswordOk) {
      if (_agree) {
        final FirebaseUser user = await Auth.instance.signUp(
          context: context,
          username: username,
          email: email,
          password: password,
        );

        _goTo(user);
      } else {
        Dialogs.alert(context,
            descripcion: "you need to accept the terms and conditions");
      }
    } else {
      Dialogs.alert(context, descripcion: "Some fields are invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Align(
      alignment: widget.alignment,
      child: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          constraints: BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Nueva cuenta",
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 30,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Nesecita un plomero, Electricista, Carpintero o algun otro tipo de servicio. Registrate aqui..",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: responsive.ip(2),
                ),
                InputTextLogin(
                  key: _usernameKey,
                  iconpath: 'assets/icon/user.svg',
                  placeholder: "Username",
                  validator: (text) {
                    return text.trim().length > 0;
                  },
                ),
                SizedBox(
                  height: responsive.ip(2),
                ),
                InputTextLogin(
                  key: _emailKey,
                  iconpath: 'assets/icon/email.svg',
                  placeholder: "Email",
                  //keyboardType: TextInputType.emailAddress,
                  validator: (text) => Extras.isValidEmail(text),
                ),
                SizedBox(
                  height: responsive.ip(2),
                ),
                InputTextLogin(
                  key: _passwordKey,
                  iconpath: 'assets/icon/key.svg',
                  placeholder: "Password",
                  obscureText: true,
                  validator: (text) {
                    _vpasswordKey.currentState?.checkValidation();
                    return text.trim().length >= 6;
                  },
                ),
                SizedBox(
                  height: responsive.ip(2),
                ),
                InputTextLogin(
                  key: _vpasswordKey,
                  obscureText: true,
                  iconpath: 'assets/icon/key.svg',
                  placeholder: "Confirm Password",
                  validator: (text) {
                    return text.trim().length >= 6 &&
                        _vpasswordKey.currentState.value ==
                            _passwordKey.currentState.value;
                  },
                ),
                SizedBox(
                  height: responsive.ip(2),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: responsive.ip(1.70),
                      color: Theme.of(context).textTheme.subtitle.color),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        value: _agree,
                        onChanged: (isChecked) {
                          setState(() {
                            _agree = isChecked;
                          });
                        },
                      ),
                      Text("Acepto los "),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Términos de servicios",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(" & "),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Política",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: responsive.ip(2),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: widget.onGoToLogin,
                      child: Text("←Regresar"),
                    ),
                    SizedBox(width:10),
                    RounderdButton(
                      label: 'Crear',
                      onPressed:_submit, 
                      ),
                    
                  ],
                ),
                SizedBox(height: responsive.ip(2),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
