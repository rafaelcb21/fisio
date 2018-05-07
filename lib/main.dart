import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'formulario.dart';
import 'dbsqlite.dart';
//import "package:http/http.dart" as http;
//import 'dart:convert' show json;

GoogleSignIn googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'https://www.googleapis.com/auth/gmail.send'
  ],
);

Future<Null> handleSignOut() async {
  googleSignIn.signOut();
}

void main() {
  runApp(new FisioApp());
} 

class FisioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPage(),
      routes: <String, WidgetBuilder> {
        '/formulario': (BuildContext context) => new FormPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  DatabaseClient db = new DatabaseClient();
  BancoDados bancoDadosDB = new BancoDados();
  String testeEmail = '';
  String testeAccount = '';

  @override
  void initState() {
    super.initState();
    db.create().then((data) {
      try {
        googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {        
          account.authHeaders.then((result) {
            setState(() {
              //this.testeEmail = account.email;
              var header = {'Authorization': result['Authorization'], 'X-Goog-AuthUser': result['X-Goog-AuthUser']}; 
              if (account != null) {
                //this.testeAccount = 'true';
                Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(
                    settings: const RouteSettings(name: '/formulario'),
                    builder: (context) => new FormPage(email: account.email, header: header)
                  )
                );
              }
            });
          }).catchError((error) {
            setState(() {
              this.testeEmail = error.toString();
            });
          });
        });
      } catch (error) {
        setState(() {
          this.testeEmail = error.toString();
        });
      }
      googleSignIn.signInSilently();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage('assets/google-g-logo.png');
    var image = new Image(image: assetImage, width: 96.0, height: 96.0);

    var loginPage = new Scaffold(
      backgroundColor: Colors.pink[400],
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Material(
              color: Colors.white,
              type: MaterialType.circle,
              elevation: 6.0,
              child: new GestureDetector(
                child: new Container(
                  width: 112.0,
                  height: 112.0,
                  child: new InkWell(
                    onTap: () async {
                      try {
                        await googleSignIn.signIn().then((account) {
                          account.authHeaders.then((result) {
                            setState(() {
                              this.testeEmail = account.email;
                              //print([result['Authorization'], result['X-Goog-AuthUser']]);
                              var header = {'Authorization': result['Authorization'], 'X-Goog-AuthUser': result['X-Goog-AuthUser']}; 
                              //print(account);
                              if (account != null) {
                                this.testeAccount = 'true';
                                Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                    settings: const RouteSettings(name: '/formulario'),
                                    builder: (context) => new FormPage(email: account.email, header: header)
                                  )
                                );
                              }
                            });
                          }).catchError((error) {
                            setState(() {
                              this.testeEmail = error.toString();
                            });
                          });
                        });
                          //Navigator.pushNamedAndRemoveUntil(context, '/formulario', (_) => false);
                      } catch (error) {
                        setState(() {
                          this.testeEmail = error.toString();
                        });
                      }
                    },
                    child: new Center(
                      child: image
                    ),
                  )
                ),
              )
            ),

            new Container(
              margin: new EdgeInsets.only(top: 16.0),
              child: new Text(
                'Entre com o Google',
                style: new TextStyle(
                  color: Colors.white,
                  fontFamily: "Futura",
                  fontSize: 18.0
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.only(top: 16.0),
              child: new Text(
                this.testeEmail,
                style: new TextStyle(
                  color: Colors.white,
                  fontFamily: "Futura",
                  fontSize: 18.0
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.only(top: 16.0),
              child: new Text(
                this.testeAccount,
                style: new TextStyle(
                  color: Colors.white,
                  fontFamily: "Futura",
                  fontSize: 18.0
                ),
              ),
            ),
          ],
        )
      )
    );

    return loginPage;
  }
}

