// ignore_for_file: prefer_const_constructors

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controller/media_provider.dart';
import 'View/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MediaPlayerProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                assetsAudioPlayer.open(
                  Audio("assets/mp3/one.mp3"),
                  autoStart: false,
                  showNotification: true,
                );
              },
              child: Text("Aagle Janam"),
            ),
            TextButton(
                onPressed: () {
                  assetsAudioPlayer.open(
                    Audio("assets/mp3/two.mp3"),
                    autoStart: false,
                    showNotification: true,
                  );
                },
                child: Text("Tu hai kaha")),
            TextButton(
                onPressed: () {
                  assetsAudioPlayer.open(
                    Audio.network(
                        "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3"),
                    autoStart: false,
                    showNotification: true,
                  );
                },
                child: Text("Network")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.skip_previous)),
                StreamBuilder<bool>(
                    stream: assetsAudioPlayer.isPlaying,
                    builder: (context, snapshot) {
                      var playing = snapshot.data ?? false;
                      return StreamBuilder<bool>(
                          stream: assetsAudioPlayer.isBuffering,
                          builder: (context, snapshot1) {
                            if (snapshot1.data ?? false) {
                              return SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              );
                            }
                            return IconButton(
                                onPressed: () {
                                  if (playing) {
                                    assetsAudioPlayer.pause();
                                  } else {
                                    assetsAudioPlayer.play();
                                  }
                                },
                                icon: Icon(
                                    playing ? Icons.pause : Icons.play_arrow));
                          });
                    }),
                IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
