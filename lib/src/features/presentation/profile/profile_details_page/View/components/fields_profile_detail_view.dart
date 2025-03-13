import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/text_form_fields/custom_text_form_field.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:flutter/services.dart';

mixin FieldsProfileDetailViewDelegate {
  userDataChanged({required UserEntity? newUser});
}

// Cambiar a StatefulWidget para mantener el estado
class FieldsProfileDetailView extends StatefulWidget {
  final UserEntity? userData;
  final FieldsProfileDetailViewDelegate? delegate;

  const FieldsProfileDetailView({
    super.key,
    required this.delegate,
    required this.userData,
  });

  @override
  _FieldsProfileDetailViewState createState() =>
      _FieldsProfileDetailViewState();
}

// Estado asociado para manejar _tempUserData
class _FieldsProfileDetailViewState extends State<FieldsProfileDetailView>
    with TextFormFieldDelegate, BaseView {
  Decoration? _decoration;
  late UserEntity? _tempUserData; // Mantener el estado del usuario temporal

  @override
  void initState() {
    super.initState();
    // Inicializa _tempUserData una sola vez en initState
    _tempUserData = widget.userData;
  }

  @override
  Widget build(BuildContext context) {
    _decoration = const BoxDecoration(
      border: Border(bottom: BorderSide(color: grey)),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          CustomTextFormField(
            textFormFieldType: CustomTextFormFieldType.username,
            hintext: "Nombre Completo",
            delegate: this,
            decoration: _decoration,
            initialValue: _tempUserData?.fullName,
            icon: const Icon(Icons.person_outline, color: orange),
          ),
          CustomTextFormField(
            textFormFieldType: CustomTextFormFieldType.phone,
            hintext: "Teléfono",
            delegate: this,
            decoration: _decoration,
            initialValue: _tempUserData?.phone,
            icon: const Icon(Icons.phone_iphone_outlined, color: orange),
          ),
          const SizedBox(height: 10.0),
          ListTile(
            leading: Icon(Icons.lock_outline, color: orange),
            title: Text(
              'Cambiar la contraseña',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: grey),
            onTap: () => coordinator.showEditPasswordPage(context: context),
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
    if (_tempUserData != null) {
      setState(() {
        // Actualiza los campos según el tipo recibido
        _tempUserData = _tempUserData!.copyWith(
          fullName:
              customTextFormFieldType == CustomTextFormFieldType.username
                  ? newValue
                  : _tempUserData!.fullName,
          phone:
              customTextFormFieldType == CustomTextFormFieldType.phone
                  ? newValue
                  : _tempUserData!.phone,
        );
        // Notifica los cambios acumulados al delegate
        widget.delegate?.userDataChanged(newUser: _tempUserData);
      });
    }
  }
}
