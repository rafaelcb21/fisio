import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dbsqlite.dart';
import 'dart:async';
import 'package:intl/intl.dart';

enum DialogOptionsAction {
  cancel,
  ok
}

class PacientesPage extends StatefulWidget {
  PacientesPage({Key key, this.email, this.header}) : super(key: key);
  String email;
  Map header;
  @override
  PacientesPageState createState() => new PacientesPageState();
}

class PacientesPageState extends State<PacientesPage> {
  String email;
  Map header;
  BancoDados bancoDadosDB = new BancoDados();

  Paciente pacienteDB = new Paciente();
  List<Widget> listaPacientes = [];
  List listaDB = [];


  @override
  void initState() {
    this.email = widget.email;
    this.header = widget.header;

    bancoDadosDB.getTodosPacientes().then(
      (list) {
        setState(() {
          this.listaDB = list;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> buildListaPacientes(list) {
      this.listaPacientes = [];
      for(var i in list) {
        var id = i['id'];
        var nome = i['nome'];
        var data = i['data'];
         DateTime x = DateTime.parse(data);
        String dataFormatada = new DateFormat.yMd().format(x);
        
        this.listaPacientes.add(
          new Paciente(
            id: id,
            nome: nome,
            data: dataFormatada,
            onPressed: () {

            },
            onPressedDelete: () async {
              void showDeleteDialog<T>({ BuildContext context, Widget child }) {
                showDialog<T>(
                  context: context,
                  child: child,
                )
                .then<Null>((T value) { });
              }

              showDeleteDialog<DialogOptionsAction>(
                context: context,
                child: new AlertDialog(
                  title: const Text('Excluir formulario'),
                  content: new Text(
                    "Deseja excluir esse\nformulário?",                    
                    softWrap: true,
                    style: new TextStyle(
                      color: Colors.black45,
                      fontSize: 16.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    )
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: const Text('CANCEL'),
                      onPressed: () {                                
                        Navigator.pop(context);
                      }
                    ),
                    new FlatButton(
                      child: const Text('OK'),
                      onPressed: () {
                        bancoDadosDB.deletePaciente(id).then((retorno) {
                        bancoDadosDB.getTodosPacientes().then((list) {
                          setState(() {
                            this.listaDB = list;
                          });
                        });
                      });
                      Navigator.pop(context);
                      }
                    )
                  ]
                )
              );
            },
          )
        );
      }
      return this.listaPacientes;
    }

    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.person_add),
            onPressed: () async {
              await Navigator.of(context).push(new PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) {
                  return ;
                },
                transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                ) {
                  return new SlideTransition(
                    position: new Tween<Offset>(
                      begin:  const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                }
              ));
            },
          ),
        ],
        title: new Text('Fisioterapia'),
        backgroundColor: Colors.pink[400],
      ),
      body: new ListView(
        padding: new EdgeInsets.only(top: 8.0, right: 0.0, left: 0.0),
        children: buildListaPacientes(this.listaDB)
      )
    );
  }
}

class Paciente extends StatefulWidget {
   
  final int id;
  final String nome;
  final String data;
  final VoidCallback onPressed;
  final VoidCallback onPressedDelete;

  Paciente({
    this.id,
    this.nome,
    this.data,
    this.onPressed,
    this.onPressedDelete
  });

  @override
  PacienteState createState() => new PacienteState();
}

class PacienteState extends State<Paciente> {
  PacienteState();

  @override
  void initState() {
    
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: new Color(0xFFFAFAFA),
        border: new Border(
          bottom: new BorderSide(
            style: BorderStyle.solid,
            color: Colors.black26,
          )
        )
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            child: new InkWell(
              onTap: widget.onPressed,
              child: new Row(
                children: <Widget>[                  
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        widget.nome,                        
                        style: new TextStyle(
                          color: Colors.black87,
                          fontFamily: "Roboto",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          textBaseline: TextBaseline.alphabetic                        
                        ),
                      ),
                      new Text(
                        widget.data,                        
                        style: new TextStyle(
                          color: Colors.black54,
                          fontFamily: "Roboto",
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          textBaseline: TextBaseline.alphabetic
                        ),
                      ),
                    ],
                  ),
                  new IconButton(
                    icon:  new Icon(Icons.delete_forever, color : Colors.red),
                    onPressed: widget.onPressedDelete,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ); 
  }  
}
