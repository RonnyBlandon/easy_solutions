import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
//Components
import 'package:easy_solutions/src/features/presentation/tabs/addresses_tab/View/components/empty_address_state.dart';
//Helpers
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
//Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';

class AddressesTab extends StatefulWidget {
  const AddressesTab({super.key});

  @override
  State<AddressesTab> createState() => _AddressesTabState();
}

class _AddressesTabState extends State<AddressesTab> {
  final bool emptyAddressState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        elevation: 0.1,
        leading: const Text(''),
        backgroundColor: white,
        title: headerText(text: 'Mis Direcciones', fontsize: 18.0),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'add_address');
            },
            child: Container(
              padding: const EdgeInsets.only(right: 15.0),
              child: headerText(
                text: 'Agregar',
                color: orange,
                fontsize: 17.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body:
          emptyAddressState
              ? const EmptyAddressState()
              : CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        width: getScreenWidth(context: context),
                        margin: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            _addressContainer(
                              context,
                              type: 'Casa',
                              address:
                                  'Col. Suyapa, Calle principal, a lado de bodega la fe casa color rosada.',
                              isSelected: true,
                            ),
                            _addressContainer(
                              context,
                              type: 'Trabajo',
                              address:
                                  'Col. Carmen Elena, tercer callejon, uñtima casa color verde.',
                              isSelected: false,
                            ),
                            _addressContainer(
                              context,
                              type: 'Otro',
                              address:
                                  'Col. El sauce, tercera calle, ultima casa color verde.',
                              isSelected: false,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
    );
  }
}

Widget _addressContainer(
  BuildContext context, {
  required String type,
  required String address,
  required bool isSelected,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    decoration:
        isSelected
            ? createBoxDecorationWithShadows(containerColor: Colors.green)
            : createBoxDecorationWithShadows(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText(
          text: type,
          color: isSelected ? Colors.white : Colors.black,
          fontsize: 16.0,
          fontWeight: FontWeight.w500,
          textAling: TextAlign.start,
        ),
        Row(
          children: [
            if (isSelected) const Icon(Icons.check, color: Colors.white),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
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
                        address: address,
                        isSelected: isSelected,
                      ),
                );
              },
              icon: Icon(
                Icons.more_vert,
                color: isSelected ? Colors.white : Colors.black,
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
  required String address,
  required bool isSelected,
}) {
  return Container(
    height: getScreenHeight(context: context, multiplier: 0.4),
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
                  text: address,
                  color: Colors.black,
                  fontsize: 18.0,
                ),
              ),
            ],
          ),
        ),
        if (!isSelected)
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Usar como direción predeterminada.'),
            onTap: () {},
          ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Editar'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Eliminar tarjeta'),
          onTap: () {
            _showModalConfirmDelete(context);
          },
        ),
      ],
    ),
  );
}

void _showModalConfirmDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '¿Quierés eliminar esta dirección?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Podés volver a agregarla en cualquier momento.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 15.0),
            createElevatedButton(
              onPressed: () {},
              labelButton: 'Eliminar dirección',
              backgroundColor: Colors.red,
            ),
            const SizedBox(height: 20.0),
            createElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              labelButton: 'Cancelar',
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
            ),
          ],
        ),
      );
    },
  );
}
