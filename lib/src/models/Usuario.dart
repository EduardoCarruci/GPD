import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

// CLASE USUARIO

class Usuario {
  String id;
  String correo; // LA CLASE NO DEBE CONTEMPLAR LA CONTRASEÑA YA QUE DEBEMOS RESPETAR EL CIFRADO.

  Usuario({
    this.id,
    this.correo,
  });


  // el siguiente metodo nos permitira desmapear el usuario entrante a nuestro servicio
  Usuario.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        correo = snapshot['correo'];
}

// este metodo nos permitira invocar todos los usuarios.
List<Usuario> toUserList(QuerySnapshot query) {
  return query.documents.map((doc) => Usuario.fromSnapshot(doc)).toList();
}




/*   Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "empresa1": empresa1,
        "empresa2": empresa2,
        "empresa3": empresa3,
        "empresa4": empresa4,
        "empresa5": empresa5,
        "empresa6": empresa6,
        "empresa7": empresa7,
        "empresa8": empresa8,
        "empresa9": empresa9,
        "empresa10": empresa10,
      };
 

 */