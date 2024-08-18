import 'package:scoped_model/scoped_model.dart';

class NavigationModel extends Model {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
