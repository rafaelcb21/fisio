import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dbsqlite.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
  var uuid = new Uuid();

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
        String dataFormatada = new DateFormat("dd-MM-yyyy").format(DateTime.parse(data));
        
        this.listaPacientes.add(
          new Paciente(
            key: new ObjectKey(id),
            id: id,
            nome: nome,
            data: dataFormatada,
            onPressed: () {
              Navigator.pop(context, [3, id]);
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
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context, [1]);
          },
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.person_add),
            onPressed: () {
              Navigator.pop(context, [2]);
            },
          ),
        ],
        title: new Text('Fisioterapia'),
        backgroundColor: Colors.pink[400],
      ),
      body: new ListView(
        key: new Key(uuid.v4()),
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
    Key key,
    this.id,
    this.nome,
    this.data,
    this.onPressed,
    this.onPressedDelete
  }) : super(key: key);

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
      padding: new EdgeInsets.only(left: 16.0),
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
        children: <Widget>[
          new Expanded(
            child: new InkWell(
              onTap: widget.onPressed,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[                  
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        widget.nome,                        
                        style: new TextStyle(
                          color: Colors.black87,
                          fontFamily: "Roboto",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          textBaseline: TextBaseline.alphabetic                        
                        ),
                      ),
                      new Text(
                        widget.data,                        
                        style: new TextStyle(
                          color: Colors.black54,
                          fontFamily: "Roboto",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          textBaseline: TextBaseline.alphabetic
                        ),
                      ),
                    ],
                  ),
                  new IconButton(
                    icon:  new Icon(
                      Icons.delete_forever,
                      color : Colors.red,
                      size: 28.0,
                    ),
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
