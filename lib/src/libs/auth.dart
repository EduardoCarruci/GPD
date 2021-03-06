import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gpd2/src/pages/login_page.dart';
import 'package:gpd2/src/utils/dialogs.dart';

class Auth {
  Auth._internal();
  static Auth get instance => Auth._internal();
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> get user async {
    return (await _fireBaseAuth.currentUser());
  }

  Future<FirebaseUser> loginByPassword(
    BuildContext context,{
      @required String email,
      @required String password,
    })async{
      ProgressDialog progressDialog = ProgressDialog(context);
      try {
       progressDialog.show();
       final AuthResult result = await _fireBaseAuth.signInWithEmailAndPassword(
         email: email, password: password);

         progressDialog.dismiss();
       
       if(result.user != null){
        return result.user;
       }
       return null;

      } on PlatformException catch (e) {
        print(e);
         progressDialog.dismiss();
          String message = "";
      if (e.code == "ERROR_USER_NOT_FOUND") {
        message = "Email inválido. Usuario no encontrado";
      } else {
        message = e.message;
      }

      Dialogs.alert(context, title: "ERROR", descripcion: message);
        return null;
      }
    }

  Future<FirebaseUser> facebook(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();

      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == 200) {
        print("facebook login ok");
        // final userData = await FaebookAuth.instance.getUserData();
        // print(userData);

        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);

        final AuthResult authResult =
            await _fireBaseAuth.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;
        print("facebook username: ${user.displayName} ");
        progressDialog.dismiss();
        return user;
      } else if (result.status == 403) {
        print("facebook login cancelled");
      } else {
        print("facebook login failed");
      }
      progressDialog.dismiss();
      return null;
    } catch (e) {
      print(e);
      progressDialog.dismiss();
      return null;
    }
  }

  Future<FirebaseUser> google(BuildContext context) async{
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      
      progressDialog.show();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication authentication = 
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: authentication.idToken, 
        accessToken: authentication.accessToken
        );
      
     final AuthResult result =
     await _fireBaseAuth.signInWithCredential(credential);
        
     final FirebaseUser user = result.user;   
     print("username: ${user.displayName}");
     progressDialog.dismiss();
     return user;
    } catch (e) {
      print(e);
      progressDialog.dismiss();
      return null;
    }
    
  }

Future<FirebaseUser> signUp({
  BuildContext context,
  @required String username,  
  @required String email,
  @required String password,
 }) async{

    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      
      progressDialog.show();

     final AuthResult result = 
     await _fireBaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
        );

        if(result.user != null){
          final UserUpdateInfo userUpdateInfo = UserUpdateInfo();
          userUpdateInfo.displayName = username;
          await result.user.updateProfile(userUpdateInfo);
          progressDialog.dismiss();
          return result.user;
        }
      
     progressDialog.dismiss();
     return null;//para controlar el email repetido
    } on PlatformException catch (e) {
      String message = "Unknown error";
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        message = e.message;
      } else if (e.code == "ERROR_WEAK_PASSWORD") {
        message = e.message;
      }
      print(e);
      progressDialog.dismiss();
      Dialogs.alert(context, title: "ERROR", descripcion: message);
      return null;
    }
    
  }

  Future<bool> sendResetEmailLink(BuildContext context,
  {@required String email}) async{
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      await _fireBaseAuth.sendPasswordResetEmail(email: email);
      progressDialog.dismiss();
      return true;
   } on PlatformException catch (e) {
      print(e);
      progressDialog.dismiss();
      Dialogs.alert(context, title: "ERROR", descripcion: e.message);
      return false;
    }
  }

  Future<void> logDut(BuildContext context) async{
    final String providerId = (await user).providerData[0].providerId;
    print("providerId $providerId");
    switch(providerId){
      case "Facebook.com": 
     await FacebookAuth.instance.logOut();
       break;
        case "google.com": 
        await _googleSignIn.signOut();
       break;
        case "password": 
       break;
        case "phone": 
       break;
    } 
   await _fireBaseAuth.signOut();
   Navigator.pushNamedAndRemoveUntil(
     context, LoginPage.routeName, (_) => false);
  }
} 