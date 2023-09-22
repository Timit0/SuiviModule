enum Stage
{
  module,
  eleves,
  eleveDetail
}

class StageScreen{
  Stage _stageScreen = Stage.module;

  static final instance = StageScreen._();

  StageScreen._(){}

  void setStageScreen(Stage newStage){
    _stageScreen = newStage;
  }

  Stage getStageScreen(){
    return _stageScreen;
  }
}