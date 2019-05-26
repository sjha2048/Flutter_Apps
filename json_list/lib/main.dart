import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_list/videcell.dart';

void main() {
  runApp(Padding(
    padding: const EdgeInsets.all(8.0),
    child: new RealWorldApp(),
  ));
}

class RealWorldApp extends StatefulWidget {
  @override
  _RealWorldAppState createState() => _RealWorldAppState();
}

class _RealWorldAppState extends State<RealWorldApp> {
  var _isLoading = true;
  var videos;

  //get videoJson => null;

  _fetchData() async {
    print("attempting to fetch data from the internet");
    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      //print(response.body);
    }
    print(response);

    final map = jsonDecode(response.body);
    var videoJson = map["videos"];

    setState(() {
      _isLoading = false;
      this.videos = videoJson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Json_text"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print("reloading...");

                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.videos != null ? this.videos.length : 0,
                  itemBuilder: (context, i) {
                    final video = this.videos[i];
                    return new FlatButton(
                      padding: new EdgeInsets.all(0.0),
                      child: new VideoCell(video),
                      onPressed: (){
                        print("video cell tapped: $i");
                        Navigator.push(context,
                         new MaterialPageRoute(
                           builder: (context) => new DetailsPage()
                         ));
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("details page"),
      ),
      body: new Center(
        child: new Text("details"),
      ),
      
    );
  }
}
