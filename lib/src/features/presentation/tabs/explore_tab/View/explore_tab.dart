import 'package:easy_solutions/src/base/Views/loading_view.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:easy_solutions/src/features/presentation/tabs/explore_tab/View/Components/explore_tab_content_view.dart';
import 'package:easy_solutions/src/features/presentation/tabs/explore_tab/ViewModel/explore_tab_view_model.dart';
import 'package:easy_solutions/src/services/GeolocationService/Service/geolocation_service.dart';
import 'package:flutter/material.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final ExploreTabViewModel viewModel;
  _ExploreTabState({ExploreTabViewModel? exploreTabViewModel})
      : viewModel = exploreTabViewModel ?? DefaultExploreTabViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
            future: viewModel.viewInitState(),
            builder: (BuildContext context,
                AsyncSnapshot<ExploreTabViewModelState> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const LoadingView();
                case ConnectionState.done:
                  //TODO: Gestionar error de geolocation con la feature de shipping addres
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
                    case ExploreTabViewModelState.viewLoadedState:
                      return ExploreTabContentView(viewModel: viewModel);
                    default:
                      var variable = snapshot.data;
                      print(
                          "Este contiene variables en snapshot.data en explore_tab: $variable");
                      return ErrorView(
                        onButtonPressed: () {
                          MainCoordinator().showTabsPage(context: context);
                        },
                      );
                  }
                default:
                  return const LoadingView();
              }
            }));
  }
}
