import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {


  List<PlaylistInfo> playlist;
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  ReusableWidgets _reusableWidgets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, -1);

    return Scaffold(
      appBar: _reusableWidgets.getSimpleAppBar(),
      body: ListView.separated(
            separatorBuilder: (context, index) => Divider(
            color: Color.fromRGBO(0, 0, 0, 0.8),
           ),
          padding: EdgeInsets.only(top: 10),
          itemCount: playlist.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: buildListTile,
      ),

    );
  }

  void getPlaylist() async {
    List <PlaylistInfo> l = await audioQuery.getPlaylists();
    setState(() {
      playlist = l;
    });
  }

  Widget buildListTile(BuildContext context, int index) {
    return ListTile(
      title: Text(playlist[index].name),
      leading: Icon(Icons.music_note),
      onTap: (){
        showBottomSheet(
            context: context,
            builder: (context) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
              ),
              height: 160,
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Playlist: ${playlist[index].name}", style: Theme.of(context).textTheme.display4),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromRGBO(200, 0, 0, 1),
                    disabledColor: Color.fromRGBO(200, 0, 0, 1),
                    child: Text("Auswählen",  style: Theme.of(context).textTheme.display1),
                    //TODO Playlist speichern
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}
