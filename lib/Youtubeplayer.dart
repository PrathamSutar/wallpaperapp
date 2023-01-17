import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtubeplayer extends StatefulWidget {
  var resp;

  var play;

  Youtubeplayer({Key? key, this.resp, this.play}) : super(key: key);

  @override
  State<Youtubeplayer> createState() => _YoutubeplayerState();
}

class _YoutubeplayerState extends State<Youtubeplayer> {
  late YoutubePlayerController _controller;
  void initState() {
    super.initState();
    var url = "https://www.youtube.com/watch?v=${widget.resp}";
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
            mute: false, loop: false, autoPlay: true, hideControls: false))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.yellow,
                centerTitle: true,
                title: Text(widget.play),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    player,
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          },
                          child: Text(
                              _controller.value.isPlaying ? "Pause" : "Play")),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
