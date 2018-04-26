import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'formulario.dart';
import 'dbsqlite.dart';


GoogleSignIn googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<Null> handleSignOut() async {
    googleSignIn.disconnect();
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
      bancoDadosDB.getLogin().then((data) {
        if(data == true) {
          Navigator.pushReplacementNamed(context, '/formulario');
        }
      });
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
                        await googleSignIn.signIn().then((data) {
                          print(data);
                          bancoDadosDB.insertLogin(data.displayName, data.email);
                          Navigator.pushReplacementNamed(context, '/formulario');
                          //Navigator.pushNamedAndRemoveUntil(context, '/formulario', (_) => false);
                        });
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