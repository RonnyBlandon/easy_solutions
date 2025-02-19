import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/tabs/TabsPage/ViewModel/tabs_page_view_model.dart';
import 'package:easy_solutions/src/services/GeolocationService/Entities/geolocation_service_entities.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter/material.dart';

//Tabs
import 'package:easy_solutions/src/features/presentation/tabs/explore_tab/View/explore_tab.dart';
import 'package:easy_solutions/src/features/presentation/tabs/favorites_tab/View/favorites_tab.dart';
import 'package:easy_solutions/src/features/presentation/tabs/orders_tab/View/orders_tab.dart';
import 'package:easy_solutions/src/features/presentation/tabs/addresses_tab/View/addresses_tab.dart';

//Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/menus/main_app_bar.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/menus/main_drawer.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/alerts/alert_dialog_with_image.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with BaseView {
  // Dependencies
  final TabsViewModel _viewModel;

  _TabsPageState({TabsViewModel? tabsViewModel})
      : _viewModel = tabsViewModel ?? DefaultTabsViewModel();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // Verifica si el widget sigue montado para que no se invalide el BuildContext
      if (!mounted) return;

      _viewModel.loadingState.setLoadingState(isLoading: true);
      final LocationPermissionStatus currentStatus =
          await _viewModel.getPermissionStatus();

      // Verifica nuevamente si el widget sigue montado
      if (!mounted) return;

      switch (currentStatus) {
        case LocationPermissionStatus.denied:
          _getCurrentPosition(context);
        default:
          _viewModel.loadingState.setLoadingState(isLoading: false);
      }
    });
  }

  final List<Widget> _widgetOptions = [
    const ExploreTab(),
    const OrdersTab(),
    const FavoritesTab(),
    const AddressesTab(),
  ];

  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    _viewModel.initState(
        loadingStateProvider: Provider.of<LoadingStateProvider>(context));

    return _viewModel.loadingState.isLoading
        ? loadingView
        : Scaffold(
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
            body: _widgetOptions.elementAt(_selectedItemIndex),
            drawer: MainDrawer(),
            bottomNavigationBar: _bottomNavigationBar(),
          );
  }
}

extension PrivateMethods on _TabsPageState {
  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        iconSize: 30.0,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: _selectedItemIndex,
        onTap: _changeTab,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Pedidos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_pin), label: 'Direcciones'),
        ]);
  }

  Future _getCurrentPosition(BuildContext context) async {
    showAlertDialogWithImage(
        context,
        const AssetImage('assets/images/location_google.png'),
        'Habilita tu localización',
        '¡Habilita la Localización para un Servicio de Entrega Más Rápido y Preciso!',
        'Habilitar Localización',
        false, () {
      _viewModel.getCurrentPosition().then((result) {
        switch (result.status) {
          case ResultStatus.success:
            _closeAlertDialog(context);
          case ResultStatus.error:
            _closeAlertDialog(context);
            errorStateProvider.setFailure(
                context: context, value: result.error!);
        }
      });
    });
  }

  _closeAlertDialog(BuildContext context) {
    _viewModel.loadingState.setLoadingState(isLoading: false);
    Navigator.pop(context);
  }
}

extension UserActions on _TabsPageState {
  void _changeTab(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }
}
