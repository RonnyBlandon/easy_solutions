import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Address/address_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/alerts/AlertView/View/alert_dialog.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:flutter/material.dart';
//Helpers
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
//Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';

class AddressTabContentView extends StatefulWidget {
  final List<AddressEntity> deliveryAddressList;
  final BaseViewStateDelegate? delegate;
  const AddressTabContentView({
    super.key,
    required this.deliveryAddressList,
    required this.delegate,
  });

  @override
  State<AddressTabContentView> createState() => _AddressTabContentViewState();
}

class _AddressTabContentViewState extends State<AddressTabContentView>
    with BaseView {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.deliveryAddressList.length,
            itemBuilder: (BuildContext context, index) {
              final deliveryAddress = widget.deliveryAddressList[index];
              return _deliveryAddressContainer(
                context,
                deliveryAddress: deliveryAddress,
              );
            },
          ),
        ),
      ],
    );
  }

  _pop(BuildContext context) {
    widget.delegate?.onChange();
    Navigator.pop(context);
  }

  Widget _deliveryAddressContainer(
    BuildContext context, {
    required AddressEntity deliveryAddress,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration:
          deliveryAddress.isMainAddress
              ? createBoxDecorationWithShadows(containerColor: Colors.green)
              : createBoxDecorationWithShadows(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerText(
            text: deliveryAddress.alias,
            color: deliveryAddress.isMainAddress ? Colors.white : Colors.black,
            fontsize: 16.0,
            fontWeight: FontWeight.w500,
            textAling: TextAlign.start,
          ),
          Row(
            children: [
              if (deliveryAddress.isMainAddress)
                const Icon(Icons.check, color: Colors.white),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  "${deliveryAddress.sector}, ${deliveryAddress.address} ${deliveryAddress.reference}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color:
                        deliveryAddress.isMainAddress
                            ? Colors.white
                            : Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder:
                        (context) => _buildBottomSheetContent(
                          context,
                          deliveryAddress: deliveryAddress,
                        ),
                  );
                },
                icon: Icon(
                  Icons.more_vert,
                  color:
                      deliveryAddress.isMainAddress
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetContent(
    BuildContext context, {
    required AddressEntity deliveryAddress,
  }) {
    return Container(
      height: getScreenHeight(context: context, multiplier: 0.3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: headerText(
                    text:
                        "${deliveryAddress.sector}, ${deliveryAddress.address} ${deliveryAddress.reference}",
                    color: Colors.black,
                    fontsize: 18.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (!deliveryAddress.isMainAddress)
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Usar como direción predeterminada.'),
              onTap: () {
                _selectMainDeliveryAddress(deliveryAddress);
              },
            ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Editar dirección'),
            onTap: () {
              coordinator.showAddEditAddressPage(
                context: context,
                isForEditing: true,
                deliveryAddress: deliveryAddress,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Eliminar dirección'),
            onTap: () {
              _showAlertDeleteDeliveryAddress(context, deliveryAddress);
            },
          ),
        ],
      ),
    );
  }
}

extension _UserActions on _AddressTabContentViewState {
  _selectMainDeliveryAddress(AddressEntity addressEntity) {
    (context)
        .selectMainDeliveryAddress(deliveryAddressEntity: addressEntity)
        .then((_) => _pop(context));
  }

  _deleteDeliveryAddress(BuildContext context, AddressEntity addressEntity) {
    (context).deleteDeliveryAddress(deliveryAddressId: addressEntity.id).then((
      _,
    ) {
      _pop(context);
      Navigator.pop(context);
    });
  }

  _showAlertDeleteDeliveryAddress(
    BuildContext context,
    AddressEntity addressEntity,
  ) {
    AlertView.showAlertDialog(
      context: context,
      headerTitle: "¿Quierés eliminar esta dirección?",
      headerSubTitle: "",
      labelButton: "Eliminar dirección",
      backgroundColorButton: Colors.red,
      isDismissible: true,
      cancelText: "Cancelar",
      cancelAction: () => AlertView.closeAlertDialog(context),
      doneButtonFunc: () {
        _deleteDeliveryAddress(context, addressEntity);
      },
    );
  }
}
