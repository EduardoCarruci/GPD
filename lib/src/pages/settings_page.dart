import 'package:flutter/material.dart';
import 'package:gpd2/src/libs/preferencias_usuario/preferencias_usuario.dart';
import 'package:gpd2/src/widgets/menu_widget.dart';




class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario;
  bool _colorRojo;

  TextEditingController _textController;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    
    _colorSecundario = prefs.colorSecundario;
    _colorRojo = prefs.colorSecundario;
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Ajustes',style: TextStyle( color: Colors.black54 )),
        backgroundColor: (prefs.colorSecundario) ? Colors.blue : Colors.transparent,
      
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[

          Container(
            padding: EdgeInsets.all(5.0),
           // child: Text('settings', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold )),
          ),

          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text('Color: Blanco'),
            onChanged: ( value ){
              setState(() {
                _colorSecundario = value;
                prefs.colorSecundario = value;
              });
            },
          ),

          // Divider(),
          // SwitchListTile(
          //   value: _colorSecundario,
          //   title: Text('Color secundario'),
          //   onChanged: ( value ){
          //     setState(() {
          //       _colorSecundario = value;
          //       prefs.colorSecundario = value;
          //     });
          //   },
          // ),


         
          Divider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el teléfono',
              ),
              onChanged: ( value ) {
               
              },
            ),
          )



        ],
      )
    );
  }
}