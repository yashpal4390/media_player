// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print, prefer_is_empty, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:media_player/Controller/media_provider.dart';
import 'package:media_player/View/favorite_page.dart';
import 'package:media_player/main.dart';
import 'package:media_player/Util.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    assetsAudioPlayer.open(Playlist(audios: al), autoStart: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MediaPlayerProvider>(context, listen: false).index = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Media PLayer"),
        centerTitle: true,
        leading: SizedBox.shrink(),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (isBottomSheetOpen) {
            return false;
          } else {
            return true;
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 10),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Recently played",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Consumer<MediaPlayerProvider>(
              builder: (BuildContext context, MediaPlayerProvider value,
                  Widget? child) {
                print("value.playedSongs ${value.playedSongs.length}");
                if (value.playedSongs.isEmpty) {
                  return SizedBox(
                    height: 150,
                    child: Center(
                        child: Text("You Have Not Played any Song yet..")),
                  );
                }
                return SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value.playedSongs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var metasImage = value.playedSongs[index].metas.image;
                      var imagePath =
                          metasImage?.path ?? ""; // Get the image path
                      return InkWell(
                        onTap: () {
                          var provider = Provider.of<MediaPlayerProvider>(
                              context,
                              listen: false);
                          provider.clicked = true;
                          print("YOU CLICKED ${provider.clicked}");
                          Provider.of<MediaPlayerProvider>(context,
                                  listen: false)
                              .clicked = true;
                          assetsAudioPlayer.open(Playlist(audios: al),
                              autoStart: false, showNotification: true);
                          assetsAudioPlayer.playlistPlayAtIndex(index);
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
                );
              },
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
              height: 180,
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
                      var provider = Provider.of<MediaPlayerProvider>(context,
                          listen: false);
                      provider.clicked = true;
                      print("YOU CLICKED ${provider.clicked}");
                      assetsAudioPlayer.playlistPlayAtIndex(index);
                      var mp = Provider.of<MediaPlayerProvider>(context,
                          listen: false);
                      mp.isPlaying = true;
                      if (mp.playedSongs.contains(al[index])) {
                        print("Already==");
                      } else {
                        mp.playedSongs.add(al[index]);
                      }
                      print("Legnth==>");
                      print(mp.playedSongs.length);
                      showBottomSheet(
                        context: context,
                        enableDrag: false,
                        builder: (BuildContext context) {
                          isBottomSheetOpen = true;
                          print("BOTTOM ==> $isBottomSheetOpen");
                          Provider.of<MediaPlayerProvider>(context,
                                  listen: false)
                              .refresh();
                          return Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Color.fromRGBO(150, 36, 25, 1),
                              Color.fromRGBO(102, 23, 16, 1),
                              Color.fromRGBO(67, 14, 9, 1),
                            ])),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          isBottomSheetOpen = false;
                                          print(
                                              "BOTTOM ==> $isBottomSheetOpen");
                                          Navigator.pop(context);
                                          // Provider.of<MediaPlayerProvider>(context, listen: false)
                                          //     .clicked = false;
                                          Provider.of<MediaPlayerProvider>(
                                                  context,
                                                  listen: false)
                                              .refresh();
                                        },
                                        icon: Icon(Icons.expand_circle_down),
                                        color: Colors.white),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_horiz),
                                        color: Colors.white),
                                  ],
                                ),
                                Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      StreamBuilder<Playing?>(
                                          stream: assetsAudioPlayer.current,
                                          builder: (context, snapshot) {
                                            var path = snapshot
                                                    .data
                                                    ?.playlist
                                                    .current
                                                    .metas
                                                    .image
                                                    ?.path ??
                                                "";
                                            var demo = snapshot.data?.audio;
                                            return Container(
                                              child: Image.network(
                                                demo?.audio.metas.image?.path ??
                                                    "",
                                                height: 300,
                                              ),
                                              height: 350,
                                              margin: EdgeInsets.only(
                                                  left: 30,
                                                  top: 20,
                                                  bottom: 10),
                                            );
                                          }),
                                      StreamBuilder<Playing?>(
                                          stream: assetsAudioPlayer.current,
                                          builder: (context, snapshot) {
                                            var title = snapshot.data?.playlist
                                                    .current.metas.title ??
                                                " ";
                                            var album = snapshot.data?.playlist
                                                    .current.metas.album ??
                                                "";

                                            var song =
                                                snapshot.data?.playlist.current;
                                            return Row(
                                              children: [
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        title,
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        album,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  margin:
                                                      EdgeInsets.only(left: 20),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                    onPressed: () {
                                                      if (Provider.of<
                                                                  MediaPlayerProvider>(
                                                              context,
                                                              listen: false)
                                                          .favorite
                                                          .contains(song)) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                "Already Added to Favorite"),
                                                            duration: Duration(
                                                                seconds: 2),
                                                            // Adjust the duration as needed
                                                            backgroundColor:
                                                                Colors.green,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                          ),
                                                        );
                                                        print(
                                                            "Alreayy in Favoite");
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                "Added to Favorite"),
                                                            duration: Duration(
                                                                seconds: 2),
                                                            // Adjust the duration as needed
                                                            backgroundColor:
                                                                Colors.green,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                          ),
                                                        );
                                                        Provider.of<MediaPlayerProvider>(
                                                                context,
                                                                listen: false)
                                                            .favorite
                                                            .add(song!);
                                                        print("Legnth==>");
                                                        print(Provider.of<
                                                                    MediaPlayerProvider>(
                                                                context,
                                                                listen: false)
                                                            .favorite
                                                            .length);
                                                      }
                                                    },
                                                    icon: Icon(Icons
                                                        .favorite_border_outlined),
                                                    color: Colors.white)
                                              ],
                                            );
                                          }),
                                      StreamBuilder<Duration>(
                                          stream:
                                              assetsAudioPlayer.currentPosition,
                                          builder: (context, snapshot) {
                                            var sec =
                                                snapshot.data?.inSeconds ?? 0;
                                            var min =
                                                snapshot.data?.inMinutes ?? 0;
                                            return StreamBuilder<Playing?>(
                                                stream:
                                                    assetsAudioPlayer.current,
                                                builder: (context, snapshot) {
                                                  var duration = snapshot
                                                      .data?.audio.duration;
                                                  if (duration != null) {
                                                    return Container(
                                                      margin:
                                                          EdgeInsetsDirectional
                                                              .all(8),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Slider(
                                                              value: sec
                                                                  .toDouble(),
                                                              max: (duration
                                                                      .inSeconds)
                                                                  .toDouble(),
                                                              onChanged:
                                                                  (value) {
                                                                assetsAudioPlayer
                                                                    .seek(Duration(
                                                                        seconds:
                                                                            value.toInt()));
                                                              },
                                                            ),
                                                          ),
                                                          Text(
                                                              "${min % 60}:${sec % 60}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return SizedBox.shrink();
                                                  }
                                                });
                                          }),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                assetsAudioPlayer.previous();
                                              },
                                              icon: Icon(Icons.skip_previous),
                                              color: Colors.white,
                                              iconSize: 50),
                                          StreamBuilder<bool>(
                                              stream:
                                                  assetsAudioPlayer.isPlaying,
                                              builder: (context, snapshot) {
                                                mp.isPlaying =
                                                    snapshot.data ?? false;
                                                var playing = mp.isPlaying;
                                                SchedulerBinding.instance
                                                    .addPostFrameCallback(
                                                        (timeStamp) {});
                                                return StreamBuilder<bool>(
                                                    stream: assetsAudioPlayer
                                                        .isBuffering,
                                                    builder:
                                                        (context, snapshot1) {
                                                      if (snapshot1.data ??
                                                          false) {
                                                        return SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      }
                                                      return IconButton(
                                                          onPressed: () {
                                                            if (playing) {
                                                              assetsAudioPlayer
                                                                  .pause();
                                                            } else {
                                                              assetsAudioPlayer
                                                                  .play();
                                                            }
                                                          },
                                                          icon: Icon(playing
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow),
                                                          color: Colors.white,
                                                          iconSize: 50);
                                                    });
                                              }),
                                          IconButton(
                                              onPressed: () {
                                                assetsAudioPlayer.next();
                                              },
                                              icon: Icon(Icons.skip_next),
                                              color: Colors.white,
                                              iconSize: 50),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
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
            (Provider.of<MediaPlayerProvider>(context, listen: false).clicked ==
                    false)
                ? StreamBuilder<Playing?>(
                    stream: assetsAudioPlayer.current,
                    builder: (context, snapshot) {
                      var title =
                          snapshot.data?.playlist.current.metas.title ?? " ";
                      var album =
                          snapshot.data?.playlist.current.metas.album ?? "";
                      var path =
                          snapshot.data?.playlist.current.metas.image?.path ??
                              "";
                      var song = snapshot.data?.playlist.current;
                      var mp = Provider.of<MediaPlayerProvider>(context,
                          listen: false);
                      print("===> ${song != null} and ${mp.isPlaying}");
                      if (song != null) {}

                      if (mp.playedSongs.contains(song)) {
                        print("playedSongs Contain");
                      } else if (song != null && mp.isPlaying == true) {
                        print("object ${song.metas.title}");
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Provider.of<MediaPlayerProvider>(context,
                                  listen: false)
                              .addRecent(song);
                        });
                      }
                      return ListTile(
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(path),
                        ),
                        title: Text(title),
                        subtitle: Text(album),
                      );
                    })
                : SizedBox.shrink(),
            (Provider.of<MediaPlayerProvider>(context, listen: false).clicked ==
                    false)
                ? StreamBuilder<Duration>(
                    stream: assetsAudioPlayer.currentPosition,
                    builder: (context, snapshot) {
                      var sec = snapshot.data?.inSeconds ?? 0;
                      var min = snapshot.data?.inMinutes ?? 0;
                      return StreamBuilder<Playing?>(
                          stream: assetsAudioPlayer.current,
                          builder: (context, snapshot) {
                            var duration = snapshot.data?.audio.duration;
                            if (duration != null) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Slider(
                                      value: sec.toDouble(),
                                      max: (duration.inSeconds).toDouble(),
                                      onChanged: (value) {
                                        assetsAudioPlayer.seek(
                                            Duration(seconds: value.toInt()));
                                      },
                                    ),
                                  ),
                                  Text("${min % 60}:${sec % 60}")
                                ],
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          });
                    })
                : SizedBox.shrink(),
            (Provider.of<MediaPlayerProvider>(context, listen: false).clicked ==
                    false)
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
                            var playing = snapshot.data ?? false;
                            // SchedulerBinding.instance
                            //     .addPostFrameCallback((timeStamp) {
                            //   setState(() {});
                            // });
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
                                          var audio = assetsAudioPlayer
                                              .current.value?.audio.audio;
                                          var mprovider =
                                              Provider.of<MediaPlayerProvider>(
                                                  context,
                                                  listen: false);

                                          if (audio != null &&
                                              mprovider.isPlaying == false) {
                                            SchedulerBinding.instance
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              Provider.of<MediaPlayerProvider>(
                                                      context,
                                                      listen: false)
                                                  .addRecent(audio);
                                            });
                                          }
                                          mprovider.isPlaying = true;

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
      ),
    );
  }
}
