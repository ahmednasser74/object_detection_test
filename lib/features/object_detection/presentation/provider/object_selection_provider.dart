import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/index.dart';

@Injectable()
class ObjectSelectionProvider extends ChangeNotifier {
  final List<String> objectList = [];
  String _searchText = '';

  String get searchText => _searchText;

  void updateSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  Future<void> getLabelsList() async {
    final labels = await DetectionService.instance.getLabels();
    objectList.addAll(labels ?? []);
    notifyListeners();
  }
}
