import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dbsqlite.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Page {
  const Page({ this.icon, this.widget });
  final IconData icon;
  final Widget widget;
} 

class FormPage extends StatefulWidget {
  FormPage({Key key, this.email, this.header}) : super(key: key);
  String email;
  Map header;
  
  @override
  FormPageState createState() => new FormPageState();
}

class FormPageState extends State<FormPage>  with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  BancoDados bancoDadosDB = new BancoDados();
  TabController _controller;
  FocusNode _focusNodeNome = new FocusNode();
  FocusNode _focusNodeIdade = new FocusNode();
  FocusNode _focusNodePeso = new FocusNode();
  FocusNode _focusNodeAltura = new FocusNode();
  FocusNode _focusNodePimax = new FocusNode();
  FocusNode _focusNodePemax = new FocusNode();

  FocusNode _focusNodeFCRepouso = new FocusNode();
  FocusNode _focusNodeFRRepouso = new FocusNode();
  FocusNode _focusNodeSpO2Repouso = new FocusNode();
  FocusNode _focusNodePARepouso = new FocusNode();
  FocusNode _focusNodeBorgDRepouso = new FocusNode();
  FocusNode _focusNodeBorgMMIIRepouso = new FocusNode();
  FocusNode _focusNodeOxigenioRepouso = new FocusNode();

  FocusNode _focusNodeFC3min = new FocusNode();
  FocusNode _focusNodeSpO23min = new FocusNode();
  FocusNode _focusNodeOxigenio3min = new FocusNode();

  FocusNode _focusNodeFC6min = new FocusNode();
  FocusNode _focusNodeFR6min = new FocusNode();
  FocusNode _focusNodeSpO26min = new FocusNode();
  FocusNode _focusNodePA6min = new FocusNode();
  FocusNode _focusNodeBorgD6min = new FocusNode();
  FocusNode _focusNodeBorgMMII6min = new FocusNode();
  FocusNode _focusNodeOxigenio6min = new FocusNode();

  FocusNode _focusNodeFCRepouso2min = new FocusNode();
  FocusNode _focusNodeFRRepouso2min = new FocusNode();
  FocusNode _focusNodeSpO2Repouso2min = new FocusNode();
  FocusNode _focusNodePARepouso2min = new FocusNode();
  FocusNode _focusNodeBorgDRepouso2min = new FocusNode();
  FocusNode _focusNodeBorgMMIIRepouso2min = new FocusNode();
  FocusNode _focusNodeOxigenioRepouso2min = new FocusNode();

  TextEditingController _controllerNome = new TextEditingController();
  TextEditingController _controllerIdade = new TextEditingController();
  TextEditingController _controllerPeso = new TextEditingController();
  TextEditingController _controllerAltura = new TextEditingController();
  TextEditingController _controllerPimax = new TextEditingController();
  TextEditingController _controllerPemax = new TextEditingController();

  TextEditingController _controllerFCRepouso = new TextEditingController();
  TextEditingController _controllerFRRepouso = new TextEditingController();
  TextEditingController _controllerSpO2Repouso = new TextEditingController();
  TextEditingController _controllerPARepouso = new TextEditingController();
  TextEditingController _controllerBorgDRepouso = new TextEditingController();
  TextEditingController _controllerBorgMMIIRepouso = new TextEditingController();
  TextEditingController _controllerOxigenioRepouso = new TextEditingController();

  TextEditingController _controllerFC3min = new TextEditingController();
  TextEditingController _controllerSpO23min = new TextEditingController();
  TextEditingController _controllerOxigenio3min = new TextEditingController();

  TextEditingController _controllerFC6min = new TextEditingController();
  TextEditingController _controllerFR6min = new TextEditingController();
  TextEditingController _controllerSpO26min = new TextEditingController();
  TextEditingController _controllerPA6min = new TextEditingController();
  TextEditingController _controllerBorgD6min = new TextEditingController();
  TextEditingController _controllerBorgMMII6min = new TextEditingController();
  TextEditingController _controllerOxigenio6min = new TextEditingController();

  TextEditingController _controllerFCRepouso2min = new TextEditingController();
  TextEditingController _controllerFRRepouso2min = new TextEditingController();
  TextEditingController _controllerSpO2Repouso2min = new TextEditingController();
  TextEditingController _controllerPARepouso2min = new TextEditingController();
  TextEditingController _controllerBorgDRepouso2min = new TextEditingController();
  TextEditingController _controllerBorgMMIIRepouso2min = new TextEditingController();
  TextEditingController _controllerOxigenioRepouso2min = new TextEditingController();

  String vo2PicoString = '';
  String estimativaDistanciaTC6MString = '';

  String value = "Homem";
  String _valueTextNormalPimax = '';
  String _valueTextNormalPemax = '';
  bool _customIndicator = false;

  int numeroDistancia = 0;
  String email;
  Map header;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 4);
    this.email = widget.email;
    this.header = widget.header;
    //bancoDadosDB.getLogin().then((resp) {
    //  this.email = resp[0];
    //  this.header = resp[1];
    //});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  vo2Pico(int distancia) {
    this.vo2PicoString = ((0.03 * distancia) + 3.98).toStringAsFixed(2).toString().replaceAll('.', ',');  
  }

  Future<Null> sendEmail(String userId, Map<String, String> cabecalho) async {
    cabecalho['Accept'] = 'application/json';
    cabecalho['Content-type'] = 'application/json';

    var from = userId;
    var to = userId;
    var subject = 'test send email';
    var message = 'Hi2 Html Email2';
    var content =
      '''
Content-Type: text/html; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
to: ${to}
from: ${from}
subject: ${subject}

${message}''';

    var bytes = utf8.encode(content);
    var base64 = base64Encode(bytes);
    var body = json.encode({'raw': base64});
    print(body);
    String url = 'https://www.googleapis.com/gmail/v1/users/' + userId + '/messages/send';
    
    final http.Response response = await http.post(url, headers: cabecalho, body: body);
    if (response.statusCode != 200) {
      setState(() {
        print('error: ' + response.statusCode.toString());
        print(url);
        print(json.decode(response.body));
      });
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    print('ok: ' + response.statusCode.toString());
    print(data);
  }

  estimativaDistanciaTC6M() {

    if(_controllerAltura.text.length == 0) {
      _controllerAltura.text = '0.0';
    }
    if(_controllerPeso.text.length == 0) {
      _controllerPeso.text = '0.0';
    }
    if(_controllerIdade.text.length == 0) {
      _controllerIdade.text = '0.0';
    }
    if(this.value == 'Homem') {
      var numero = 
        (7.57 * double.parse(_controllerAltura.text.replaceAll(',', '.'))) -
        (1.76 * double.parse(_controllerPeso.text.replaceAll(',', '.'))) -
        (5.02 * double.parse(_controllerIdade.text.replaceAll(',', '.'))) - 309;
      this.estimativaDistanciaTC6MString = numero.toStringAsFixed(2).toString().replaceAll('.', ',');
      
    } else {
      var numero = 
        (2.11 * double.parse(_controllerAltura.text.replaceAll(',', '.'))) -
        (2.29 * double.parse(_controllerPeso.text.replaceAll(',', '.'))) -
        (5.78 * double.parse(_controllerIdade.text.replaceAll(',', '.'))) - 667;
      this.estimativaDistanciaTC6MString = numero.toStringAsFixed(2).toString().replaceAll('.', ',');
      
    }     
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    const Color _kKeyUmbraOpacity = const Color(0x33000000); // alpha = 0.2
    const Color _kKeyPenumbraOpacity = const Color(0x24000000); // alpha = 0.14
    const Color _kAmbientShadowOpacity = const Color(0x1F000000);
    var assetImage = new AssetImage('assets/google-g-logo.png');
    var image = new Image(image: assetImage, width: 96.0, height: 96.0);

    List<Page> allPages = <Page>[
      new Page(
        icon: Icons.filter_1,
        widget: new ListView(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  new EnsureVisibleWhenFocused(
                    focusNode: _focusNodeNome,            
                    child: new TextField(
                      keyboardType: TextInputType.text,
                      controller: _controllerNome,
                      maxLines: 1,
                      focusNode: _focusNodeNome,
                      style: Theme.of(context).textTheme.title,
                      decoration: new InputDecoration(
                        labelText: "Nome",
                        isDense: true,
                      ),
                    ),
                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        groupValue: value,
                        onChanged: (value) => setState(() => this.value = value),
                        value: "Homem",
                      ),
                      const Text("Homem"),
                      new Radio(
                        groupValue: value,
                        onChanged: (value) => setState(() => this.value = value),
                        value: "Mulher",
                      ),
                      const Text("Mulher"),
                    ],
                  ),

                  new Container(
                    child: new EnsureVisibleWhenFocused(
                      focusNode: _focusNodeIdade,            
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        controller: _controllerIdade,
                        maxLines: 1,
                        focusNode: _focusNodeIdade,
                        style: Theme.of(context).textTheme.title,
                        decoration: new InputDecoration(
                          labelText: "Idade",
                          isDense: true,
                        ),
                      ),
                    )
                  ),

                  new Container(
                    child: new EnsureVisibleWhenFocused(
                      focusNode: _focusNodePeso,            
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        controller: _controllerPeso,
                        maxLines: 1,
                        focusNode: _focusNodePeso,
                        style: Theme.of(context).textTheme.title,
                        decoration: new InputDecoration(
                          labelText: "Peso (Kg)",
                          isDense: true,
                        ),
                      ),
                    )
                  ),

                  new Container(
                    child: new EnsureVisibleWhenFocused(
                      focusNode: _focusNodeAltura,            
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        controller: _controllerAltura,
                        maxLines: 1,
                        focusNode: _focusNodeAltura,
                        style: Theme.of(context).textTheme.title,
                        decoration: new InputDecoration(
                          labelText: "Altura (cm)",
                          isDense: true,
                        ),
                      ),
                    ),
                  ),

                  new Container(margin: new EdgeInsets.all(8.0))
                ]
              )
            ),
          ]
        )
      ),
      new Page(
        icon: Icons.filter_2,
        widget: new ListView(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    'Avaliação Muscular Respiratória',
                    style: new TextStyle(
                      color: Colors.pink[300],
                      fontFamily: "Futura",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700
                    ),
                  ),

                  new EnsureVisibleWhenFocused(
                    focusNode: _focusNodePimax,
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      controller: _controllerPimax,
                      maxLines: 1,
                      focusNode: _focusNodePimax,
                      style: Theme.of(context).textTheme.title,
                      decoration: new InputDecoration(
                        labelText: "Pimáx",
                        isDense: true,
                      ),
                    ),
                  ),

                  new EnsureVisibleWhenFocused(
                    focusNode: _focusNodePemax,
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      controller: _controllerPemax,
                      maxLines: 1,
                      focusNode: _focusNodePemax,
                      style: Theme.of(context).textTheme.title,
                      decoration: new InputDecoration(
                        labelText: "Pemáx",
                        isDense: true,
                      ),
                    ),
                  ),

                  new Container(margin: new EdgeInsets.all(8.0)),
                  
                  new Text(
                    'Valor de normalidade',
                    style: new TextStyle(
                      color: Colors.pink[300],
                      fontFamily: "Futura",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400
                    ),
                  ),

                  new InputDropdown(
                    labelText: 'Pimáx normal',
                    valueText: _valueTextNormalPimax,
                    valueStyle: valueStyle,
                    onPressed: () {},
                  ),

                  new InputDropdown(
                    labelText: 'Pemáx normal',
                    valueText: _valueTextNormalPemax,
                    valueStyle: valueStyle,
                    onPressed: () {},
                  ),

                  new Container(margin: new EdgeInsets.all(8.0)),
                  new InkWell(
                    onTap: () {
                      setState(() {
                        if(this.value == 'Homem') {
                          double pimaxCalc = -0.8 * int.parse(_controllerIdade.text) + 155.3;                        
                          double pemaxCalc = -0.81 * int.parse(_controllerIdade.text) + 165.3;
                          _valueTextNormalPimax = pimaxCalc.toStringAsFixed(2).toString().replaceAll('.', ',');
                          _valueTextNormalPemax = pemaxCalc.toStringAsFixed(2).toString().replaceAll('.', ',');
                        } else {
                          double pimaxCalc = -0.49 * int.parse(_controllerIdade.text) + 110.4;
                          double pemaxCalc = -0.61 * int.parse(_controllerIdade.text) + 115.6;
                          _valueTextNormalPimax = pimaxCalc.toStringAsFixed(2).toString().replaceAll('.', ',');
                          _valueTextNormalPemax = pemaxCalc.toStringAsFixed(2).toString().replaceAll('.', ',');
                        }
                      });                  
                    },
                    child: new Container(
                      margin: new EdgeInsets.only(top:4.0, bottom: 4.0, left: 8.0, right: 8.0),
                      decoration: new BoxDecoration(
                        color: Colors.pink[400],
                        borderRadius: new BorderRadius.all(const Radius.circular(3.0)),
                        boxShadow: [
                          const BoxShadow(offset: const Offset(0.0, 2.0), blurRadius: 4.0, spreadRadius: -1.0, color: _kKeyUmbraOpacity),
                          const BoxShadow(offset: const Offset(0.0, 4.0), blurRadius: 5.0, spreadRadius: 0.0, color: _kKeyPenumbraOpacity),
                          const BoxShadow(offset: const Offset(0.0, 1.0), blurRadius: 10.0, spreadRadius: 0.0, color: _kAmbientShadowOpacity),
                        ]
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            padding: new EdgeInsets.only(top: 12.0, bottom: 12.0),
                            child: new Text(
                              'Calcular',
                              style: new TextStyle(
                                color: Colors.white,
                                fontFamily: "Futura",
                                fontSize: 14.0
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]
              )
            ),
          ]
        )
      ),
      new Page(
        icon: Icons.filter_3,
        widget: new Stack(
          children: <Widget>[
            new ListView(
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        'Teste de Caminhada 6 min',
                        style: new TextStyle(
                          color: Colors.pink[300],
                          fontFamily: "Futura",
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),

                      new Container(margin: new EdgeInsets.all(8.0)),                  
                      new Text(
                        'Repouso',
                        style: new TextStyle(
                          color: Colors.pink[300],
                          fontFamily: "Futura",
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeFCRepouso,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerFCRepouso,
                            maxLines: 1,
                            focusNode: _focusNodeFCRepouso,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "FC",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeFRRepouso,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerFRRepouso,
                            maxLines: 1,
                            focusNode: _focusNodeFRRepouso,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "FR",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeSpO2Repouso,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerSpO2Repouso,
                            maxLines: 1,
                            focusNode: _focusNodeSpO2Repouso,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "SpO2 (%)",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodePARepouso,            
                          child: new TextField(
                            keyboardType: TextInputType.text,
                            controller: _controllerPARepouso,
                            maxLines: 1,
                            focusNode: _focusNodePARepouso,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "PA",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeBorgDRepouso,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerBorgDRepouso,
                            maxLines: 1,
                            focusNode: _focusNodeBorgDRepouso,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "BORG D",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeBorgMMIIRepouso,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerBorgMMIIRepouso,
                            maxLines: 1,
                            focusNode: _focusNodeBorgMMIIRepouso,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "BORG MMII",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeOxigenioRepouso,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerOxigenioRepouso,
                            maxLines: 1,
                            focusNode: _focusNodeOxigenioRepouso,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "Oxigênio",
                              isDense: true,
                            ),
                          ),
                        )
                      ),

                      new Container(margin: new EdgeInsets.all(18.0)),                  
                      new Text(
                        '3min',
                        style: new TextStyle(
                          color: Colors.pink[300],
                          fontFamily: "Futura",
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeFC3min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerFC3min,
                            maxLines: 1,
                            focusNode: _focusNodeFC3min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "FC",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeSpO23min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerSpO23min,
                            maxLines: 1,
                            focusNode: _focusNodeSpO23min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "SpO2",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeOxigenio3min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerOxigenio3min,
                            maxLines: 1,
                            focusNode: _focusNodeOxigenio3min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "Oxigênio",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(margin: new EdgeInsets.all(18.0)),                  
                      new Text(
                        '6min',
                        style: new TextStyle(
                          color: Colors.pink[300],
                          fontFamily: "Futura",
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeFC6min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerFC6min,
                            maxLines: 1,
                            focusNode: _focusNodeFC6min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "FC",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeFR6min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerFR6min,
                            maxLines: 1,
                            focusNode: _focusNodeFR6min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "FR",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeSpO26min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerSpO26min,
                            maxLines: 1,
                            focusNode: _focusNodeSpO26min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "SpO2",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodePA6min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerPA6min,
                            maxLines: 1,
                            focusNode: _focusNodePA6min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "PA",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeBorgD6min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerBorgD6min,
                            maxLines: 1,
                            focusNode: _focusNodeBorgD6min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "BORG D",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeBorgMMII6min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerBorgMMII6min,
                            maxLines: 1,
                            focusNode: _focusNodeBorgMMII6min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "BORG MMII",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeOxigenio6min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerOxigenio6min,
                            maxLines: 1,
                            focusNode: _focusNodeOxigenio6min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "Oxigênio",
                              isDense: true,
                            ),
                          ),
                        )
                      ),

                      new Container(margin: new EdgeInsets.all(18.0)),                  
                      new Text(
                        'Repouso2min',
                        style: new TextStyle(
                          color: Colors.pink[300],
                          fontFamily: "Futura",
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeFCRepouso2min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerFCRepouso2min,
                            maxLines: 1,
                            focusNode: _focusNodeFCRepouso2min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "FC",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeFRRepouso2min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerFRRepouso2min,
                            maxLines: 1,
                            focusNode: _focusNodeFRRepouso2min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "FR",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeSpO2Repouso2min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerSpO2Repouso2min,
                            maxLines: 1,
                            focusNode: _focusNodeSpO2Repouso2min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "SpO2",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodePARepouso2min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerPARepouso2min,
                            maxLines: 1,
                            focusNode: _focusNodePARepouso2min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "PA",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeBorgDRepouso2min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerBorgDRepouso2min,
                            maxLines: 1,
                            focusNode: _focusNodeBorgDRepouso2min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "BORG D",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeBorgMMIIRepouso2min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerBorgMMIIRepouso2min,
                            maxLines: 1,
                            focusNode: _focusNodeBorgMMIIRepouso2min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "BORG MMII",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodeOxigenioRepouso2min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerOxigenioRepouso2min,
                            maxLines: 1,
                            focusNode: _focusNodeOxigenioRepouso2min,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                              labelText: "Oxigênio",
                              isDense: true,
                            ),
                          ),
                        )
                      ),

                      new Container(margin: new EdgeInsets.all(42.0)),

                    ]
                  )
                )
              ]
            ),

            new Positioned(
              bottom: 16.0,
              left: 16.0,
              child: new Material(
                color: Colors.green[600],
                type: MaterialType.circle,
                elevation: 6.0,
                child: new GestureDetector(
                  child: new Container(
                    width: 56.0,
                    height: 56.00,
                    child: new InkWell(
                      onTap: () {
                        setState(() {
                          this.numeroDistancia = this.numeroDistancia + 30;
                          vo2Pico(this.numeroDistancia);
                          estimativaDistanciaTC6M();
                        });                        
                      },
                      child: new Center(
                        child: new Text(
                          '+30',
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: "Futura",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700
                          )                        
                        )
                      ),
                    )
                  ),
                )
              ),
            ),

            new Positioned(
              bottom: 16.0,
              left: 90.0,
              child: new Material(
                color: Colors.blue[600],
                type: MaterialType.circle,
                elevation: 6.0,
                child: new GestureDetector(
                  child: new Container(
                    width: 56.0,
                    height: 56.00,
                    child: new InkWell(
                      onTap: () {
                        setState(() {
                          this.numeroDistancia = this.numeroDistancia + 10;
                          vo2Pico(this.numeroDistancia);
                          estimativaDistanciaTC6M();
                        });  
                      },
                      child: new Center(
                        child: new Text(
                          '+10',
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: "Futura",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700
                          )                        
                        )
                      ),
                    )
                  ),
                )
              ),
            ),

            new Positioned(
              bottom: 16.0,
              left: 165.0,
              child: new Material(
                color: Colors.red[600],
                type: MaterialType.circle,
                elevation: 6.0,
                child: new GestureDetector(
                  child: new Container(
                    width: 56.0,
                    height: 56.00,
                    child: new InkWell(
                      onTap: () {
                        setState(() {
                          this.numeroDistancia = this.numeroDistancia + 1;
                          vo2Pico(this.numeroDistancia);
                          estimativaDistanciaTC6M();
                        });  
                      },
                      child: new Center(
                        child: new Text(
                          '+1',
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: "Futura",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700
                          )                        
                        )
                      ),
                    )
                  ),
                )
              ),
            ),

            new Positioned(
              bottom: 16.0,
              right: 16.0,
              child: new Material(
                color: Colors.grey[500],
                type: MaterialType.circle,
                elevation: 6.0,
                child: new GestureDetector(
                  child: new Container(
                    width: 56.0,
                    height: 56.00,
                    child: new InkWell(
                      onTap: () {
                        setState(() {
                          this.numeroDistancia = this.numeroDistancia -1;
                          vo2Pico(this.numeroDistancia);
                          estimativaDistanciaTC6M();
                        });  
                      },
                      child: new Center(
                        child: new Text(
                          '-1',
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: "Futura",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700
                          )                        
                        )
                      ),
                    )
                  ),
                )
              ),
            ),

            new Positioned(
              bottom: 90.0,
              right: 16.0,
              child: new Material(
                color: Colors.pink[400],
                type: MaterialType.circle,
                elevation: 6.0,
                child: new GestureDetector(
                  child: new Container(
                    width: 56.0,
                    height: 56.00,
                    child: new InkWell(
                      onTap: () {},
                      child: new Center(
                        child: new Text(
                          this.numeroDistancia.toString(),
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: "Futura",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700
                          )
                        )
                      ),
                    )
                  ),
                )
              ),
            ),

          ]
        )
      ),

      new Page(
        icon: Icons.filter_4,
        widget: new ListView(
          children: <Widget>[
            new InputDropdown(
              labelText: 'Distância Percorrida (m)',
              valueText: this.numeroDistancia.toString(),
              valueStyle: valueStyle,
              onPressed: () {},
            ),
            new InputDropdown(
              labelText: 'Calculo estimativo no TC6min (m)',
              valueText: this.estimativaDistanciaTC6MString,
              valueStyle: valueStyle,
              onPressed: () {},
            ),
            new InputDropdown(
              labelText: 'Estimativa do VO2pico (ml/kg/min) no TC6min',
              valueText: this.vo2PicoString,
              valueStyle: valueStyle,
              onPressed: () {},
            ),
            new Container(margin: new EdgeInsets.all(24.0)),
              new InkWell(
                onTap: () {
                  setState(() {
                    if(_controllerNome.text.length == 0) { _controllerNome.text = ' ';}
                    String nome = _controllerNome.text;

                    if(this.value.length == 0) { this.value = ' ';}
                    String genero = this.value;

                    if(_controllerIdade.text.length == 0) { _controllerIdade.text = '0';}
                    int idade = int.parse(_controllerIdade.text);

                    if(_controllerPeso.text.length == 0) { _controllerPeso.text = '0.0';}
                    double peso = double.parse(_controllerPeso.text);

                    if(_controllerAltura.text.length == 0) { _controllerAltura.text = '0';}
                    int altura = int.parse(_controllerAltura.text);
                    
                    if(_controllerPimax.text.length == 0) { _controllerPimax.text = '0.0';}
                    double pimax = double.parse(_controllerPimax.text);

                    if(_controllerPemax.text.length == 0) { _controllerPemax.text = '0.0';}
                    double pemax = double.parse(_controllerPemax.text);

                    if(_valueTextNormalPimax.length == 0) { _valueTextNormalPimax = '0.0';}
                    double pimaxnormal = double.parse(_valueTextNormalPimax.replaceAll(',', '.'));

                    if(_valueTextNormalPemax.length == 0) { _valueTextNormalPemax = '0.0';}
                    double pemaxnormal = double.parse(_valueTextNormalPemax.replaceAll(',', '.'));
                    
                    if(_controllerFCRepouso.text.length == 0) { _controllerFCRepouso.text = '0';}
                    int repousofc = int.parse(_controllerFCRepouso.text);

                    if(_controllerFRRepouso.text.length == 0) { _controllerFRRepouso.text = '0';}
                    int repousofr = int.parse(_controllerFRRepouso.text);

                    if(_controllerSpO2Repouso.text.length == 0) { _controllerSpO2Repouso.text = '0';}
                    int repousospo = int.parse(_controllerSpO2Repouso.text);

                    if(_controllerPARepouso.text.length == 0) { _controllerPARepouso.text = '0';}
                    String repousopa = _controllerPARepouso.text;

                    if(_controllerBorgDRepouso.text.length == 0) { _controllerBorgDRepouso.text = '0';}
                    int repousobrogd = int.parse(_controllerBorgDRepouso.text);

                    if(_controllerBorgMMIIRepouso.text.length == 0) { _controllerBorgMMIIRepouso.text = '0';}
                    int repousommii = int.parse(_controllerBorgMMIIRepouso.text);

                    if(_controllerOxigenioRepouso.text.length == 0) { _controllerOxigenioRepouso.text = '0';}
                    String repousooxigenio = _controllerOxigenioRepouso.text;

                    if(_controllerFC3min.text.length == 0) { _controllerFC3min.text = '0';}
                    int min3fc = int.parse(_controllerFC3min.text);

                    if(_controllerSpO23min.text.length == 0) { _controllerSpO23min.text = '0';}
                    int min3spo = int.parse(_controllerSpO23min.text);

                    if(_controllerOxigenio3min.text.length == 0) { _controllerOxigenio3min.text = '0';}
                    String min3oxigenio = _controllerOxigenio3min.text;
                    
                    if(_controllerFC6min.text.length == 0) { _controllerFC6min.text = '0';}
                    int min6fc = int.parse(_controllerFC6min.text);

                    if(_controllerFR6min.text.length == 0) { _controllerFR6min.text = '0';}
                    int min6fr = int.parse(_controllerFR6min.text);

                    if(_controllerSpO26min.text.length == 0) { _controllerSpO26min.text = '0';}
                    int min6spo = int.parse(_controllerSpO26min.text);

                    if(_controllerPA6min.text.length == 0) { _controllerPA6min.text = '0';}
                    String min6pa = _controllerPA6min.text;

                    if(_controllerBorgD6min.text.length == 0) { _controllerBorgD6min.text = '0';}
                    int min6brogd = int.parse(_controllerBorgD6min.text);

                    if(_controllerBorgMMII6min.text.length == 0) { _controllerBorgMMII6min.text = '0';}
                    int min6mmii = int.parse(_controllerBorgMMII6min.text);

                    if(_controllerOxigenio6min.text.length == 0) { _controllerOxigenio6min.text = '0';}
                    String min6oxigenio = _controllerOxigenio6min.text;

                    if(_controllerFCRepouso2min.text.length == 0) { _controllerFCRepouso2min.text = '0';}
                    int repouso2fc = int.parse(_controllerFCRepouso2min.text);

                    if(_controllerFRRepouso2min.text.length == 0) { _controllerFRRepouso2min.text = '0';}
                    int repouso2fr = int.parse(_controllerFRRepouso2min.text);

                    if(_controllerSpO2Repouso2min.text.length == 0) { _controllerSpO2Repouso2min.text = '0';}
                    int repouso2spo = int.parse(_controllerSpO2Repouso2min.text);

                    if(_controllerPARepouso2min.text.length == 0) { _controllerPARepouso2min.text = '0';}
                    String repouso2pa = _controllerPARepouso2min.text;

                    if(_controllerBorgDRepouso2min.text.length == 0) { _controllerBorgDRepouso2min.text = '0';}
                    int repouso2brogd = int.parse(_controllerBorgDRepouso2min.text);

                    if(_controllerBorgMMIIRepouso2min.text.length == 0) { _controllerBorgMMIIRepouso2min.text = '0';}
                    int repouso2mmii = int.parse(_controllerBorgMMIIRepouso2min.text);

                    if(_controllerOxigenioRepouso2min.text.length == 0) { _controllerOxigenioRepouso2min.text = '0';}
                    String repouso2oxigenio = _controllerOxigenioRepouso2min.text;

                    int distancia = this.numeroDistancia;

                    if(this.estimativaDistanciaTC6MString.length == 0) { this.estimativaDistanciaTC6MString = '0.0';}
                    double tc6min = double.parse(this.estimativaDistanciaTC6MString.replaceAll(',', '.'));

                    if(this.vo2PicoString.length == 0) { this.vo2PicoString = '0.0';}
                    double vo2pico = double.parse(this.vo2PicoString.replaceAll(',', '.'));

                    Map form = {
                      'nome': nome,
                      'genero': genero,
                      'idade': idade,
                      'peso': peso,
                      'altura': altura,
                      'pimax': pimax,
                      'pemax': pemax,
                      'pimaxnormal': pimaxnormal,
                      'pemaxnormal': pemaxnormal,
                      'repousofc': repousofc,
                      'repousofr': repousofr,
                      'repousospo': repousospo,
                      'repousopa': repousopa,
                      'repousobrogd': repousobrogd,
                      'repousommii': repousommii,
                      'repousooxigenio': repousooxigenio,
                      'min3fc': min3fc,
                      'min3spo': min3spo,
                      'min3oxigenio': min3oxigenio,
                      'min6fc': min6fc,
                      'min6fr': min6fr,
                      'min6spo': min6spo,
                      'min6pa': min6pa,
                      'min6brogd': min6brogd,
                      'min6mmii': min6mmii,
                      'min6oxigenio': min6oxigenio,
                      'repouso2fc': repouso2fc,
                      'repouso2fr': repouso2fr,
                      'repouso2spo': repouso2spo,
                      'repouso2pa': repouso2pa,
                      'repouso2brogd': repouso2brogd,
                      'repouso2mmii': repouso2mmii,
                      'repouso2oxigenio': repouso2oxigenio,
                      'distancia': distancia,
                      'tc6min': tc6min,
                      'vo2pico': vo2pico,
                      'data': new DateFormat("yyyy-MM-dd").format(new DateTime.now())               
                    };

                    bancoDadosDB.insertForm(form).then((data) {
                      if(data) {
                        showInSnackBar('Salvo com sucesso!');

                        sendEmail(this.email, this.header);

                        setState(() {
                          _controllerNome.text = '';
                          this.value = 'Homem';
                          _controllerIdade.text = '';
                          _controllerPeso.text = '';
                          _controllerAltura.text = '';
                          _controllerPimax.text = '';
                          _controllerPemax.text = '';
                          _valueTextNormalPimax = '';
                          _valueTextNormalPemax = '';
                          _controllerFCRepouso.text = '';
                          _controllerFRRepouso.text = '';
                          _controllerSpO2Repouso.text = '';
                          _controllerPARepouso.text = '';
                          _controllerBorgDRepouso.text = '';
                          _controllerBorgMMIIRepouso.text = '';
                          _controllerOxigenioRepouso.text = '';
                          _controllerFC3min.text = '';
                          _controllerSpO23min.text = '';
                          _controllerOxigenio3min.text = '';
                          _controllerFC6min.text = '';
                          _controllerFR6min.text = '';
                          _controllerSpO26min.text = '';
                          _controllerPA6min.text = '';
                          _controllerBorgD6min.text = '';
                          _controllerBorgMMII6min.text = '';
                          _controllerOxigenio6min.text = '';
                          _controllerFCRepouso2min.text = '';
                          _controllerFRRepouso2min.text = '';
                          _controllerSpO2Repouso2min.text = '';
                          _controllerPARepouso2min.text = '';
                          _controllerBorgDRepouso2min.text = '';
                          _controllerBorgMMIIRepouso2min.text = '';
                          _controllerOxigenioRepouso2min.text = '';
                          this.numeroDistancia = 0;
                          this.estimativaDistanciaTC6MString = '';
                          this.vo2PicoString = '';
                        });
                      }
                    });
                  });
                },
                child: new Container(
                  margin: new EdgeInsets.only(top:4.0, bottom: 4.0, left: 8.0, right: 8.0),
                  decoration: new BoxDecoration(
                    color: Colors.pink[400],
                    borderRadius: new BorderRadius.all(const Radius.circular(3.0)),
                    boxShadow: [
                      const BoxShadow(offset: const Offset(0.0, 2.0), blurRadius: 4.0, spreadRadius: -1.0, color: _kKeyUmbraOpacity),
                      const BoxShadow(offset: const Offset(0.0, 4.0), blurRadius: 5.0, spreadRadius: 0.0, color: _kKeyPenumbraOpacity),
                      const BoxShadow(offset: const Offset(0.0, 1.0), blurRadius: 10.0, spreadRadius: 0.0, color: _kAmbientShadowOpacity),
                    ]
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.only(top: 14.0, bottom: 14.0),
                        child: new Text(
                          'Salvar',
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: "Futura",
                            fontSize: 18.0
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        )
      )
    ];
    
    
    Decoration getIndicator() {
      return new ShapeDecoration(
        shape: const RoundedRectangleBorder( //CircleBorder
          side: const BorderSide(
            color: Colors.white24,
            width: 4.0,
          ),
        ) + const RoundedRectangleBorder( //CircleBorder
          side: const BorderSide(
            color: Colors.transparent,
            width: 4.0,
          ),
        ),
      );
    }

    var formApp = new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Fisioterapia'),
        //leading: new Container(),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink[400],
        bottom: new TabBar(
          controller: _controller,
          isScrollable: true,
          indicator: getIndicator(),
          tabs: <Widget>[
            new Container(
              padding: new EdgeInsets.all(8.0),
              child: new Icon(Icons.filter_1, size: 32.0,),
            ),
            new Container(
              padding: new EdgeInsets.all(8.0),
              child: new Icon(Icons.filter_2, size: 32.0,),
            ),
            new Container(
              padding: new EdgeInsets.all(8.0),
              child: new Icon(Icons.filter_3, size: 32.0,),
            ),
            new Container(
              padding: new EdgeInsets.all(8.0),
              child: new Icon(Icons.filter_4, size: 32.0,),
            )
          ]
        )
      ),
      body: new TabBarView(
        controller: _controller,
        children: allPages.map((Page page) {
          return new SafeArea(
            top: false,
            bottom: false,
            child: new Container(
              key: new ObjectKey(page.icon),
              padding: const EdgeInsets.all(12.0),
              child: page.widget
            ),
          );
        }).toList()
      ),
    );

    return formApp;
  }
}

