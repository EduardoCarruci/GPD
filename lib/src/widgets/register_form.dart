import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpd2/src/pages/login_page.dart';
import 'package:gpd2/src/utils/app_colors.dart';
import 'package:gpd2/src/utils/responsive.dart';
import 'package:gpd2/src/avz_widgets/Flushbar.dart';

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
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  //CONTROLADORES DE CAJAS DE TEXTO ( INPUT  )

  bool _agree = false;

  final _formKey =
      GlobalKey<FormState>(); // KEY PARA VALIDAR CADA UNA DE LOS INPUTS




  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Align(
      alignment: widget.alignment,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            //constraints: BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //CONTROLADORES
                    inputfield("Correo", "Introduce un Correo", controllerEmail,
                        TextInputType.emailAddress),
                    SizedBox(
                      height: responsive.ip(2),
                    ),
                    inputfield("Password", "Introduce una Password",
                        controllerPassword, TextInputType.text),
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
                      height: responsive.ip(2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: widget.onGoToLogin,
                          child: Text("←Regresar",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent)),
                        ),
                        SizedBox(width: 10),
                        MaterialButton(
                          child: Center(
                            child: Text("Crear"),
                          ),
                          color: Colors.blue,
                          minWidth: 200,
                          height: 50,
                          onPressed: () {
                            // BOTON DE CREAR EL REGISTRO DEL CLIENTE SE DEBE VALIDAR CADA UNAS DE LAS OPCIONES
                            // COMO POR EJEMPLO CORREO VALIDO
                            // CONTRASEÑA DE MAS DE 6 DIGITOS..
                            //  LUEGO DE LA INTRODUCCION DEL USUARIO SE DEBE MOSTRAR ALGUNA ANIMACION
                            // PARA EFECTOS DEL LOADING
                            // AL MISMO TIEMPO SE DEBE ENVIAR UN MENSAJE POR PANTALLA EN CASO DE OBTENER ALGUNA EXPCECION
                            // Y MANTENER LA PANTALLA
                            // PARA VALIDAR CADA UNO DE LOS MENSAJES POR PANTALLA SE REALIZARAN NOTIFICACIONES - ALERTAS - AVISOS
                            // Y SE DEBE AGREGAR UN ELEMENTO DE LOADING EJEMPLO ---------------"ALERDIALOG"-----------------
                            if (_formKey.currentState.validate() &&
                                _agree == true) {
                              save();
                            } else {
                              print("invalido");
                              AlertDialog();
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: responsive.ip(2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void save() async {
    if (_formKey.currentState.validate() && _agree == true) {
      try {
        // FUNCIONES PARA REGISTRAR EL USUARIO CORRESPONDIENTES A LA DATABASE Y AUTH .

        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: controllerEmail.text.trim(), // SE RECIBE POR PARAMETRO CADA UNA DE LOS STRING QUE CONTIENEN EL TEXTO
                password: controllerPassword.text.trim()) // Y TAMBIEN SE  ELIMINAR LOS ESPACIOS DENTRO DE ESA CADENA
            .then((currentUser) => Firestore.instance
                    .collection("usuarios")  // SE CREA UNA COLECCION DONDE CONTENDREMOS LOS SIGUIENTES DATOS
                    .document(currentUser.user.uid) //  SE RECIBE POR PARAMETRO EL ID AUTO GENERADO DE ESE DOCUMENTO
                    .setData({
                  "uid": currentUser.user.uid, // Y SE CREA UNA ESTRUCTURA DE DATOS DE TIPO MAPA DONDE CONTENDRAN LOS VALORES DEL ID
                  "email": controllerEmail.text.trim(), //  Y EL CORREO
              
                }).then((result) { //  LUEGO DE QUE SE TERMINAR DE CREAR EL REGISTRO DE AMBAS TUPLAS
                  print("success"); //  SE DEBE GENERAR EL CIERRE DEL "LOADING" - - - - Y ENVIAR HA ALGUNA OTRA PANTALLA O BORRAR LOS CAMPOS
                  /* ClientDatabaseProvider.db
                      .addUserRegister(controllerEmail.text.trim());
                  Navigator.pop(context);

                  CustomFlush().showCustomBar(context, "Creado");
                  Timer(Duration(milliseconds: 1500), () {
                    Navigator.pop(context);

                  
                  }); */
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                }).catchError((err) {
                  //  Navigator.pop(context);

                  // BARRA PERSONALIZADA PARA EL MUESTREO DE LOS MENSAJES ESTE CORRESPONDE A LA MALA ASIGNACION DE LOS DATOS 
                  // DENTRO DE LA COLECCION DE USUARIOS
                  CustomFlush().showCustomBar(context, err.toString());
                  Timer(Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });

                  print(err);
                }))
            .catchError((err) {
          //   Navigator.pop(context);
          // ESTE MUESTREO CORRESPONDE AL IMPEDIMIENTO DEL REGISTRO DE LA AUTENTICACION DEL USUARIO
          CustomFlush().showCustomBar(context, err.toString());
          Timer(Duration(seconds: 2), () {
            Navigator.pop(context);
          });

          print(err);
        });// EN CASO DE FALLAR LOS DOS PROCESOS ANTERIORES EXPUESTOS SE GENERA ESTA EXCEPCION 
        //
      } catch (error) {
        //Navigator.pop(context);
        CustomFlush().showCustomBar(context, error.toString());
        Timer(Duration(seconds: 2), () {
          Navigator.pop(context);
        });

        print(error.toString());
      }
    } else {
      // Y EN CASO DE TENER EL FORMULARIO INVALIDO SE GENERA ESTA EXCEPCION
      CustomFlush().showCustomBar(context, "Debes completar los campos");
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }
  // WIDGET NENCESARIO PARA IDENTIFICAR CADA UNO DE LOS INPUTS
  Widget inputfield(String hintText, String validator,
      TextEditingController controller, TextInputType input) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return '' + validator.toString();
        }
        return null;
      },
      obscureText: hintText == "Password" ? true : false,
      controller: controller,
      keyboardType: input,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.blue),
        focusColor: Colors.blue,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelText: hintText,
      ),
    );
  }
}
