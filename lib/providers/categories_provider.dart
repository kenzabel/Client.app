import 'package:flutter/cupertino.dart';
import 'package:interface_connection/datafiles/categories_list.dart';

class CategoriesProvider extends ChangeNotifier {
  bool isLoading = false;

  bool get getIsLoading => isLoading;

  void updateIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void updateCheckBoxValue(int index, value) {
    categories[index].isChecked = value;
    notifyListeners();
  }
}
