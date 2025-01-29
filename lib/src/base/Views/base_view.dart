import 'package:easy_solutions/src/base/Views/loading_view.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/error_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:flutter/material.dart';

mixin BaseView {
  final Widget loadingView = const LoadingView();
  final MainCoordinator coordinator = MainCoordinator();
  final ErrorStateProvider errorStateProvider = ErrorStateProvider();
}

mixin BaseViewModel {
  late LoadingStateProvider loadingState;
  void initState({required LoadingStateProvider loadingStateProvider});
}
