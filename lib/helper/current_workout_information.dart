

import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'Technique.dart';

/// saves current workout informations like techniques and how long you want to train
class CurrentWorkoutInformation{

  int breakTimeMin;
  int breakTimeSec;
  int roundAmount;
  int roundLengthMin;
  int roundLengthSec;
  double kcal;
  String type;
  List <Technique> techniques;
  int rating;
  List<SongInfo> playlist;

  CurrentWorkoutInformation(int bt1, int bt2, int ra, int rl, int r2, String t){
    this.breakTimeMin = bt1;
    this.breakTimeSec = bt2;
    this.roundAmount = ra;
    this.roundLengthMin = rl;
    this.roundLengthSec = r2;
    this.type = t;
  }

  ///takes a list of techniques and saves them
  void addTechniques(List<Technique> l){
    this.techniques = l;
  }

  ///returns the current techniques
  List<Technique> getTechniques(){
    return this.techniques;
  }

  ///returns the minutes for one break time
  int getBreakTimeMin(){
    return this.breakTimeMin;
  }

  ///returns the seconds for one breaktime
  int getBreakTimeSec(){
    return this.breakTimeSec;
  }

  ///returns the amount of rounds you want to train
  int getRoundAmount(){
    return this.roundAmount;
  }

  ///returns the minutes you train for one round
  int getRoundLengthMin(){
    return this.roundLengthMin;
  }

  ///returns the seconds you train for one round
  int getRoundLengthSec(){
    return this.roundLengthSec;
  }

  ///returns either Reaktion, Runde or Offen for the different training types
  String getType(){
    return this.type;
  }

  ///returns all techniques as a String
  ///techniques are separated by ", "
  String getTechniquesAsString(){
    String erg = "";
    for (int i = 0; i < this.techniques.length; i++){
      erg += i == this.techniques.length-1 ? "${this.techniques[i].getName()}" : "${this.techniques[i].getName()}, "; //if this is the last technique don't add a ", "
    }
    return erg;
  }

  ///saves a list of paths to songs of a playlist
  void setPlaylist(List<SongInfo> songs){
    this.playlist = songs;
  }

  ///returns a list of paths to different songs, combined in a playlist
  List<SongInfo> getPlaylist(){
    return this.playlist;
  }
}