

import 'Technique.dart';

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

  CurrentWorkoutInformation(int bt1, int bt2, int ra, int rl, int r2, String t){
    this.breakTimeMin = bt1;
    this.breakTimeSec = bt2;
    this.roundAmount = ra;
    this.roundLengthMin = rl;
    this.roundLengthSec = r2;
    this.type = t;
  }

  void addTechniques(List<Technique> l){
    this.techniques = l;
  }

  List<Technique> getTechniques(){
    return this.techniques;
  }

  int getBreakTimeMin(){
    return this.breakTimeMin;
  }

  int getBreakTimeSec(){
    return this.breakTimeSec;
  }

  int getRoundAmount(){
    return this.roundAmount;
  }

  int getRoundLengthMin(){
    return this.roundLengthMin;
  }

  int getRoundLengthSec(){
    return this.roundLengthSec;
  }

  String getType(){
    return this.type;
  }
}