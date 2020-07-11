import 'package:flutter/material.dart';
import 'package:gpd2/src/libs/preferencias_usuario/preferencias_usuario.dart';


class Pagina3 extends StatelessWidget {

  //const Pagina1();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
      // drawer: MenuWidget(),
      
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text('ENCUENTRA COLABORADORES', 
                style: TextStyle(fontWeight:FontWeight.bold, fontSize: 22)
                ),
                Text('QUE  SUMEN  A TU PROYECTOS', 
                style: TextStyle(fontWeight:FontWeight.bold, fontSize: 22)
                ),
               
                SizedBox(height: 10),
                Text('Un catalago de proposiones de la mas alta calidad'),

                Image.asset('assets/img/busine.png'),

            ],
          ),
      
    );
  }
}