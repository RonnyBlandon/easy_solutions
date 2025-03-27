import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Address/address_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/error_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/text_form_fields/custom_text_form_field.dart';
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
import 'package:flutter/material.dart';

class AddEditAddressPage extends StatefulWidget {
  AddressEntity? deliveryAddressEntity;
  final bool? isEditing;
  BaseViewStateDelegate? viewStateDelegate;

  AddEditAddressPage({
    super.key,
    required this.isEditing,
    required this.viewStateDelegate,
    required this.deliveryAddressEntity,
  });

  @override
  State<AddEditAddressPage> createState() => _AddEditAddressPageState();
}

class _AddEditAddressPageState extends State<AddEditAddressPage>
    with TextFormFieldDelegate, BaseView {
  String _actionText = "";
  Decoration? _sectorDecoration = defaultTextFieldDecoration;
  Decoration? _addressDecoration = defaultTextFieldDecoration;
  Decoration? _referenceDecoration = defaultTextFieldDecoration;
  Decoration? _aliasDecoration = defaultTextFieldDecoration;

  @override
  Widget build(BuildContext context) {
    // Si vamos a crear una nueva dirección tenemos que prepara la view
    _prepareView();

    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(text: "Agregar Dirección", fontsize: 18.0),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              _editAddDeliveryAddress(context);
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
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              Container(
                decoration: getBoxDecorationWithShadows(),
                width: getScreenWidth(context: context),
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "SECTOR",
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: Colonia, Barrio o Residencial',
                      textFormFieldType: CustomTextFormFieldType.sector,
                      decoration: _sectorDecoration,
                      initialValue: widget.deliveryAddressEntity?.sector,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "DIRECCIÓN",
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: Calle principal, segunda cuadra',
                      textFormFieldType: CustomTextFormFieldType.address,
                      decoration: _addressDecoration,
                      initialValue: widget.deliveryAddressEntity?.address,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "REFERENCIA",
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: a la par de la iglesia, casa azul',
                      textFormFieldType: CustomTextFormFieldType.reference,
                      decoration: _referenceDecoration,
                      initialValue: widget.deliveryAddressEntity?.reference,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "ALIAS",
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: Casa, Trabajo',
                      textFormFieldType: CustomTextFormFieldType.alias,
                      decoration: _aliasDecoration,
                      initialValue: widget.deliveryAddressEntity?.alias,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 140),
            ]),
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
    setState(() {
      switch (customTextFormFieldType) {
        case CustomTextFormFieldType.address:
          widget.deliveryAddressEntity?.address = newValue;
          break;
        case CustomTextFormFieldType.reference:
          widget.deliveryAddressEntity?.reference = newValue;
          break;
        case CustomTextFormFieldType.sector:
          widget.deliveryAddressEntity?.sector = newValue;
          break;
        case CustomTextFormFieldType.alias:
          widget.deliveryAddressEntity?.alias = newValue;
          break;
        default:
          break;
      }
      _validateForm();
    });
  }
}

extension _PrivateMethods on _AddEditAddressPageState {
  _validateForm() {
    // TODO: Hacer FE con Google Maps para geolocation
    widget.deliveryAddressEntity?.latitude = 41.3914113;
    widget.deliveryAddressEntity?.longitude = 2.194717;

    if (!_isValidDeliveryAddress()) {
      _actionText = "";
    } else {
      _actionText = "Guardar";
    }
    _setTextFieldsDecorations();
  }

  _setTextFieldsDecorations() {
    if (widget.deliveryAddressEntity?.sector.isEmpty ?? true) {
      _sectorDecoration = errorTextFieldDecoration;
    } else {
      _sectorDecoration = defaultTextFieldDecoration;
    }
    if (widget.deliveryAddressEntity?.address.isEmpty ?? true) {
      _addressDecoration = errorTextFieldDecoration;
    } else {
      _addressDecoration = defaultTextFieldDecoration;
    }
    if (widget.deliveryAddressEntity?.reference.isEmpty ?? true) {
      _referenceDecoration = errorTextFieldDecoration;
    } else {
      _referenceDecoration = defaultTextFieldDecoration;
    }
    if (widget.deliveryAddressEntity?.alias.isEmpty ?? true) {
      _aliasDecoration = errorTextFieldDecoration;
    } else {
      _aliasDecoration = defaultTextFieldDecoration;
    }
  }

  bool _isEditing() {
    return widget.isEditing ?? false;
  }

  bool _isValidDeliveryAddress() {
    return widget.deliveryAddressEntity?.isValidAddress() ?? false;
  }

  _prepareView() {
    viewStateDelegate = widget.viewStateDelegate;
    if (!_isEditing() && widget.deliveryAddressEntity == null) {
      widget.deliveryAddressEntity = AddressEntity.getEmptyAddress();
    }
  }

  _pop(BuildContext context) {
    viewStateDelegate?.onChange();
    Navigator.pop(context);
  }
}

extension _UserActions on _AddEditAddressPageState {
  _editAddDeliveryAddress(BuildContext context) {
    setState(() {
      (context).setLoadingState(isLoading: true);
    });

    if (_isEditing()) {
      // Aquí editamos la dirección de entrega
      _editDeliveryAddress();
    } else {
      // Aquí creamos la dirección de entrega
      _addDeliveryAddress();
    }
  }

  _editDeliveryAddress() {
    // Null Check
    if (widget.deliveryAddressEntity == null) {
      return;
    }

    (context)
        .editDeliveryAddress(
          deliveryAddressEntity: widget.deliveryAddressEntity!,
        )
        .then(
          (_) {
            setState(() {
              (context).setLoadingState(isLoading: false);
            });
            _pop(context);
            Navigator.pop(context);
          },
          onError: (_) {
            (context).showErrorAlert(
              message: AppFailureMessages.unExpectedErrorMessage,
              context: context,
            );
          },
        );
  }

  _addDeliveryAddress() {
    // Null Check
    if (widget.deliveryAddressEntity == null) {
      return;
    }

    (context)
        .addDeliveryAddress(
          deliveryAddressEntity: widget.deliveryAddressEntity!,
        )
        .then(
          (_) {
            setState(() {
              (context).setLoadingState(isLoading: false);
            });
            _pop(context);
          },
          onError: (_) {
            (context).showErrorAlert(
              message: AppFailureMessages.unExpectedErrorMessage,
              context: context,
            );
          },
        );
  }
}
