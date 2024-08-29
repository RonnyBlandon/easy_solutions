import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/SignUpUseCase/signup_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/SignUpUseCase/signup_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/local_storage_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/save_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/text_form_fields/custom_text_form_field.dart';
import 'package:easy_solutions/src/features/presentation/sign_up_page/Model/sign_up_model.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter/material.dart';

abstract class SignUpViewModelInput {
  late LoadingStateProvider loadingState;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late DateTime selectDate;
  SignUpModel? signUpModel = SignUpModel();

  void initState({required LoadingStateProvider loadingStateProvider});
  Future<Result<bool, Failure>> signUp();
  bool isFormValidate();
}

abstract class SignUpViewModel extends SignUpViewModelInput
    implements TextFormFieldDelegate {}

class DefaultSignUpViewModel extends SignUpViewModel {
  // Dependencias
  final SignUpUseCase _signUpUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  DefaultSignUpViewModel(
      {SignUpUseCase? signUpUseCase,
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _signUpUseCase = signUpUseCase ?? DefaultSignUpUseCase(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  @override
  void initState({required LoadingStateProvider loadingStateProvider}) {
    loadingState = loadingStateProvider;
    selectDate = DateTime.now();
  }

  @override
  bool isFormValidate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Future<Result<bool, Failure>> signUp() {
    loadingState.setLoadingState(isLoading: true);

    // Retornar el Future directamente
    return _signUpUseCase
        .execute(
            params: SignUpUseCaseParameters(
                username: signUpModel?.username ?? "",
                email: signUpModel?.email ?? "",
                phone: signUpModel?.phone ?? "",
                password: signUpModel?.password ?? "",
                repeatPassword: signUpModel?.repeatPassword ?? ""))
        .then((result) async {
      switch (result.status) {
        case ResultStatus.success:
          await _saveLocalStorageUseCase.execute(
              parameters: SaveLocalStorageParameters(
                  key: LocalStorageKeys.idToken,
                  value: result.value?.idToken ?? ""));
          loadingState.setLoadingState(isLoading: false);
          return Result.success(true);
        case ResultStatus.error:
          loadingState.setLoadingState(isLoading: false);
          return Result.failure(result.error);
      }
    });
  }

  @override
  onChanged(
      {required String newValue,
      required CustomTextFormFieldType customTextFormFieldType}) {
    switch (customTextFormFieldType) {
      case CustomTextFormFieldType.email:
        signUpModel?.email = newValue;
      case CustomTextFormFieldType.password:
        signUpModel?.password = newValue;
      case CustomTextFormFieldType.phone:
        signUpModel?.phone = newValue;
      case CustomTextFormFieldType.username:
        signUpModel?.username = newValue;
    }
  }
}
