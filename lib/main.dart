import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

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

  final TextEditingController _controllerNome = new TextEditingController();
  final TextEditingController _controllerIdade = new TextEditingController();
  final TextEditingController _controllerPeso = new TextEditingController();
  final TextEditingController _controllerAltura = new TextEditingController();
  final TextEditingController _controllerPimax = new TextEditingController();
  final TextEditingController _controllerPemax = new TextEditingController();

  final TextEditingController _controllerFCRepouso = new TextEditingController();
  final TextEditingController _controllerFRRepouso = new TextEditingController();
  final TextEditingController _controllerSpO2Repouso = new TextEditingController();
  final TextEditingController _controllerPARepouso = new TextEditingController();
  final TextEditingController _controllerBorgDRepouso = new TextEditingController();
  final TextEditingController _controllerBorgMMIIRepouso = new TextEditingController();
  final TextEditingController _controllerOxigenioRepouso = new TextEditingController();

  String value = "Homem";
  String _valueTextNormalPimax = '';
  String _valueTextNormalPemax = '';
  bool _customIndicator = false;
  List<DemoItem<dynamic>> _demoItems;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 2);

    _demoItems = <DemoItem<dynamic>>[
      new DemoItem<String>(
        name: 'Repouso',
        valueToString: (String value) => value,
        builder: (DemoItem<String> item) {
          void close() {
            setState(() {
              item.isExpanded = false;
            });
          }
          return new ListView(
            children: <Widget>[
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
                      labelText: "FC",
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
                      labelText: "FC",
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
                      labelText: "FC",
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
                      labelText: "FC",
                      isDense: true,
                    ),
                  ),
                )
              ),
            ],
          );
        },
      )
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    const Color _kKeyUmbraOpacity = const Color(0x33000000); // alpha = 0.2
    const Color _kKeyPenumbraOpacity = const Color(0x24000000); // alpha = 0.14
    const Color _kAmbientShadowOpacity = const Color(0x1F000000);

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
            )
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
        widget: new ListView(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: new ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _demoItems[index].isExpanded = !isExpanded;
                  });
                },
                children: _demoItems.map((DemoItem<dynamic> item) {
                  return new ExpansionPanel(
                    isExpanded: item.isExpanded,
                    headerBuilder: item.headerBuilder,
                    body: item.build()
                  );
                }).toList()
              ),
            )
          ]
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

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Fisioterapia'),
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

typedef Widget DemoItemBodyBuilder<T>(DemoItem<T> item);
typedef String ValueToString<T>(T value);

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint
  });

  final String name;
  final String value;
  final String hint;
  final bool showHint;

  Widget _crossFade(Widget first, Widget second, bool isExpanded) {
    return new AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 2,
          child: new Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: new FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: new Text(
                name,
                style: textTheme.body1.copyWith(fontSize: 15.0),
              ),
            ),
          ),
        ),
        new Expanded(
          flex: 3,
          child: new Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: _crossFade(
              new Text(value, style: textTheme.caption.copyWith(fontSize: 15.0)),
              new Text(hint, style: textTheme.caption.copyWith(fontSize: 15.0)),
              showHint
            )
          )
        )
      ]
    );
  }
}

class CollapsibleBody extends StatelessWidget {
  const CollapsibleBody({
    this.margin: EdgeInsets.zero,
    this.child,
    //this.onSave,
    //this.onCancel
  });

  final EdgeInsets margin;
  final Widget child;
  //final VoidCallback onSave;
  //final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return new Column(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            bottom: 24.0
          ) - margin,
          child: new Center(
            child: new DefaultTextStyle(
              style: textTheme.caption.copyWith(fontSize: 15.0),
              child: child
            )
          )
        ),
        //const Divider(height: 1.0),
        //new Container(
        //  padding: const EdgeInsets.symmetric(vertical: 16.0),
        //  child: new Row(
        //    mainAxisAlignment: MainAxisAlignment.end,
        //    children: <Widget>[
        //      new Container(
        //        margin: const EdgeInsets.only(right: 8.0),
        //        child: new FlatButton(
        //          onPressed: onCancel,
        //          child: const Text('CANCEL', style: const TextStyle(
        //            color: Colors.black54,
        //            fontSize: 15.0,
        //            fontWeight: FontWeight.w500
        //          ))
        //        )
        //      ),
        //      new Container(
        //        margin: const EdgeInsets.only(right: 8.0),
        //        child: new FlatButton(
        //          onPressed: onSave,
        //          textTheme: ButtonTextTheme.accent,
        //          child: const Text('SAVE')
        //        )
        //      )
        //    ]
        //  )
        //)
      ]
    );
  }
}

class DemoItem<T> {
  DemoItem({
    this.name,
    this.value,
    this.hint,
    this.builder,
    this.valueToString
  }) : textController = new TextEditingController(text: valueToString(value));

  final String name;
  final String hint;
  final TextEditingController textController;
  final DemoItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return new DualHeaderWithHint(
        name: name,
        value: valueToString(value),
        hint: hint,
        showHint: isExpanded
      );
    };
  }

  Widget build() => builder(this);
}

