// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:media_player/Controller/media_provider.dart';
import 'package:media_player/Util.dart';
import 'package:media_player/View/FirstPage.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<MediaPlayerProvider>(context, listen: false).index = 3;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text("Media PLayer"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: 600,
        child: ListView.builder(
          itemCount: Provider.of<MediaPlayerProvider>(context, listen: false)
              .favorite
              .length,
          itemBuilder: (context, index) {
            var a = Provider.of<MediaPlayerProvider>(context, listen: false);
            var title = a.favorite[index].metas.title;
            var subtitle = a.favorite[index].metas.album;
            return ListTile(
              leading: Icon(Icons.queue_music_outlined, color: Colors.blueGrey),
              trailing: Icon(Icons.menu),
              title: Text(title.toString()),
              subtitle: Text(subtitle.toString()),
            );
          },
        ),
      ),
    );
  }
}
