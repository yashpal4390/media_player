import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class MediaPlayerProvider extends ChangeNotifier {
  bool isPlaying = false; // Add this variable
  bool clicked = false;
  List<Audio> playedSongs = [];
  List<Audio> favorite = [];
  int index=0;

  void refresh() {
    notifyListeners();
  }

  void addRecent(Audio audio) {
    playedSongs.add(audio);
    print("Audui ${audio.metas.title}");
    print("Audui ${playedSongs.length}");
    notifyListeners();
  }
}
