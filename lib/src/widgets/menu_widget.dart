import 'package:flutter/material.dart';
import 'package:gpd2/src/pages/home.dart';
import 'package:gpd2/src/pages/login_page.dart';
import 'package:gpd2/src/pages/perfil.dart';
import 'package:gpd2/src/pages/settings_page.dart';



class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox( height: 35.0 ),
       DrawerHeader(
         
         child: Container(),
         
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage('assets/img/gpd1.png'),
             fit: BoxFit.cover
             )
         ),
         ),
         ListTile(
           leading: Icon(Icons.home, color: Colors.blue),
           title: Text('Inicio'),
           onTap: ()=> Navigator.pushReplacementNamed(context, HomePrin.routeName),
         ),
          ListTile(
           leading: Icon(Icons.account_circle, color: Colors.blue),
           title: Text('Accede a tu perfil'),
           onTap: ()=> Navigator.pushReplacementNamed(context, LoginPage.routeName),
         ),
          ListTile(
           leading: Icon(Icons.folder_shared, color: Colors.blue),
           title: Text('Perfil'),
           onTap: ()=> Navigator.pushReplacementNamed(context, Perfil.routeName),
         ),
          ListTile(
           leading: Icon(Icons.contact_phone, color: Colors.blue),
           title: Text('Reportar Usuario'),
           onTap: (){},
         ),
         ListTile(
           leading: Icon(Icons.call, color: Colors.blue),
           title: Text('Contactos'),
           onTap: (){},
         ),
         ListTile(
           leading: Icon(Icons.folder_shared, color: Colors.blue),
           title: Text('Sobre GPD'),
           onTap: (){},
         ),
          ListTile(
           leading: Icon(Icons.settings, color: Colors.blue),
           title: Text('Settings'),
           onTap: ()=> Navigator.pushReplacementNamed(context, SettingsPage.routeName),
         ),

      ],
    ),
  );
  }
}