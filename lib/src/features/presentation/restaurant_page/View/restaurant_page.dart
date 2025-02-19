import 'package:easy_solutions/src/base/Views/loading_view.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_page/View/Components/restaurant_content_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_page/ViewModel/restaurant_view_model.dart';
import 'package:flutter/material.dart';

class RestaurantPage extends StatelessWidget {
  final String businessId;
  final RestaurantViewModel viewModel;
  RestaurantPage(
      {super.key,
      required this.businessId,
      RestaurantViewModel? restaurantMenuviewModel})
      : viewModel = restaurantMenuviewModel ?? DefaultRestaurantViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder(
            future: viewModel.viewInitState(businessId: businessId),
            builder: (BuildContext context,
                AsyncSnapshot<RestaurantViewModelState> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const LoadingView();
                case ConnectionState.done:
                  switch (snapshot.data) {
                    case RestaurantViewModelState.viewLoadedState:
                      return RestaurantContentView(viewModel: viewModel);
                    default:
                      return ErrorView(
                        onButtonPressed: () {
                          MainCoordinator().showTabsPage(context: context);
                        },
                      );
                  }
                default:
                  return const LoadingView();
              }
            }),
      ),
    );
  }
}
