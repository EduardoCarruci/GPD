import 'package:flutter/material.dart';
import 'package:gpd2/src/pages/home.dart';
import 'package:gpd2/src/pages/home_page.dart';
import 'package:gpd2/src/pages/login_page.dart';
import 'package:gpd2/src/pages/settings_page.dart';
import 'package:gpd2/src/pages/splash_page.dart';
import 'src/libs/preferencias_usuario/preferencias_usuario.dart';


  //COMENTARIO PARA TRAER DATOS



void main() async {
WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
  runApp(MyApp());
}
//add
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
   final prefs = new PreferenciasUsuario();
    print(prefs.token);


    return MaterialApp(
      title: 'GPD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
        fontFamily: 'sans'
      ),
      home: HomePrin(),
      routes: {
        HomePrin.routeName: (_) => HomePrin(),
        Homepage.routeName: (_) => Homepage(),
        SplashPage.routeName: (_) => SplashPage(),
        LoginPage.routeName: (_) => LoginPage(),
        SettingsPage.routeName: (_) => SettingsPage(),
      },
    );
  }
}

