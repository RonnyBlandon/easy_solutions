import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/error_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/expiry_date_selector/expiry_date_selector_view.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/text_form_fields/custom_text_form_field.dart';
import 'package:easy_solutions/src/utils/Helpers/Checkout/checkout_helper.dart';
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
import 'package:flutter/material.dart';
import 'package:easy_solutions/src/features/Domain/Entities/PaymentMethods/payment_methods_entity.dart';
import 'package:flutter/services.dart';

class AddEditCardPage extends StatefulWidget {
  final bool? isEditing;
  PaymentMethodEntity? paymentMethod;
  BaseViewStateDelegate? viewStateDelegate;

  AddEditCardPage({
    super.key,
    this.isEditing,
    this.paymentMethod,
    this.viewStateDelegate,
  });

  @override
  State<AddEditCardPage> createState() => _AddEditCardPageState();
}

class _AddEditCardPageState extends State<AddEditCardPage>
    with TextFormFieldDelegate, ExpiryDateSelectorDelegate, BaseView {
  String _actionText = "";
  Decoration? _cardNameDecoration = defaultTextFieldDecoration;
  Decoration? _cardNumberDecoration = defaultTextFieldDecoration;
  Decoration? _cardMonthAndYearDecoration = defaultTextFieldDecoration;
  Decoration? _cardCvcDecoration = defaultTextFieldDecoration;
  Decoration? _cardAliasDecoration = defaultTextFieldDecoration;

  final AddEditCardTextEditingControllers _controllers =
      AddEditCardTextEditingControllers();

  @override
  Widget build(BuildContext context) {
    // Si vamos a crear un nuevo método de pago, la property payment method no puede ser nula 😉
    _prepareView();

    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(
          text: _isEditing() ? "Edit Card" : "Add Card",
          fontsize: 18.0,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              _editAddCard(context);
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
                      "NOMBRE EN LA TARJETA",
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomTextFormField(
                      delegate: this,
                      hintext: 'Nombre en la tarjeta',
                      textFormFieldType: CustomTextFormFieldType.nameInTheCard,
                      decoration: _cardNameDecoration,
                      initialValue: widget.paymentMethod?.nameInTheCard ?? "",
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "NÚMERO DE TARJETA",
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomTextFormField(
                      delegate: this,
                      hintext: 'Número de tarjeta',
                      textFormFieldType: CustomTextFormFieldType.cardNumber,
                      decoration: _cardNumberDecoration,
                      initialValue: widget.paymentMethod?.cardNumber,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        CardNumberInputFormatter(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "FECHA DE VENCIMIENTO",
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showExpiryDateSelectorView(),
                      child: AbsorbPointer(
                        child: CustomTextFormField(
                          delegate: this,
                          hintext: 'MM/YY',
                          textFormFieldType:
                              CustomTextFormFieldType.monthAndYearInCard,
                          decoration: _cardMonthAndYearDecoration,
                          controller: _controllers.monthAndYearController,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "CVC",
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomTextFormField(
                      delegate: this,
                      hintext: 'CVC',
                      textFormFieldType: CustomTextFormFieldType.cvc,
                      decoration: _cardCvcDecoration,
                      initialValue: widget.paymentMethod?.cvc ?? "",
                      inputFormatters: [LengthLimitingTextInputFormatter(4)],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "ALIAS PARA ESTA TARJETA",
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomTextFormField(
                      delegate: this,
                      hintext: 'Alias para esta tarjeta',
                      textFormFieldType: CustomTextFormFieldType.alias,
                      decoration: _cardAliasDecoration,
                      initialValue: widget.paymentMethod?.cardAlias ?? "",
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  onChanged({
    required String newValue,
    required CustomTextFormFieldType customTextFormFieldType,
  }) {
    setState(() {
      switch (customTextFormFieldType) {
        case CustomTextFormFieldType.nameInTheCard:
          widget.paymentMethod?.nameInTheCard = newValue;
          break;
        case CustomTextFormFieldType.cardNumber:
          widget.paymentMethod?.cardNumber = newValue;
          break;
        case CustomTextFormFieldType.cvc:
          widget.paymentMethod?.cvc = newValue;
          break;
        case CustomTextFormFieldType.alias:
          widget.paymentMethod?.cardAlias = newValue;
          break;
        default:
          break;
      }
      _validateForm();
    });
  }

  @override
  void onExpiryDateSelected(String expiryDate) {
    setState(() {
      widget.paymentMethod?.monthAndYear = expiryDate;
      _controllers.monthAndYearController.text = expiryDate;
    });
    _validateForm();
  }

  _pop(BuildContext context) {
    viewStateDelegate?.onChange();
    Navigator.pop(context);
  }
}

extension _UserActions on _AddEditCardPageState {
  _editAddCard(BuildContext context) {
    setState(() {
      (context).setLoadingState(isLoading: true);
    });

    if (_isEditing()) {
      // Aquí editamos la tarjeta
      _editCard();
    } else {
      // Aquí creamos la tarjeta
      _addCard();
    }
  }

  _editCard() {
    // Null Check
    if (widget.paymentMethod == null) {
      return;
    }
    (context)
        .editPaymentMethod(paymentMethod: widget.paymentMethod!)
        .then(
          (_) {
            setState(() {
              (context).setLoadingState(isLoading: false);
            });
            _pop(context);
            Navigator.pop(context);
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

  _addCard() {
    // Null Check
    if (widget.paymentMethod == null) {
      return;
    }

    (context)
        .addPaymentMethod(paymentMethod: widget.paymentMethod!)
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

  void _showExpiryDateSelectorView() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.25,
          child: ExpiryDateSelectorView(delegate: this),
        );
      },
    );
  }
}

extension _PrivateMethods on _AddEditCardPageState {
  _validateForm() {
    if ((widget.paymentMethod?.nameInTheCard.isEmpty ?? true) ||
        (widget.paymentMethod?.cardNumber.isEmpty ?? true) ||
        (widget.paymentMethod?.monthAndYear.isEmpty ?? true) ||
        (widget.paymentMethod?.cvc.isEmpty ?? true) ||
        (widget.paymentMethod?.cardAlias.isEmpty ?? true) ||
        !CheckoutHelper.isValidCardName(
          widget.paymentMethod?.nameInTheCard ?? "",
        ) ||
        !CheckoutHelper.isValidCardNumber(
          widget.paymentMethod?.cardNumber ?? "",
        ) ||
        !CheckoutHelper.isValidCvc(widget.paymentMethod?.cvc ?? "") ||
        !CheckoutHelper.isValidCardAlias(
          widget.paymentMethod?.cardAlias ?? "",
        )) {
      // No es un formulario válido
      _actionText = "";
    } else {
      // Es un formulario válido
      widget.paymentMethod?.cardNumber =
          CheckoutHelper.validateAndFormatCardNumber(
            widget.paymentMethod?.cardNumber ?? "",
          ).$2;
      _actionText = "Guardar";
    }
    _setTextFieldsDecorations();
  }

  _setTextFieldsDecorations() {
    if (!CheckoutHelper.isValidCardName(
      widget.paymentMethod?.nameInTheCard ?? "",
    )) {
      _cardNameDecoration = errorTextFieldDecoration;
    } else {
      _cardNameDecoration = defaultTextFieldDecoration;
    }

    if (!CheckoutHelper.isValidCardNumber(
      widget.paymentMethod?.cardNumber ?? "",
    )) {
      _cardNumberDecoration = errorTextFieldDecoration;
    } else {
      _cardNumberDecoration = defaultTextFieldDecoration;
    }

    if (widget.paymentMethod?.monthAndYear.isEmpty ?? true) {
      _cardMonthAndYearDecoration = errorTextFieldDecoration;
    } else {
      _cardMonthAndYearDecoration = defaultTextFieldDecoration;
    }

    if (!CheckoutHelper.isValidCvc(widget.paymentMethod?.cvc ?? "")) {
      _cardCvcDecoration = errorTextFieldDecoration;
    } else {
      _cardCvcDecoration = defaultTextFieldDecoration;
    }

    if (!CheckoutHelper.isValidCardName(
      widget.paymentMethod?.cardAlias ?? "",
    )) {
      _cardAliasDecoration = errorTextFieldDecoration;
    } else {
      _cardAliasDecoration = defaultTextFieldDecoration;
    }
  }

  bool _isEditing() {
    return widget.isEditing ?? false;
  }

  _prepareView() {
    viewStateDelegate = widget.viewStateDelegate;
    if (!_isEditing() && widget.paymentMethod == null) {
      widget.paymentMethod = PaymentMethodEntity.getEmptyPaymentMethod();
    } else {
      _setInitialValuesToControllers();
    }
  }

  _setInitialValuesToControllers() {
    if (widget.paymentMethod?.monthAndYear == null) {
      return;
    }

    _controllers.monthAndYearController.text =
        widget.paymentMethod!.monthAndYear;
  }
}

class AddEditCardTextEditingControllers {
  final TextEditingController monthAndYearController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
}
