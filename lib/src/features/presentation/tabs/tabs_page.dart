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

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _requestLocation(context);
    });
  }

  final List<Widget> _widgetOptions = [
    const ExploreTab(),
    const OrdersTab(),
    const FavoritesTab(),
    const AddressesTab(),
  ];

  int _selectedItemIndex = 0;

  void _changeWidget(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

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
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                )),
          ])),
      body: _widgetOptions.elementAt(_selectedItemIndex),
      drawer: const MainDrawer(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        iconSize: 30.0,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: _selectedItemIndex,
        onTap: _changeWidget,
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

  Future _requestLocation(BuildContext context) async {
    showAlertDialogWithImage(
        context,
        const AssetImage('assets/images/location_google.png'),
        'Habilita tu localización',
        '¡Habilita la Localización para un Servicio de Entrega Más Rápido y Preciso!',
        'Habilitar Localización',
        true,
        () {});
  }
}
