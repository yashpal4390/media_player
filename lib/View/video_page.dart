// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  List<String> imgUrl=[
    "assets/images/videoThumbnails/1.jpg",
  ];
  late VideoPlayerController _controller;
  ChewieController? chewieController;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
      ..initialize().then((value) {
        chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: false,
          looping: true,
        );
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    chewieController?.dispose();
    super.dispose();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          if (chewieController != null)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Chewie(
                controller: chewieController!,
              ),
            ),
        ],
      ),
    );
  }
}
