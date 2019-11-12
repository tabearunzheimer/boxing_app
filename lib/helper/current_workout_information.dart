

class CurrentWorkoutInformation{

  int breakTime;
  int roundAmount;
  int roundLength;
  String type;
  List <String> techniques;

  CurrentWorkoutInformation(int bt, int ra, int rl){
    this.breakTime = bt;
    this.roundAmount = ra;
    this.roundLength = rl;
  }

  void addTechniques(List<String> l){
    this.techniques = l;
  }

  List<String> getTechniques(){
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
}