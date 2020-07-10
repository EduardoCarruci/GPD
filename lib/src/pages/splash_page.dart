import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpd2/src/libs/auth.dart';
import 'package:gpd2/src/pages/home_page.dart';
import 'package:gpd2/src/pages/login_page.dart';

class SplashPage extends StatefulWidget {

  static final routeName = 'splash';

  // SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {

@override
  void afterFirstLayout(BuildContext context) {
    Auth.instance.user.then((FirebaseUser user){
      if (user == null){
        Navigator.pushReplacementNamed(context, Homepage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    }
    );
    
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
    
  }
}