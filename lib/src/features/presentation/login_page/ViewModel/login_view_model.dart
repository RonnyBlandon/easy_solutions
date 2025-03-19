import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/SignInUseCase/signin_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/SignInUseCase/signin_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/local_storage_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/save_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/text_form_fields/custom_text_form_field.dart';
import 'package:easy_solutions/src/features/presentation/login_page/Model/login_model.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter/material.dart';

abstract class LoginViewModelInput {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginModel? loginModel = LoginModel(email: '', password: '');

  Future<Result<bool, Failure>> login({
    required String email,
    required String password,
  });
  bool isFormValidate();
}

abstract class LoginViewModel extends LoginViewModelInput
    with BaseViewModel
    implements TextFormFieldDelegate {}

class DefaultLoginViewModel extends LoginViewModel {
  // * Dependencias
  // * UseCases
  final SignInUseCase _signInUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  DefaultLoginViewModel({
    SignInUseCase? signInUseCase,
    SaveLocalStorageUseCase? saveLocalStorageUseCase,
  }) : _signInUseCase = signInUseCase ?? DefaultSignInUseCase(),
       _saveLocalStorageUseCase =
           saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  @override
  void initState({required LoadingStateProvider loadingStateProvider}) {
    loadingState = loadingStateProvider;
  }

  @override
  bool isFormValidate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Future<Result<bool, Failure>> login({
    required String email,
    required String password,
  }) {
    loadingState.setLoadingState(isLoading: true);

    return _signInUseCase
        .execute(
          params: SigninUseCaseParameters(email: email, password: password),
        )
        .then((result) {
          switch (result.status) {
            case ResultStatus.success:
              loadingState.setLoadingState(isLoading: false);
              _saveLocalStorageUseCase.execute(
                parameters: SaveLocalStorageParameters(
                  key: LocalStorageKeys.localId,
                  value: result.value?.localId ?? "",
                ),
              );
              _saveLocalStorageUseCase.execute(
                parameters: SaveLocalStorageParameters(
                  key: LocalStorageKeys.accessToken,
                  value: result.value?.accessToken ?? "",
                ),
              );
              _saveLocalStorageUseCase.execute(
                parameters: SaveLocalStorageParameters(
                  key: LocalStorageKeys.refreshToken,
                  value: result.value?.refreshToken ?? "",
                ),
              );

              return Result.success(true);
            case ResultStatus.error:
              loadingState.setLoadingState(isLoading: false);
              return Result.failure(result.error);
          }
        });
  }

  @override
  onChanged({
    required String newValue,
    required CustomTextFormFieldType customTextFormFieldType,
  }) {
    switch (customTextFormFieldType) {
      case CustomTextFormFieldType.email:
        loginModel?.email = newValue;
      case CustomTextFormFieldType.password:
        loginModel?.password = newValue;
      default:
        break;
    }
  }
}
