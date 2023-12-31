import 'package:first_proj/widgets/BookCards.dart';

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
  final int imageCode;
  final String place;
  final String publisher;
  final int ratingsNo;
  final dynamic ratingsAvg;
  final List language;
  dynamic image1;

  _DetailScreen(
      {required this.author,
      required this.launchYear,
      required this.imageCode,
      required this.place,
      required this.publisher,
      required this.ratingsNo,
      required this.ratingsAvg,
      required this.language}) {
    image1 = imageCode == null
        ? Image.network("https://covers.openlibrary.org/b/id/13265283-.jpg")
        : Image.network(
            "https://covers.openlibrary.org/b/id/${imageCode}-L.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 5, color: Colors.deepOrangeAccent),
                  boxShadow: [BoxShadow(blurRadius: 15)]),
              height: 300,
              width: 500,
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child:
                            Text("The author of the selected book : $author"))),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Text("This book was launched in $launchYear"))),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Text(
                            "This book was published at $place by the publisher $publisher"))),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Text(
                            "It has got $ratingsNo number of ratings and the average of all is $ratingsAvg"))),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Text(
                            "It is available in these languages : $language"))),
              ])),
          Container(
            // decoration:
            // BoxDecoration(
            //   color: Colors.yellowAccent,
            //   borderRadius: BorderRadius.circular(11),
            //   border: Border.all(
            //     width: 5,
            //     color: Colors.deepOrangeAccent
            //   ),
            //   boxShadow: [
            //     BoxShadow(
            //       blurRadius: 15
            //     )
            //   ]
            // ),
            height: 450,
            // width: 300,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(image: image1.image)
                // Image.network("https://covers.openlibrary.org/b/id/${imageCode}-L.jpg",
                //                       fit: BoxFit.fill,),
                ),
          )
        ]),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();
  var EachbookData = [];
  var img;
  final _textController = TextEditingController();

  void InitRefreshList(BookDataTemp) {
    Navigator.of(context).pop();
    setState(() {
      EachbookData = BookDataTemp['docs'];
    });
  }

  void DelItemInList(int DelIndex) {
    setState(() {
      EachbookData.removeAt(DelIndex);
    });
  }

  void getHttp(String bookName) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    final response =
        await dio.get('https://openlibrary.org/search.json?q=$bookName');
    Map<String, dynamic> BookData = Map.from(response.data);
    // List<dynamic> BookData = jsonDecode(response.data);
    InitRefreshList(BookData);
  }

  // void SearchFun(bookName) {

  // }

  Widget _card(BuildContext context, index) {
    final item = EachbookData[index]['title'];
    final imageCode = EachbookData[index]['cover_i'] == null
        ? 13265283
        : EachbookData[index]['cover_i'];
    final image1 = imageCode == null
        ? Image.network("https://covers.openlibrary.org/b/id/13265283-S.jpg")
        : Image.network(
            "https://covers.openlibrary.org/b/id/${imageCode}-S.jpg");
    // final image1 = Image.network("https://covers.openlibrary.org/b/id/${imageCode}-S.jpg");
    // final imageIP = image1 as ImageProvider;
    final PHimage = AssetImage('assets/images/cocacola.png');
    // final PHimageIP = AssetImage('assets/images/cocacola.png') as ImageProvider;
    bool _loaded = false;

    // @override
    // void initState() {
    //   super.initState();

    // image1.image.resolve(ImageConfiguration()).addListener(
    //   ImageStreamListener((ImageInfo image, bool synchronousCall) {
    // // image1.image.resolve(ImageConfiguration()).addListener((i, b) {
    //   if (mounted) {
    //     setState(() => _loaded = true);
    //   }
    // }
    //   ));
    // }

    const HoverColor = Colors.deepOrange;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => _DetailScreen(
                          author: EachbookData[index]["author_name"][0],
                          launchYear: EachbookData[index]["first_publish_year"],
                          imageCode: imageCode,
                          place: EachbookData[index]["publish_place"][0] == null
                              ? 'No Publish Place'
                              : EachbookData[index]["publish_place"][0],
                          publisher: EachbookData[index]["publisher"][0] == null
                              ? 'No Publish Place'
                              : EachbookData[index]["publisher"][0],
                          ratingsAvg: EachbookData[index]["ratings_average"],
                          ratingsNo: EachbookData[index]["ratings_count"],
                          language: EachbookData[index]["language"],
                        )));
          },
          child: Card(
              shadowColor: Colors.orange,
              elevation: 10,
              child: ListTile(
                  focusColor: Colors.black,
                  leading: CircleAvatar(
                    backgroundImage: image1.image,
                  ),

                  // CircleAvatar(backgroundImage: _loaded ? image1.image : PHimage as ImageProvider
                  // FadeInImage.assetNetwork(placeholder: 'assets/images/cocacola.png', image: 'https://covers.openlibrary.org/b/id/${imageCode}-S.jpg'),
                  // CircleAvatar(backgroundImage:
                  // NetworkImage("https://covers.openlibrary.org/b/id/${imageCode}-S.jpg"),),
                  title: Text(item),
                  trailing: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(7),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(160, 255, 0, 21))),
                    onPressed: () {
                      DelItemInList(index);
                    },
                    child: Text("Delete"),
                  ))),
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
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          Container(
            width: 500,
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Book name to be searched",
                prefixIcon: IconButton(
                    onPressed: () {
                      getHttp(_textController.text);
                    },
                    icon: const Icon(Icons.search)),
              ),
            ),
          )
        ],
      ),
      body: Container(
        // final item = BookList[index];
        child: ListView.builder(
            itemCount: EachbookData.length,
            itemBuilder: (context, index) {
              return _card(context, index);
              // BookCard(context, EachbookData[index]['title'],
              //               EachbookData[index]['cover_i'],
              //               EachbookData[index]["author_name"][0],
              //               EachbookData[index]["first_publish_year"],
              //               EachbookData[index]["publish_place"],
              //               EachbookData[index]["ratings_count"],
              //               EachbookData[index]["ratings_average"],
              //               );
            }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getHttp('Novel');
        },
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
