import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = Tween<double>(begin: 0, end: 300).animate(_controller)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed) {
          _controller.reverse();
        } else if(status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      })
      ..addStatusListener((state) => print('$state'));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GrowTransition(animation: _animation, child: LogoWidget(),);
}

class GrowTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  GrowTransition({this.animation, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, child) => Container(
          height: animation.value,
          width: animation.value,
          child: child,
        ),
        child: child,
      ),      
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {

  AnimatedLogo({Key key, Animation<double> animation})
    : super(key : key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}