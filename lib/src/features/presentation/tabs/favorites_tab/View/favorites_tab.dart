import 'package:flutter/material.dart';
//Components
import 'package:easy_solutions/src/features/presentation/tabs/favorites_tab/View/Components/favorite_locale_view.dart';
import 'package:easy_solutions/src/features/presentation/tabs/favorites_tab/View/Components/favorite_product_view.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  final bool emptyFavoriteState = false;
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            leadingWidth: 0,
            title: headerText(
                text: 'Favoritos', color: Colors.black, fontsize: 18.0),
            backgroundColor: white,
            actions: [
              ElevatedButton(
                onPressed: () => setState(() => selectedButtonIndex = 0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedButtonIndex == 0
                      ? orange
                      : white, // Cambia el color según la selección
                  foregroundColor: selectedButtonIndex == 0
                      ? white
                      : orange, // Opcionalmente cambia el color del texto para el contraste
                ),
                child: const Text('Locales'),
              ),
              const SizedBox(
                width: 10.0,
              ),
              ElevatedButton(
                onPressed: () => setState(() => selectedButtonIndex = 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedButtonIndex == 1
                      ? orange
                      : white, // Cambia el color según la selección
                  foregroundColor: selectedButtonIndex == 1
                      ? white
                      : orange, // Opcionalmente cambia el color del texto para el contraste
                ),
                child: const Text('Productos'),
              ),
              const SizedBox(width: 10.0),
            ],
          )),
      body: selectedButtonIndex == 0
          ? const FavoriteLocaleView()
          : const FavoriteProductView(),
    );
  }
}
