import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<Null> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();

  } catch (error) {
    print(error);
  }
}

Future<Null> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

void main() {
  runApp(new FisioApp());
}

class Page {
  const Page({ this.icon, this.widget });
  final IconData icon;
  final Widget widget;
}

 

class FisioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Fisioterapia",
      home: new FisioPage(),
    );
  }
}

class FisioPage extends StatefulWidget {
  @override
  _FisioPageState createState() => new _FisioPageState();
}

class _FisioPageState extends State<FisioPage>  with SingleTickerProviderStateMixin {
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
  FocusNode _focusNodeFR3min = new FocusNode();
  FocusNode _focusNodeSpO23min = new FocusNode();
  FocusNode _focusNodePA3min = new FocusNode();
  FocusNode _focusNodeBorgD3min = new FocusNode();
  FocusNode _focusNodeBorgMMII3min = new FocusNode();
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
  TextEditingController _controllerFR3min = new TextEditingController();
  TextEditingController _controllerSpO23min = new TextEditingController();
  TextEditingController _controllerPA3min = new TextEditingController();
  TextEditingController _controllerBorgD3min = new TextEditingController();
  TextEditingController _controllerBorgMMII3min = new TextEditingController();
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

  String vo2PicoString;
  String estimativaDistanciaTC6MString;

  String value = "Homem";
  String _valueTextNormalPimax = '';
  String _valueTextNormalPemax = '';
  bool _customIndicator = false;

  int numeroDistancia = 0;
  

  

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  vo2Pico(int distancia) {
    this.vo2PicoString = ((0.03 * distancia) + 3.98).toStringAsFixed(2).toString().replaceAll('.', ',');  
  }

  estimativaDistanciaTC6M() {
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
//
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
//
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
//
                  new InputDropdown(
                    labelText: 'Pimáx normal',
                    valueText: _valueTextNormalPimax,
                    valueStyle: valueStyle,
                    onPressed: () {},
                  ),
//
                  new InputDropdown(
                    labelText: 'Pemáx normal',
                    valueText: _valueTextNormalPemax,
                    valueStyle: valueStyle,
                    onPressed: () {},
                  ),
//
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
//
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
                              labelText: "SpO2",
                              isDense: true,
                            ),
                          ),
                        )
                      ),
                      new Container(
                        child: new EnsureVisibleWhenFocused(
                          focusNode: _focusNodePARepouso,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
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
//
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
                          focusNode: _focusNodeFR3min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerFR3min,
                            maxLines: 1,
                            focusNode: _focusNodeFR3min,
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
                          focusNode: _focusNodePA3min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerPA3min,
                            maxLines: 1,
                            focusNode: _focusNodePA3min,
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
                          focusNode: _focusNodeBorgD3min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerBorgD3min,
                            maxLines: 1,
                            focusNode: _focusNodeBorgD3min,
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
                          focusNode: _focusNodeBorgMMII3min,            
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: _controllerBorgMMII3min,
                            maxLines: 1,
                            focusNode: _focusNodeBorgMMII3min,
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
//
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
//
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
//
                      new Container(margin: new EdgeInsets.all(42.0)),
//
                    ]
                  )
                )
              ]
            ),
//
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
//
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
//
          ]
        )
      ),
//
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
          ],
        )
      )
    ];

    
    
    //Decoration getIndicator() {
    //  return new ShapeDecoration(
    //    shape: const CircleBorder(
    //      side: const BorderSide(
    //        color: Colors.white24,
    //        width: 4.0,
    //      ),
    //    ) + const CircleBorder(
    //      side: const BorderSide(
    //        color: Colors.transparent,
    //        width: 4.0,
    //      ),
    //    ),
    //  );
    //}

    var fisioApp = new Scaffold(
      appBar: new AppBar(
        title: new Text('Fisioterapia'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.exit_to_app),
            onPressed: () {
              _handleSignOut();
            }
          )
        ],
        backgroundColor: Colors.pink[400],
        bottom: new TabBar(
          controller: _controller,
          isScrollable: true,
          //indicator: getIndicator(),
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
                    onTap: () {
                      _handleSignIn();
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

    return _googleSignIn.currentUser == null ? loginPage : fisioApp;
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
