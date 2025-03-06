import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

extension LoadingStateProviderExtension on BuildContext {
  setLoadingState({required bool isLoading}) =>
      Provider.of<LoadingStateProvider>(
        this,
        listen: false,
      ).setLoadingState(isLoading: isLoading);
  isLoading() =>
      Provider.of<LoadingStateProvider>(this, listen: false).isLoading;
}
