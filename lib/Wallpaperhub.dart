import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Wallpaperhub extends StatefulWidget {
  const Wallpaperhub({Key? key}) : super(key: key);

  @override
  State<Wallpaperhub> createState() => _WallpaperhubState();
}

class _WallpaperhubState extends State<Wallpaperhub> {
  List? imageFile;

  @override
  getWallpaperhub() async {
    SharedPreferences Wallpaperhub = await SharedPreferences.getInstance();
    List<String>? hub = Wallpaperhub.getStringList('Wallpaperhub');
    return hub;
  }

  setwallpaperhub() async {
    SharedPreferences Wallpaperhub = await SharedPreferences.getInstance();
    Wallpaperhub.setStringList('Wallpaperhub', hub);
  }

  void initState() {
    displayImage();
    super.initState();
  }

  displayImage() async {
    var response = await http.get(Uri.parse("https://picsum.photos/v2/list"),
        headers: {"accept": "application/json"});
    setState(() {
      imageFile = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Image Upload"),
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 30,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            imageFile![index]["download_url"],
                            fit: BoxFit.cover,
                          ))
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            // elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SizedBox(height: 130, width: 100),
                          )));
            }));
  }
}
