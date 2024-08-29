import 'package:flutter/material.dart';

abstract class LoadingStateProviderDelegate {
  bool isLoading = false;
  void setLoadingState({required bool isLoading});
}

class LoadingStateProvider extends ChangeNotifier
    implements LoadingStateProviderDelegate {
  @override
  bool isLoading = false;

  @override
  void setLoadingState({required bool isLoading}) {
    this.isLoading = isLoading;
    notifyListeners();
  }
}
