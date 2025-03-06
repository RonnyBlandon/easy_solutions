import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/base/Views/loading_view.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/business_list_page/View/Components/business_list_content_view.dart';
import 'package:easy_solutions/src/features/presentation/business_list_page/ViewModel/business_list_view_model.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:easy_solutions/src/services/GeolocationService/Service/geolocation_service.dart';
import 'package:flutter/material.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/menus/main_app_bar.dart';

class BusinessListPage extends StatefulWidget with BaseView {
  final int typeBusinessId;
  BusinessListPage({super.key, required this.typeBusinessId});

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  final BusinessListViewModel viewModel;
  _BusinessListPageState({BusinessListViewModel? restaurantListViewModel})
      : viewModel = restaurantListViewModel ?? DefaultBusinessListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MainAppBar(actions: [
            IconButton(
                onPressed: () {
                  widget.coordinator.showTabsPage(context: context);
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
            future:
                viewModel.viewInitState(typeBusinessId: widget.typeBusinessId),
            builder: (BuildContext context,
                AsyncSnapshot<BusinessListViewModelState> snapshot) {
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
                    case BusinessListViewModelState.viewLoadedState:
                      return BusinessListContentView(viewModel: viewModel);
                    default:
                    print("Esto tiene snapshot.error en buisness_list_page: ${snapshot.error}");
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
