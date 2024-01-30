// ignore_for_file: prefer_const_constructors
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:media_player/View/FirstPage.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? contoller;
  ChewieController? chewieController;
  List<String>audio=[
    "Hai Saz Tu Tera Darz Me..",
    "Tenu Yad Rave tu Menu ..",
    "Sachhi Si Hai ye Tarife..",
    "Darkhast hai ye..",
    "Meri Aankho Ki Dua..",
    "Tere Nalo Chali Hasin..",
    "Ruthe to Khuda Ruthe..",
    "KuchhBhi Nahi hai Ye Jaha"
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video Player"), centerTitle: true, actions: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return FirstPage();
                },
              ));
            },
            icon: Icon(Icons.music_note_rounded))
      ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            InkWell(
              onTap: () async {
                contoller = null;
                print("Click");
                await initializeVideoAsset("assets/videos/1.mp4");
                showVideoModalBottomSheet();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: CustomDecorations.boxDecoration,
                child: Center(
                    child: Text(
                  audio[0],
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                contoller = null;
                print("Click");
                await initializeVideoAsset("assets/videos/2.mp4");
                showVideoModalBottomSheet();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: CustomDecorations.boxDecoration,
                child: Center(
                    child: Text(
                      audio[1],
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                contoller = null;
                print("Click");
                await initializeVideoAsset("assets/videos/3.mp4");
                showVideoModalBottomSheet();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: CustomDecorations.boxDecoration,
                child: Center(
                    child: Text(
                      audio[2],
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                contoller = null;
                print("Click");
                await initializeVideoAsset("assets/videos/4.mp4");
                showVideoModalBottomSheet();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: CustomDecorations.boxDecoration,
                child: Center(
                    child: Text(
                      audio[3],
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                contoller = null;
                print("Click");
                await initializeVideoAsset("assets/videos/5.mp4");
                showVideoModalBottomSheet();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: CustomDecorations.boxDecoration,
                child: Center(
                    child: Text(
                      audio[4],
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                contoller = null;
                print("Click");
                await initializeVideoAsset("assets/videos/6.mp4");
                showVideoModalBottomSheet();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: CustomDecorations.boxDecoration,
                child: Center(
                    child: Text(
                      audio[5],
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                contoller = null;
                print("Click");
                await initializeVideoAsset("assets/videos/7.mp4");
                showVideoModalBottomSheet();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: CustomDecorations.boxDecoration,
                child: Center(
                    child: Text(
                      audio[6],
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                contoller = null;
                print("Click");
                await initializeVideoAsset("assets/videos/8.mp4");
                showVideoModalBottomSheet();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: CustomDecorations.boxDecoration,
                child: Center(
                    child: Text(
                      audio[7],
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initializeVideoAsset(String videoAssetPath) async {
    chewieController?.dispose();
    contoller = null;
    print("Click");
    contoller = VideoPlayerController.asset(videoAssetPath);
    await contoller!.initialize();
    chewieController = ChewieController(
      videoPlayerController: contoller!,
      autoPlay: false,
      looping: true,
    );
    setState(() {});
  }

  void showVideoModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        if (chewieController != null) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsetsDirectional.all(8),
            child: AspectRatio(
              aspectRatio: contoller!.value.aspectRatio,
              child: Chewie(
                controller: chewieController!,
              ),
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.all(8),
            child: Text('Chewie controller is null'),
          );
        }
      },
    );
  }
}

class CustomDecorations {
  static BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 10.0,
        spreadRadius: 2.0,
      ),
    ],
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.teal],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}