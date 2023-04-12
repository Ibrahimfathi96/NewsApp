import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Core/API/api_manager.dart';
import 'package:news/Core/API/models/Sources.dart';

class CategoryViewModel extends Cubit<CategoryInitialState>{
  CategoryViewModel():super(LoadingState());

  void loadSources(String categoryID) async{
    try {
      var response =  await APIManager.getSources(categoryID);
      if(response.status == 'error'){
        emit(ErrorState(response.message!));
      }else{
        emit(SourcesLoadedState(response.sources!));
        // emit(NavigateToScreenAction(HomePage.routeName));//testing
      }
    } catch (e) {
      emit(ErrorState('error loading news sources'));
    }
  }

}
abstract class CategoryInitialState{}
class LoadingState extends CategoryInitialState{

}
class ErrorState extends CategoryInitialState{
  String errorMessage;

  ErrorState(this.errorMessage);
}
class SourcesLoadedState extends CategoryInitialState{
  List<Source> sources;

  SourcesLoadedState(this.sources);
}
class MessageAction extends CategoryInitialState{
  String message;

  MessageAction(this.message);
}
class NavigateToScreenAction extends CategoryInitialState{
  String routeName;

  NavigateToScreenAction(this.routeName);
}

