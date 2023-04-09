import 'package:news/Core/API/api_manager.dart';
import 'package:news/Core/API/models/news.dart';
import 'package:news/View/news/navigator.dart';
import 'package:news/base/base_view_model.dart';

class NewsListViewModel extends BaseViewModel<NewsListNavigator>{
  String? errorMessage;
  List<News>? newsList;

  void getNewsBySourceId(String sourceId)async{
    //re-initialize to return loading state
    errorMessage = null;
    newsList = [];
    notifyListeners();
    try {
      var response = await APIManager.getNews(sourceId: sourceId);
      if(response.status == 'error'){
        errorMessage = response.message;
      }else{
        newsList = response.newsList;
      }
    }catch (e) {
      errorMessage = 'error loading news';
    }
    notifyListeners();
  }
}