import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  var routes = <String, WidgetBuilder> {
    SecondPage.routeName: (BuildContext context) => SecondPage()
  };

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
      routes: routes,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MyCard(
              icon: IconButton(
                icon: Icon(Icons.favorite, color: Colors.redAccent,),
                iconSize: 70.0,
                onPressed: () => Navigator.pushNamed(context, SecondPage.routeName),
              ),
              title: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}


class MyCard extends StatelessWidget {
  final Widget title;
  final Widget icon;

  MyCard({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom:20.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              title,
              icon
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {

  static const String routeName = '/SecondPage';

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second page'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: MyCard(
            icon: IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              iconSize: 70.0,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('second page'),
          ),
        ),
      ),
    );
  }
}