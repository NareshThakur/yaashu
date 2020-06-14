import './bloc_setting.dart';
// import '../customer_list.dart';

class MainBloc extends BloCSetting {
  
  List practiceArea = new List();
  List degree = new List();
  List certificate = new List();
  
  

  setPracticeArea(state, area ){
    rebuildWidgets(
      setStates: (){},
      states: [state]
    );
    practiceArea.add(area);
  }

  unsetPracticeArea(state, area ){
    rebuildWidgets(
      setStates: (){},
      states: [state]
    );
    practiceArea.removeWhere((element){
      if(element == area) return true;
      return false;
    });
  }

  setDegree(state, index, data ){
    rebuildWidgets(
      setStates: (){},
      states: [state]
    );
    degree.add({ 'index': index, 'degree': data });
  }

  unsetDegree(state, index ){
    rebuildWidgets(
      setStates: (){},
      states: [state]
    );
    degree.removeWhere((element){
      if(element['index'] == index) return true;
      return false;
    });
  }

  setCertificate(state, index, data ){
    rebuildWidgets(
      setStates: (){},
      states: [state]
    );
    certificate.add({ 'index': index, 'certificate': data });
  }

  unsetCertificate(state, index ){
    rebuildWidgets(
      setStates: (){},
      states: [state]
    );
    certificate.removeWhere((element){
      if(element['index'] == index) return true;
      return false;
    });
  }
  

}
MainBloc mainBloc; 

