import 'package:easy_solutions/src/base/Views/loading_view.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_list_page/View/Components/restaurant_list_content_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_list_page/ViewModel/restaurante_list_view_model.dart';
import 'package:easy_solutions/src/services/GeolocationService/Service/geolocation_service.dart';
import 'package:flutter/material.dart';

//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/menus/main_app_bar.dart';

class RestaurantListPage extends StatefulWidget {
  final int typeBusinessId;
  const RestaurantListPage({super.key, required this.typeBusinessId});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final RestaurantListViewModel viewModel;
  _RestaurantListPageState({RestaurantListViewModel? restaurantListViewModel})
      : viewModel = restaurantListViewModel ?? DefaultRestaurantListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MainAppBar(actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'shopping_cart');
                },
                icon: const Icon(
                  Icons.shopping_cart,
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'notifications');
                },
                icon: const Icon(
                  Icons.notifications,
                )),
          ])),
      body: Center(
          child: FutureBuilder(
              future: viewModel.viewInitState(
                  typeBusinessId: widget.typeBusinessId),
              builder: (BuildContext context,
                  AsyncSnapshot<RestaurantListViewModelState> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const LoadingView();
                  case ConnectionState.done:
                    if (snapshot.error ==
                            GeoLocationFailureMessages
                                .locationPermissionsDenied ||
                        snapshot.error ==
                            GeoLocationFailureMessages
                                .locationPermissionsDeniedForever) {
                      var errorView = ErrorView(
                        assetImagePath: "assets/images/location-google.png",
                        errorTitle: "Ubicación denegada",
                        errorSubTitle:
                            "Puedes pedir cualquier cosa, solo indica en qué dirección",
                        buttonText: "Establecer dirección de entrega",
                        onButtonPressed:
                            () {}, //TODO: Crear feature de añadir dirección de entrega
                      );
                      return errorView;
                    }
                    switch (snapshot.data) {
                      case RestaurantListViewModelState.viewLoadedState:
                        return RestaurantListContentView(viewModel: viewModel);
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
              })),
    );
  }
}
