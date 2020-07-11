import 'package:shared_preferences/shared_preferences.dart';


class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }
  

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

  get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? true;
  }

  set colorSecundario( bool value ) {
    _prefs.setBool('colorSecundario', value);
  }

  get colorSecundario1 {
    return _prefs.getBool('colorSecundario1') ?? true;
  }

  set colorSecundario1( bool value ) {
    _prefs.setBool('colorSecundario1', value);

}


}