import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "BookList",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      
      home: const MyHomePage(title: 'Book List'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  final dio = Dio();
  var BookList = [];
  var _author = [];
  var _LaunchYear = [];
  void getHttp() async 
{
  showDialog(context: context 
  , builder: (context){
    return Center(child: CircularProgressIndicator());
  }
  );

  final response = await dio.get('https://openlibrary.org/search.json?q=test');
  final Map<String, dynamic> BookData = Map.from(response.data);
  // List<dynamic> BookData = jsonDecode(response.data);
  
  Navigator.of(context).pop();
  setState(() {
  for (var each in BookData["docs"]) {
    BookList.add(each["title"]);
    _author.add(each["author_name"]);
    _LaunchYear.add(each["first_publish_year"]);
  }
  print(BookList);
  });
}


  Widget _dialogBuilder(BuildContext context, var _authorName, var _launchYear) {
    var author = _authorName[0];
    
    return  
        Scaffold(
        body: Column(
          children: [
            Container(
              child: Text("Author of the selected book is $author"),
            ),
            Container(
              child: Text("This book was launched in $_launchYear"),
            ),
          ],
        )
      );
  }


  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return  Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        // final item = BookList[index];
        child: ListView.builder(
          itemCount: BookList.length,
          itemBuilder: (context, index) {
            final item = BookList[index];
            const HoverColor = Colors.deepOrange;
            return  GestureDetector(
              onTap: () => 
                  showDialog(context: context, 
                            builder: (context) => _dialogBuilder(context, _author[index],_LaunchYear[index])), 
              child : ListTile(
              hoverColor: HoverColor,
              leading: Icon(Icons.book),
              title: Text(item),
            ),);
          },
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: getHttp,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



// DefaultTextStyle.merge(
//         style : const TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold
//         ),
//         children: Center(
//           child: Text("Author of the selected book is $_authorName[0]"),
//           child: Text("This book was launched in $_LaunchYear:" )
//           ))