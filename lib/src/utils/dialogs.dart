import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Dialogs{
 static void alert(BuildContext context, {String title, String descripcion}){
   showDialog(context: context,
   child: CupertinoAlertDialog(
     title: title!=null?Text(title):null,
     content: descripcion!=null?Text(descripcion):null,
     actions: <Widget>[
       CupertinoDialogAction(
         child: Text("OK"),
         onPressed: () => Navigator.pop(context),
         )
     ],
   ),
   );
 }

}



class ProgressDialog{
 final BuildContext context;
  ProgressDialog(this.context);

void show(){
showCupertinoModalPopup(
  context: this.context, 
  builder: (_) =>Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: CupertinoActivityIndicator(
        radius:15,
      ),
    )
  );

  
}
 

  void dismiss(){
    Navigator.pop(context);
  }
}