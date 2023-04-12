import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Core/API/models/news.dart';

import '../../Core/API/api_manager.dart';

class NewsListViewModel extends Cubit<NewsListState>{
  NewsListViewModel():super(LoadingState());

  void loadNewsBySourceId(String sourceId)async{
    try{
      var response = await APIManager.getNews(sourceId: sourceId);
      if(response.status == 'error'){
        emit(ErrorState(response.message!));
      }else{
        emit(NewsLoadedState(response.newsList!));
      }
    }catch(ex){
      emit(ErrorState('Error loading news $ex'));

    }
  }
}
abstract class NewsListState{}
class LoadingState extends NewsListState{}
class NewsLoadedState extends NewsListState{
  List<News> newsList;

  NewsLoadedState(this.newsList);
}
class ErrorState extends NewsListState{
  String errorMessage;

  ErrorState(this.errorMessage);
}