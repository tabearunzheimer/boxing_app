

import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'Technique.dart';

/// saves current workout informations like techniques and how long you want to train
class CurrentWorkoutInformation{

  int _breakTimeMin;
  int _breakTimeSec;
  int _roundAmount;
  int _roundLengthMin;
  int _roundLengthSec;
  double _kcal;
  String _type;
  List <Technique> _techniques;
  int _rating;
  List<SongInfo> _playlist;

  CurrentWorkoutInformation(int bt1, int bt2, int ra, int rl, int r2, String t){
    this._breakTimeMin = bt1;
    this._breakTimeSec = bt2;
    this._roundAmount = ra;
    this._roundLengthMin = rl;
    this._roundLengthSec = r2;
    this._type = t;
  }

  ///takes a list of techniques and saves them
  void addTechniques(List<Technique> l){
    this._techniques = l;
  }

  ///returns the current techniques
  List<Technique> getTechniques(){
    return this._techniques;
  }

  ///returns the minutes for one break time
  int getBreakTimeMin(){
    return this._breakTimeMin;
  }

  ///returns the seconds for one breaktime
  int getBreakTimeSec(){
    return this._breakTimeSec;
  }

  ///returns the amount of rounds you want to train
  int getRoundAmount(){
    return this._roundAmount;
  }

  ///returns the minutes you train for one round
  int getRoundLengthMin(){
    return this._roundLengthMin;
  }

  ///returns the seconds you train for one round
  int getRoundLengthSec(){
    return this._roundLengthSec;
  }

  ///returns either Reaktion, Runde or Offen for the different training types
  String getType(){
    return this._type;
  }

  ///returns the kcals
  double getKcal(){
    return this._kcal;
  }

  ///sets the kcals
  void setKcal(double k){
    this._kcal = k;
  }

  ///sets a new rating for a workout
  void setRating(int r){
    this._rating = r;
  }

  ///returns the current workout rating
  int getRating(){
    return this._rating;
  }


  ///returns all techniques as a String
  ///techniques are separated by ", "
  String getTechniquesAsString(){
    String erg = "";
    for (int i = 0; i < this._techniques.length; i++){
      erg += i == this._techniques.length-1 ? "${this._techniques[i].getName()}" : "${this._techniques[i].getName()}, "; //if this is the last technique don't add a ", "
    }
    return erg;
  }

  ///saves a list of paths to songs of a playlist
  void setPlaylist(List<SongInfo> songs){
    this._playlist = songs;
  }

  ///returns a list of paths to different songs, combined in a playlist
  List<SongInfo> getPlaylist(){
    return this._playlist;
  }
}