import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/text_form_fields/custom_text_form_field.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';

mixin FieldsProfileDetailViewDelegate {
  userDataChanged({required UserEntity? newUser});
}

class FieldsProfileDetailView extends StatelessWidget
    with TextFormFieldDelegate, BaseView {
  Decoration? _decoration;
  final UserEntity? userData;
  final FieldsProfileDetailViewDelegate? delegate;

  FieldsProfileDetailView({
    super.key,
    required this.delegate,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    _decoration = const BoxDecoration(
      border: Border(bottom: BorderSide(color: grey)),
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          CustomTextFormField(
            textFormFieldType: CustomTextFormFieldType.username,
            hintext: "Nombre Completo",
            delegate: this,
            decoration: _decoration,
            initialValue: (context).getUserData()?.fullName,
            icon: Icon(Icons.person_outline, color: orange),
          ),
          CustomTextFormField(
            textFormFieldType: CustomTextFormFieldType.phone,
            hintext: "Teléfono",
            delegate: this,
            decoration: _decoration,
            initialValue: (context).getUserData()?.phone,
            icon: Icon(Icons.phone_iphone_outlined, color: orange),
          ),
          SizedBox(height: 10.0),
          ListTile(
            leading: const Icon(Icons.lock_outline, color: orange),
            title: const Text(
              'Cambiar la contraseña',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: grey),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  @override
  void onChanged({
    required String newValue,
    required CustomTextFormFieldType customTextFormFieldType,
  }) {
    switch (customTextFormFieldType) {
      case CustomTextFormFieldType.username:
        delegate?.userDataChanged(
          newUser: userData?.copyWith(
            fullName: newValue,
            phone: userData?.phone,
          ),
        );
        break;
      case CustomTextFormFieldType.phone:
        delegate?.userDataChanged(
          newUser: userData?.copyWith(
            fullName: userData?.fullName,
            phone: newValue,
          ),
        );
        break;
      default:
        break;
    }
  }
}
