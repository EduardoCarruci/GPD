import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpd2/src/libs/preferencias_usuario/preferencias_usuario.dart';
import 'package:gpd2/src/utils/responsive.dart';
import 'package:gpd2/src/widgets/home_prin.dart';
import 'package:gpd2/src/widgets/login_form.dart';
import 'package:gpd2/src/widgets/menu_widget.dart';
import 'package:gpd2/src/widgets/pagina2.dart';
import 'package:gpd2/src/widgets/pagina3.dart';
import 'package:gpd2/src/widgets/pagina_principal.dart';
import 'package:gpd2/src/widgets/welcome.dart';

//para el usuario
class LoginFormType{
  static final int login = 0;
  static final int register = 1;
  static final int forgotPassword = 2;
}

class HomePrin extends StatefulWidget {
  
  static final routeName = 'home1';
  HomePrin({Key key}) : super(key: key);

  @override
  _HomePrinState createState() => _HomePrinState();
}

class _HomePrinState extends State<HomePrin> with AfterLayoutMixin {
  PageController _pageController = PageController(initialPage: LoginFormType.login);
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    if (!isTablet) {
      // smartphone
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _switchForm(int page){
    _pageController.animateToPage(
      page, 
      duration: Duration(milliseconds:300), 
      curve: Curves.linear
      );
  }
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
       appBar: AppBar(
        title: Text('Guia Profecional Doninicana',style: TextStyle( color: Colors.black54 )),
        backgroundColor: (prefs.colorSecundario) ? Colors.white70 : Colors.blue,
       ),
      drawer: MenuWidget(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(

          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: OrientationBuilder(
            builder: (_, Orientation orientation) {
              if (orientation == Orientation.portrait) {
                return SingleChildScrollView(
                  child: Container(
                    height: responsive.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        PaginaPrin(), 
                        Expanded(
                          child: PageView(
                            // controller: _pageController,
                            // physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              Pagina1(),
                              Pagina2(),
                              Pagina3(),
                            ],
                            
                          ))
                        ],
                    ),
                  ),
                );
              } else {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          height: responsive.height,
                          child: Center(
                            child: Welcome(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: responsive.height,
                          child: Center(
                            child: Loginform(
                              onGoToResgister: (){
                              _switchForm(LoginFormType.register);
                            },
                            onGoToForgotPassword: (){
                               _switchForm(LoginFormType.forgotPassword);
                             },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
