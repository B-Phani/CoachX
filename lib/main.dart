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

class _DetailScreen extends StatelessWidget {
      final String author;
      final int launchYear;

      _DetailScreen({required this.author,required this.launchYear});

      @override
      Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.cyanAccent, 
            body : Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    width: 5,
                    color: Colors.deepOrangeAccent
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15
                    )
                  ]
                ),
                height: 250,
                width: 300,
                child: Column( 
                  children: [ 
                  Padding(
                    padding:const EdgeInsets.all(20.0),
                    child :
                    Center(child : Text("The author of the selected book : $author"))  
                   ),
                   Padding(
                    padding:const EdgeInsets.all(20.0),
                    child :
                    Center(child : Text("This book was launched in $launchYear"))  
                   ),
                  // Center(child : Text("This book was launched in $launchYear")),
                  ])
                ),
            ),
            );
      }

}

class _MyHomePageState extends State<MyHomePage> {

  final dio = Dio();
  var EachbookData=[];

  void InitRefreshList(BookDataTemp)
  {
    Navigator.of(context).pop();
    setState(() {
    EachbookData = BookDataTemp['docs'];
    });
  }
  
  void DelItemInList(int DelIndex)
  {  
    setState(() {
      EachbookData.removeAt(DelIndex);
    });
  }
  
  void getHttp() async 
{
  showDialog(context: context 
  , builder: (context){
    return Center(child: CircularProgressIndicator());
  }
  );

  final response = await dio.get('https://openlibrary.org/search.json?q=novel');
  Map<String, dynamic> BookData = Map.from(response.data);
  // List<dynamic> BookData = jsonDecode(response.data);
  InitRefreshList(BookData);
}


  Widget _card(BuildContext context, index) {
            final item = EachbookData[index]['title'];
            final imageCode = EachbookData[index]['cover_i'];
            print(index);
            const HoverColor = Colors.deepOrange;
            return  Column(
              children: [
                GestureDetector(
                  onTap: () { 
                          Navigator.push(context, 
                          MaterialPageRoute(builder:  (context) => 
                          _DetailScreen(author: EachbookData[index]["author_name"][0], 
                          launchYear: EachbookData[index]["first_publish_year"]
                          )));
                      }, 
                  child : Card(                   
                    shadowColor: Colors.orange,
                    elevation: 10,
                    child: ListTile(
                    focusColor: Colors.black,
                    leading: CircleAvatar(backgroundImage: NetworkImage("https://covers.openlibrary.org/b/id/${imageCode}-S.jpg"),),
                          // Icon(ImageIcon(image)),
                    title: Text(item),     
                    trailing: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(7),
                                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(160, 255, 0, 21))
                                ),
                                onPressed:() { 
                                    DelItemInList(index);
                                 },
                              child: Text("Delete"),)
                  )),     
                  ),
              ],
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
          itemCount: EachbookData.length,
          itemBuilder: (context, index){
            return _card(context, index);
          }
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



//  Widget  _detailCard(context, author, launchYear){

//             return Scaffold( 
//             body : Column( 
//               children: [ 
//               Center(child : Text("The author of the selected book is $author")),
//               Center(child : Text("This book was launched in $launchYear")),
//               ]
//             ));
//   }