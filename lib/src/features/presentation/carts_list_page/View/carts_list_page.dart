import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/carts_list_page/View/Components/carts_list_content_view.dart';
import 'package:easy_solutions/src/features/presentation/carts_list_page/ViewModel/carts_list_view_model.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:flutter/material.dart';

class CartsListPage extends StatelessWidget with BaseView {
  final String userId;
  final CartsListViewModel viewModel;
  CartsListPage(
      {super.key, required this.userId, CartsListViewModel? cartsListViewModel})
      : viewModel = cartsListViewModel ?? DefaultCartsListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(
            text: 'Tus Carritos', color: Colors.black, fontsize: 18.0),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: viewModel.viewInitState(userId: userId),
          builder: (BuildContext context,
              AsyncSnapshot<CartsListViewModelState> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return loadingView;
              case ConnectionState.done:
                switch (snapshot.data) {
                  case CartsListViewModelState.viewLoadedState:
                    return CartsListContentView(viewModel: viewModel);
                  default:
                    return ErrorView(
                      onButtonPressed: () {
                        coordinator.showTabsPage(context: context);
                      },
                    );
                }
              default:
                return loadingView;
            }
          }),
    );
  }
}
