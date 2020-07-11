import 'package:flutter/material.dart';
import 'package:gpd2/src/pages/home_page.dart';
import 'package:gpd2/src/pages/login_page.dart';
import 'package:gpd2/src/pages/splash_page.dart';

void main() => runApp(MyApp());
// generar cambios nuevos cambios intento diosito 
//agregandome
//prueba 12
//CAMBIO
class MyApp extends StatelessWidget {
  


  




  //RECIBIR
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
        fontFamily: 'sans'
      ),
      home: LoginPage(),
      routes: {
        Homepage.routeName: (_) => Homepage(),
        SplashPage.routeName: (_) => SplashPage(),
        LoginPage.routeName: (_) => LoginPage(),
      },
    );
  }
}

