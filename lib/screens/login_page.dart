import 'package:ecommerce_arabic/provider/adminMode.dart';
import 'package:ecommerce_arabic/screens/admin_home_page.dart';
import 'package:ecommerce_arabic/screens/home_page.dart';
import 'package:ecommerce_arabic/screens/signup_page.dart';
import 'package:ecommerce_arabic/services/auth.dart';
import 'package:ecommerce_arabic/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_arabic/constants.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ecommerce_arabic/provider/modelhud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final Auth _auth = Auth();

  bool _keepMeLogged = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: kmainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: Image(
                          image: AssetImage('images/buy.png'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Buy it',
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                CustomTextField(
                    onClick: (value) {
                      _email = value;
                    },
                    hint: 'Enter your email',
                    icon: Icons.email),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                            activeColor: kmainColor,
                            checkColor: ksecondaryColor,
                            value: _keepMeLogged,
                            onChanged: (value) {
                              setState(() {
                                _keepMeLogged = value;
                              });
                            }),
                      ),
                      Text(
                        'REMBER ME!',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                CustomTextField(
                    onClick: (value) {
                      _password = value;
                    },
                    hint: 'Enter your password',
                    icon: Icons.lock),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.18),
                  child: Builder(
                    builder: (context) => FlatButton(
                      onPressed: () {
                        if (_keepMeLogged == true) {
                          keepUserLogged();
                        }
                        _validate_login(context);
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account ',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignupScreen.id);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeAdminMode(true);
                          print('Clicked');
                        },
                        child: Text(
                          'I\'m an admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdminMode
                                  ? kmainColor
                                  : Colors.white),
                        ),
                      )),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeAdminMode(false);
                          print('Clicked');
                        },
                        child: Text(
                          'I\'m a user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdminMode
                                  ? Colors.white
                                  : kmainColor),
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _validate_login(BuildContext context) async {
    final mhud = Provider.of<ModelHud>(context, listen: false);
    mhud.ChangeisLoading(true);

    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdminMode) {
        if (_password == 'P@ssw0rd@123' && _email == 'admin') {
          try {
            bool res = await _auth.sign2(_email, _password);
            mhud.ChangeisLoading(false);
            Navigator.pushNamed(context, AdminHomeScreen.id);
          } catch (e) {
            mhud.ChangeisLoading(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
          mhud.ChangeisLoading(false);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Something went Wrong')));
        }
      } else {
        try {
          print('Option 2');
          bool res = await _auth.sign2(_email, _password);
          // var res = true;
          if (res) {
            print('Login 2');
            mhud.ChangeisLoading(false);
            Navigator.pushNamed(context, HomeScreen.id);
          } else {
            mhud.ChangeisLoading(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Something went Wrong')));
          }
        } catch (e) {
          mhud.ChangeisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
    mhud.ChangeisLoading(false);
  }

  void keepUserLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("User_Name", _email);
    prefs.setString("Password", _password);
    prefs.setBool(kKeepMeLoggedIn, _keepMeLogged);
  }
}
