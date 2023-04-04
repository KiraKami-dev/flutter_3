import 'package:flutter/material.dart';
import 'package:grocery_app/models/wishlist_model.dart';

import '../models/view_model.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedModel> _viewedProdlistItems = {};

  Map<String, ViewedModel> get getViewedProdlistItems {
    return _viewedProdlistItems;
  }

  void addProductToViewed({required String productId}) {
    _viewedProdlistItems.putIfAbsent(
      productId,
      () => ViewedModel(
        id: DateTime.now().toString(),
        productId: productId,
      ),
    );
    notifyListeners();
  }
  void clearHistory() {
    _viewedProdlistItems.clear();
    notifyListeners();
  }
}
