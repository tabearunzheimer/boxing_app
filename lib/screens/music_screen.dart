import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:uebung02/helper/current_workout_information.dart';
import 'package:uebung02/screens/choose_workout_summary_screen.dart';
import 'package:uebung02/screens/reusable_widgets.dart';
import 'package:uebung02/screens/workout_screen.dart';

class MusicScreen extends StatefulWidget {
  CurrentWorkoutInformation workoutInformation;

  MusicScreen(CurrentWorkoutInformation cOld) {
    this.workoutInformation = cOld;
  }
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {


  List<PlaylistInfo> playlist;
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  ReusableWidgets _reusableWidgets;

  @override
  void initState() {
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
          itemCount: playlist.length+1,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: buildListTile,
      ),

    );
  }

  ///returns a list containing all playlist names
  Widget buildListTile(BuildContext context, int index) {
    return ListTile(
      title: Text(index < playlist.length ? playlist[index].name : "Keine Musik"),
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
                  Text("Playlist: ${index < playlist.length ? playlist[index].name : 'Keine Musik'} ", style: Theme.of(context).textTheme.display4),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromRGBO(200, 0, 0, 1),
                    disabledColor: Color.fromRGBO(200, 0, 0, 1),
                    child: Text("Auswählen",  style: Theme.of(context).textTheme.display1),
                    onPressed: (){
                      widget.workoutInformation.addTechniques(new List());
                      loadSongs(index);
                    },
                  ),
                ],
              ),
            )
        );
      },
    );
  }

  ///saves all playlist in a list
  void getPlaylist() async {
    List <PlaylistInfo> l = await audioQuery.getPlaylists();
    setState(() {
      playlist = l;
    });
  }

  ///saves all songs paths from a playlist
  Future loadSongs(int index) async {
    List<SongInfo> songs;
    if (index >= playlist.length){
      songs = new List();
    } else {
      songs = await audioQuery.getSongsFromPlaylist(playlist: playlist[index]);
    }

    print("load: ${songs.length}");
      widget.workoutInformation.setPlaylist(songs);
      print("set: ${songs.length}");
    Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => ChooseWorkoutSummaryScreen(widget.workoutInformation)),
    );
  }
}
