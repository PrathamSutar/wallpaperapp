import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_556/Youtubejson.dart';
import 'package:flutter_556/Youtubeplayer.dart';

//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtube extends StatefulWidget {
  const Youtube({Key? key}) : super(key: key);

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  @override
  void initState() {
    super.initState();
    youtubeapi();
  }

  Youtubevideo? flutter;

  youtubeapi() async {
    var resp = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?key=AIzaSyCKInVJUz_GuxXd5FbIlROk6fxNFeGUMTA&q=health&type=video&order=title&part=snippet"));
    // print("Body -> ${resp.body}");
    // print(respArr.length);

    setState(() {
      flutter = Youtubevideo.fromJson(json.decode(resp.body));
    });

    print("${flutter!.items.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("You Tube"),
        ),
      ),
      body: flutter != null
          ? ListView.builder(
              itemCount: flutter!.items.length,
              itemBuilder: (context, indexno) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Youtubeplayer(
                                  play: flutter!
                                      .items[indexno].snippet.channelTitle,
                                  resp: flutter!.items[indexno].id.videoId)));
                    });
                  },
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          flutter!.items[indexno].snippet.thumbnails.high.url,
                          height: 80,
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                "Title :${flutter!.items[indexno].snippet.title}"),
                            Text(
                                "Published :${flutter!.items[indexno].snippet.publishedAt}")
                          ],
                        ))
                      ],
                    ),
                  ),

                  // child: Card(
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Image.network(
                  //         flutter!.items[indexno].snippet.thumbnails.high.url,
                  //         height: 80,
                  //       ),
                  //       Flexible(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(flutter!.items[indexno].snippet.title),
                  //             Text(flutter!.items[indexno].snippet.description),
                  //             Text(flutter!.items[indexno].snippet.channelId),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
