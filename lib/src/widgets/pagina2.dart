import 'package:flutter/material.dart';
import 'package:gpd2/src/libs/preferencias_usuario/preferencias_usuario.dart';



class Pagina2 extends StatelessWidget {

  //const Pagina1();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           
      
      body: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            
                Text('UNA SOLUSION A CADA ', 
                style: TextStyle(fontWeight:FontWeight.bold, fontSize: 20)
                ),
                Text('PROBLEMA', 
                style: TextStyle(fontWeight:FontWeight.bold, fontSize: 20)
                ),
                Text('      Nesecitas un Electricista, plomero, Carpintero '),
                Text('o algun otro tipo de servicio !Busca Aqui.....'),
                Image.asset('assets/img/caja.png'),

            ],
          ),
      
    );
  }
}