enum Stage
{
  ///Page de selection des modules
  module,
  ///Page de list des élèves
  eleves,
  ///Page de détails d'un élève
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