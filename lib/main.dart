import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'widgets/PdfScreen.dart';
import 'widgets/MyApp.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BookList",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'App with many features'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _DisplayImageVid extends StatefulWidget {
  final int Code;
  late String pdfPath;
  _DisplayImageVid({required this.Code}) {}
  @override
  State<StatefulWidget> createState() => _DisplayImageVidState(Code: this.Code);
}

class _DisplayImageVidState extends State<_DisplayImageVid> {
  final int Code;
  late VideoPlayerController _vidController;

  _DisplayImageVidState({required this.Code}) {}

  @override
  void initState() {
    super.initState();
    _vidController = VideoPlayerController.asset('assets/videos/bee.mp4');
    _vidController.addListener(() {
      setState(() {});
    });
    _vidController.setLooping(true);
    _vidController.initialize().then((_) => setState(() {}));
    _vidController.play();
  }

  Widget _ImageOrVid() {
    if (Code == 1) {
      return Scaffold(
        body: Container(
          child: Image(image: AssetImage('assets/images/illustration1.png')),
        ),
      );
    } else
      return Scaffold(
        body: Container(
          height: 600,
          color: Colors.amber[500],
          child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            VideoPlayer(_vidController),
            VideoProgressIndicator(_vidController, allowScrubbing: true),
          ]
              // VideoPlayer(_vidController),
              ),
        ),
      );
  }

  Widget _pdf() {
    return Scaffold(
      body: Container(
        child: Image(image: AssetImage('assets/images/illustration1.png')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ImageOrVid();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [],
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _DisplayImageVid(Code: 1)));
              },
              title: Center(child: Text('Display image')),
              tileColor: Colors.amber[600],
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _DisplayImageVid(Code: 0)));
              },
              title: Center(child: Text('Play Video')),
              tileColor: Colors.amber[400],
            ),
            ListTile(
              onTap: () async {
                // final Player = AudioPlayer();
                final player = AudioPlayer();
                // player.audioCache =
                // AudioCache(prefix: 'assets/audio/audio1.wav');
                await player.setSource(AssetSource('assets/audio/audio.mp3'));
                await player.play(AssetSource('assets/audio/audio.mp3'));
                // await player.play();
              },
              title: Center(child: Text('Play Audio')),
              tileColor: Colors.amber[300],
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => DisplayPdf()));
            //   },
            //   title: Center(child: Text('Display pdf')),
            //   tileColor: Colors.amber[600],
            // ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DisplayWebsite()));
              },
              title: Center(child: Text('CoachX website')),
              tileColor: Colors.amber[400],
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp1()));
              },
              title: Center(child: Text('My App')),
              tileColor: Colors.amber[300],
            ),
          ],
        ),
      ),
    );
  }
}
