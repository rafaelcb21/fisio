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

  @override
  void initState() {
    super.initState();
    db.create().then((data) {
      googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
        setState(() {
          account.authHeaders.then((result) {
            print(account.email);
            print([result['Authorization'], result['X-Goog-AuthUser']]);
            //var header = {'Authorization': result['Authorization'], 'X-Goog-AuthUser': result['X-Goog-AuthUser']}; 
            print(account);
            if (account != null) {
              bancoDadosDB.insertLogin(account.displayName, account.email, result['Authorization'], result['X-Goog-AuthUser']);
              Navigator.pushReplacementNamed(context, '/formulario');
            }
          });
        });
      }
    );
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
                            bancoDadosDB.insertLogin(account.displayName, account.email, result['Authorization'], result['X-Goog-AuthUser']);
                            Navigator.pushReplacementNamed(context, '/formulario');
                          });                          
                        });
                          //Navigator.pushNamedAndRemoveUntil(context, '/formulario', (_) => false);
                      } catch (error) {
                        print(error);
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
          ],
        )
      )
    );

    return loginPage;
  }
}

