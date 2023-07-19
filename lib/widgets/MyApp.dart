import 'package:flutter/material.dart';

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey, primary: Colors.black),
        useMaterial3: true,
      ),
      home: DisplayMyApp(),
    );
  }
}

class DisplayMyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DisplayAppState();
}

class _DisplayAppState extends State<DisplayMyApp> {
  // _DisplayPdfState() {}

  // @override
  // void initState() {
  // }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('First page'),
        ),
        body: Container(
          child: Center(
            child: Column(children: [
              Text('Counter of page visits: $_counter'),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SecondPg()));
                  },
                  child: Text("Go to Second Page"))
            ]),
          ),
        ));
  }
}

class SecondPg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Second Page"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Go Back")),
      ),
    );
  }
}
