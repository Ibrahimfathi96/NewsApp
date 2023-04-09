import 'package:news/Core/API/api_manager.dart';
import 'package:news/Core/API/models/Sources.dart';
import 'package:news/View/category/category_navigator.dart';
import 'package:news/base/base_view_model.dart';

class CategoryNewsListViewModel
    extends BaseViewModel<CategoryNewsListNavigator> {
  List<Source>? sources;
  String? errorMessage ;

  void loadNewsSources(String categoryId) async {
    errorMessage = null;
    sources = [];
    notifyListeners();
    try {
      var response = await APIManager.getSources(categoryId);
      if (response.status == 'error') {
        errorMessage = response.message;
      } else {
        sources = response.sources!;
      }
    } catch (e) {
      errorMessage = "error getting news sources";
    }
    notifyListeners();
  }
}
