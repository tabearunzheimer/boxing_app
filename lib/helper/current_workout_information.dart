

import 'Technique.dart';

class CurrentWorkoutInformation{

  int breakTime;
  int roundAmount;
  int roundLength;
  String type;
  List <Technique> techniques;

  CurrentWorkoutInformation(int bt, int ra, int rl, String t){
    this.breakTime = bt;
    this.roundAmount = ra;
    this.roundLength = rl;
    this.type = t;
  }

  void addTechniques(List<Technique> l){
    this.techniques = l;
  }

  List<Technique> getTechniques(){
    return this.techniques;
  }

  int getBreakTime(){
    return this.breakTime;
  }

  int getRoundAmount(){
    return this.roundAmount;
  }

  int getRoundLength(){
    return this.roundLength;
  }

  String getType(){
    return this.type;
  }
}