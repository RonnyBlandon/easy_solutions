import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Address/address_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:easy_solutions/src/features/presentation/tabs/addresses_tab/View/components/address_tab_content_view.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
//Components
import 'package:easy_solutions/src/features/presentation/tabs/addresses_tab/View/components/empty_address_state.dart';

class AddressesTab extends StatefulWidget {
  const AddressesTab({super.key});

  @override
  State<AddressesTab> createState() => _AddressesTabState();
}

class _AddressesTabState extends State<AddressesTab>
    with BaseView, BaseViewStateDelegate {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        elevation: 0.1,
        leading: Text(""),
        backgroundColor: white,
        title: headerText(text: 'Mis Direcciones', fontsize: 18.0),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              coordinator.showAddEditAddressPage(
                context: context,
                isForEditing: false,
              );
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
      body: FutureBuilder(
        future: (context).getDeliveryAddressList(),
        builder: (
          BuildContext context,
          AsyncSnapshot<AddressListEntity?> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingView;
            case ConnectionState.done:
              if (snapshot.hasData && snapshot.data != null) {
                return snapshot.data!.addressList.isNotEmpty
                    ? AddressTabContentView(
                      deliveryAddressList: snapshot.data!.addressList,
                      delegate: this,
                    )
                    : EmptyAddressState();
              } else {
                return ErrorView(
                  onButtonPressed: () {
                    coordinator.showTabsPage(context: context);
                  },
                );
              }
            default:
              return loadingView;
          }
        },
      ),
    );
  }

  @override
  void onChange() {
    print("+++++++++ onChange");
    setState(() {});
  }
}
