import 'package:easy_solutions/src/base/Views/loading_view.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/error_state_provider.dart';
import 'package:flutter/material.dart';

mixin BaseView {
  final Widget loadingView = const LoadingView();
  final ErrorStateProvider errorStateProvider = ErrorStateProvider();
}
