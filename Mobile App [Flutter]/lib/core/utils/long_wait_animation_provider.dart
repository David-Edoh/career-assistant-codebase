import 'package:flutter/material.dart';


class LongLoadingProvider with ChangeNotifier {
  bool loading = false;
  int loadingMilestone = 0;


  setLoading(bool value){
    loading = value;
    notifyListeners();
  }

  setLoadingMileStone(int value){
    loadingMilestone = value;
    notifyListeners();
  }
}