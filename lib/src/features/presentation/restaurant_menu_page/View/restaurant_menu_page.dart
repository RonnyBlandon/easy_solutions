import 'package:easy_solutions/src/base/Views/loading_view.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_menu_page/View/Components/restaurant_menu_content_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_menu_page/ViewModel/restaurant_menu_view_model.dart';
import 'package:flutter/material.dart';

class RestaurantMenuPage extends StatelessWidget {
  final String businessId;
  final RestaurantMenuViewModel viewModel;
  RestaurantMenuPage(
      {super.key,
      required this.businessId,
      RestaurantMenuViewModel? restaurantMenuviewModel})
      : viewModel = restaurantMenuviewModel ?? DefaultRestaurantMenuViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder(
            future: viewModel.viewInitState(businessId: businessId),
            builder: (BuildContext context,
                AsyncSnapshot<RestaurantMenuViewModelState> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const LoadingView();
                case ConnectionState.done:
                  switch (snapshot.data) {
                    case RestaurantMenuViewModelState.viewLoadedState:
                      var variable = snapshot.data;
                      print(
                          "Esto tiene snapshot.data en restaurant_menu_page: $variable");
                      return RestaurantMenuContentView(viewModel: viewModel);
                    default:
                      var variable2 = snapshot.error;
                      print(
                          "Esto tiene snapshot.error en restaurant_menu_page: $variable2");
                      return ErrorView();
                  }
                default:
                  return const LoadingView();
              }
            }),
      ),
    );
  }
}
