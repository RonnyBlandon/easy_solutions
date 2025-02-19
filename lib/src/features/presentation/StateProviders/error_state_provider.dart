import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/alerts/error_alert_view.dart';
import 'package:flutter/material.dart';

abstract class ErrorStateProviderDelegate {
  void setFailure({required BuildContext context, required Failure value});
}

class ErrorStateProvider extends ChangeNotifier
    implements ErrorStateProviderDelegate {
  late Failure _failure;

  @override
  void setFailure({required BuildContext context, required Failure value}) {
    _failure = value;
    _showAlert(context: context, message: _failure.toString());
    notifyListeners();
  }

  void _showAlert({required BuildContext context, required String message}) {
    ErrorAlertView.showErrorAlertDialog(
        context: context,
        subtitle: message,
        ctaButtonAction: () {
          Navigator.pop(context);
        });
  }
}