class EnsureVisibleWhenFocused extends StatefulWidget {
  const EnsureVisibleWhenFocused({
    Key key,
    @required this.child,
    @required this.focusNode,
    this.curve: Curves.ease,
    this.duration: const Duration(milliseconds: 100),
  }) : super(key: key);

  final FocusNode focusNode;
  final Widget child;
  final Curve curve;
  final Duration duration;

  EnsureVisibleWhenFocusedState createState() => new EnsureVisibleWhenFocusedState();
}

class EnsureVisibleWhenFocusedState extends State<EnsureVisibleWhenFocused> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_ensureVisible);
  }

  @override
  void dispose() {
    super.dispose();
    widget.focusNode.removeListener(_ensureVisible);
  }

  Future<Null> _ensureVisible() async {
    await new Future.delayed(const Duration(milliseconds: 600));

    if (!widget.focusNode.hasFocus)
      return;

    final RenderObject object = context.findRenderObject();
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);
    assert(viewport != null);

    ScrollableState scrollableState = Scrollable.of(context);
    assert(scrollableState != null);

    ScrollPosition position = scrollableState.position;
    double alignment;
    if (position.pixels > viewport.getOffsetToReveal(object, 0.0)) {
      alignment = 0.0;
    } else if (position.pixels < viewport.getOffsetToReveal(object, 1.0)) {
      alignment = 1.0;
    } else {
      return;
    }
    position.ensureVisible(
      object,
      alignment: alignment,
      duration: widget.duration,
      curve: widget.curve,
    );
  }
  Widget build(BuildContext context) => widget.child;
}

class InputDropdown extends StatelessWidget {
  const InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);
 
  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;
 
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
          isDense: true,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
          ],
        ),
      ),
    );
  }
}
