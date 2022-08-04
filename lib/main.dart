import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("animation 101"),
        ),
        body: TweenAnimationBuilder(
          duration: Duration(seconds: 4),
          tween: EdgeInsetsTween(
              begin: EdgeInsets.all(100), end: EdgeInsets.all(200)),
          builder: (BuildContext context, EdgeInsets? value, Widget? child) {
            return Center(
              child: Column(
                children: [
                  Container(
                    height: 100,
                  ),
                  Container(
                    padding: value!,
                    color: Colors.white,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
