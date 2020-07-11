import 'package:flutter/material.dart';
import 'package:gpd2/src/libs/preferencias_usuario/preferencias_usuario.dart';


class Pagina1 extends StatefulWidget {

  //const Pagina1();
  @override
  _Pagina1State createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           
      body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _ceparar(),
              _crearTexto(),
              _search(),
              _crearBoxtton(),
              SizedBox(height:15),
              _contenido(),
              SizedBox(height:10),
              _crearBoxtton1(),
              
            ],
          ),
      ),
    );
  }


Widget _crearTexto(){
  return SafeArea(
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Text(
        'Busca tu profesional, tectico o colaborador',
        textAlign: TextAlign.justify,
        
        ),
    ),
  );
}

Widget _search(){
  return Container(  
    padding: EdgeInsets.all(25.0),
    child:  Card(
       elevation: 5.0, //para que se vea mas elevada
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               Text('  '),
              GestureDetector(
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  ),
                  
                  onTap: (){},
              ),
             
              SizedBox(width:10.0),
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    border: InputBorder.none,hintText:'search....'
                  ),
                  onSubmitted: (String place){},
                ),
                ),
            ],
          ),
    ),
        
  );
}

Widget _crearBoxtton(){
  return Container(
    color: Colors.white10,
    child: Center(
      child: RaisedButton(
        shape: StadiumBorder(),
        color: Colors.blue,
        textColor: Colors.white,
        
        child: Padding(
          
          padding: EdgeInsets.symmetric(horizontal:60.0, vertical: 10.0),
          child: Text('Buscar',style: TextStyle(fontSize:20.0)),
          ),
        onPressed:(){},
      ),
    ),
  );
}

Widget _ceparar(){
  return SafeArea(
      child: Container(
        color: Colors.white10,
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Text('',
        textAlign: TextAlign.justify,       
        ),
      
    ),
  );
}

Widget _contenido(){
  return SafeArea(
      child: Container(
        padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Busqueda previas:                                                '),
          SizedBox(height: 20.0),
          Text('Tutor                         19/05/2020'),
          SizedBox(height: 10.0),
          Text('Electricista              04/02/2020'),
          SizedBox(height: 10.0),
          Text('Programador          03/01/2020'),
        ],
      ),
    ),
  );
}

Widget _crearBoxtton1(){
  return Container(
    color: Colors.white10,
    child: Center(
      child: RaisedButton(
        shape: StadiumBorder(),
        color: Colors.blue,
        textColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:10.0, vertical: 1.0),
          child: Text('Politica de uso',style: TextStyle(fontSize:13.0)),
          ),
        onPressed:(){},
      ),
    ),
  );
}
}
