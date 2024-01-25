// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print, prefer_is_empty
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  List<Audio> al = [
    Audio.network(
        "https://pagalfree.com/musics/128-Ishq%20Jaisa%20Kuch%20-%20Fighter%20128%20Kbps.mp3",
        metas: Metas(
          title: "Ishq Jaisa Kuch",
          album: "Fighter",
          artist: "Vishal-Sheykhar, Shilpa Rao, Mellow D, Kumaar",
          image: MetasImage.network(
              "https://pagalfree.com/images/128Ishq%20Jaisa%20Kuch%20-%20Fighter%20128%20Kbps.jpg"),
        )),
    Audio.network(
        "https://pagalfree.com/musics/128-Banda%20-%20Dunki%20128%20Kbps.mp3",
        metas: Metas(
          title: "Banda",
          album: "Dunki",
          artist: "Pritam, Diljit Dosanjh, Kumaar",
          image: MetasImage.network(
              "https://pagalfree.com/images/128Banda%20-%20Dunki%20128%20Kbps.jpg"),
        )),
    Audio.network(
        "https://pagalfree.com/musics/128-O%20Maahi%20-%20Dunki%20128%20Kbps.mp3",
        metas: Metas(
          title: "O Maahi",
          album: "Fighter",
          artist: "Vishal-Sheykhar, Shilpa Rao, Mellow D, Kumaar",
          image: MetasImage.network(
              "https://pagalfree.com/images/128O%20Maahi%20-%20Dunki%20128%20Kbps.jpg"),
        )),
    Audio.network(
        "https://pagalfree.com/musics/128-Abrars%20Entry%20Jamal%20Kudu%20-%20Animal%20128%20Kbps.mp3",
        metas: Metas(
          title: "Abrars Entry Jamal Kudu",
          album: "Fighter",
          artist: "Vishal-Sheykhar, Shilpa Rao, Mellow D, Kumaar",
          image: MetasImage.network(
              "https://pagalfree.com/images/128Abrars%20Entry%20Jamal%20Kudu%20-%20Animal%20128%20Kbps.jpg"),
        )),
  ];
  List<Audio> playedSongs = [];
  bool isPlaying = false; // Add this variable
  bool clicked = false;

  @override
  void initState() {
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    assetsAudioPlayer.open(Playlist(audios: al), autoStart: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 10),
          Row(
            children: const [
              SizedBox(width: 10),
              Text(
                "Recently played",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          (playedSongs.length > 0)
              ? SizedBox(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: playedSongs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var metasImage = playedSongs[index].metas.image;
                      var imagePath =
                          metasImage?.path ?? ""; // Get the image path
                      return InkWell(
                        onTap: () {
                          clicked = true;
                          setState(() {});
                          assetsAudioPlayer.playlistPlayAtIndex(index);
                          isPlaying = true;
                          if (playedSongs.contains(al[index])) {
                            print("Already==");
                          } else {
                            playedSongs.add(al[index]);
                          }
                          print("Legnth==>");
                          print(playedSongs.length);
                        },
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          margin: EdgeInsets.all(8.0),
                          child: Center(
                            child: Image.network(
                              imagePath,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: 170,
                  child:
                      Center(child: Text("You Have Not Played any Song yet..")),
                ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.15,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(width: 10),
          Row(
            children: const [
              SizedBox(width: 10),
              Text("New to Bollywood",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: al.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Set the number of items in a row
                crossAxisSpacing: 3.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                var metasImage = al[index].metas.image;
                var imagePath = metasImage?.path ?? ""; // Get the image path
                return InkWell(
                  onTap: () {
                    clicked = true;
                    setState(() {});
                    assetsAudioPlayer.playlistPlayAtIndex(index);
                    isPlaying = true;
                    if (playedSongs.contains(al[index])) {
                      print("Already==");
                    } else {
                      playedSongs.add(al[index]);
                    }
                    print("Legnth==>");
                    print(playedSongs.length);
                  },
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.15,
                    margin: EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.network(
                        imagePath,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          StreamBuilder<Playing?>(
              stream: assetsAudioPlayer.current,
              builder: (context, snapshot) {
                var title = snapshot.data?.playlist.current.metas.title ?? " ";
                var album = snapshot.data?.playlist.current.metas.album ?? "";
                var path =
                    snapshot.data?.playlist.current.metas.image?.path ?? "";
                var song = snapshot.data?.playlist.current;

                if (playedSongs.contains(song)) {
                  print("Already");
                } else if (song != null) {
                  print("object ${song.metas.title}");
                  playedSongs.add(song);
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    setState(() {});
                  });
                }
                return (clicked)
                    ? ListTile(
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(path),
                        ),
                        title: Text(title),
                        subtitle: Text(album),
                      )
                    : SizedBox.shrink();
              }),
          StreamBuilder<Duration>(
              stream: assetsAudioPlayer.currentPosition,
              builder: (context, snapshot) {
                var sec = snapshot.data?.inSeconds ?? 0;
                var min = snapshot.data?.inMinutes ?? 0;
                return StreamBuilder<Playing?>(
                    stream: assetsAudioPlayer.current,
                    builder: (context, snapshot) {
                      var duration = snapshot.data?.audio.duration;
                      if (duration != null) {
                        return (clicked)
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Slider(
                                      value: sec.toDouble(),
                                      max: (duration.inSeconds).toDouble(),
                                      onChanged: (value) {
                                        print("value $value");
                                        assetsAudioPlayer.seek(
                                            Duration(seconds: value.toInt()));
                                      },
                                    ),
                                  ),
                                  Text("${min % 60}:${sec % 60}")
                                ],
                              )
                            : SizedBox.shrink();
                      } else {
                        return SizedBox.shrink();
                        ;
                      }
                    });
              }),
          (clicked)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          assetsAudioPlayer.previous();
                        },
                        icon: Icon(Icons.skip_previous)),
                    StreamBuilder<bool>(
                        stream: assetsAudioPlayer.isPlaying,
                        builder: (context, snapshot) {
                          isPlaying = snapshot.data ?? false;
                          var playing = isPlaying;
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
                                    icon: Icon(playing
                                        ? Icons.pause
                                        : Icons.play_arrow));
                              });
                        }),
                    IconButton(
                        onPressed: () {
                          assetsAudioPlayer.next();
                        },
                        icon: Icon(Icons.skip_next)),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
