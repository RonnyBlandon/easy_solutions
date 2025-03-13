import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/error_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
// Components
import 'package:easy_solutions/src/features/presentation/profile/profile_details_page/View/components/avatar_profile_view.dart';
import 'package:easy_solutions/src/features/presentation/profile/profile_details_page/View/components/fields_profile_detail_view.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';
//Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage>
    with FieldsProfileDetailViewDelegate, BaseView {
  String _actionText = "";
  late DefaultUserStateProvider _defaultUserStateProvider;
  UserEntity? newUser;
  final _formKey = GlobalKey<FormState>(); // Clave para el formulario

  @override
  Widget build(BuildContext context) {
    _defaultUserStateProvider = (context).getDefaultUserStateProvider();

    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(text: 'Perfil', fontsize: 18.0),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Validar formulario antes de guardar
                updateUserData();
              }
            },
            child: Container(
              padding: const EdgeInsets.only(right: 15.0),
              child: headerText(
                text: _actionText,
                color: orange,
                fontsize: 17.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        // Envolver en Form para validaciones
        key: _formKey,
        child:
            (context).isLoading()
                ? loadingView
                : CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          width: screenWidth.getScreenWidth(context: context),
                          height: screenHeight.getScreenHeight(
                            context: context,
                            multiplier: 0.48,
                          ),
                          margin: EdgeInsets.only(
                            top: screenHeight.getScreenHeight(
                              context: context,
                              multiplier: 0.1,
                            ),
                            left: 15.0,
                            right: 15.0,
                          ),
                          decoration: createBoxDecorationWithShadows(),
                          child: Column(
                            children: [
                              Transform.translate(
                                offset: const Offset(0.0, -60.0),
                                child: const AvatarProfileView(),
                              ),
                              FieldsProfileDetailView(
                                delegate: this,
                                userData: _defaultUserStateProvider.userData,
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
      ),
    );
  }

  updateUserData() {
    if (newUser == null) {
      return;
    }

    setState(() {
      (context).setLoadingState(isLoading: true);
    });

    _defaultUserStateProvider
        .updateUserData(user: newUser!)
        .then(
          (result) {
            setState(() {
              (context).setLoadingState(isLoading: false);
              _actionText = "";
            });
          },
          onError: (e) {
            setState(() {
              (context).setLoadingState(isLoading: false);
              (context).showErrorAlert(
                context: context,
                message: AppFailureMessages.unExpectedErrorMessage,
              );
            });
          },
        );
  }

  @override
  userDataChanged({required UserEntity? newUser}) {
    setState(() {
      if (newUser?.fullName?.isNotEmpty ?? false) {
        this.newUser = newUser;
        _actionText = "Guardar";
      } else {
        _actionText = "";
      }
    });
  }
}
