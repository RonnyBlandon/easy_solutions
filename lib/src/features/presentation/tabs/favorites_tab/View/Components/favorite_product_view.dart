import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/cards/favorites_cards/favorite_product_card_view.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProductView extends StatelessWidget with BaseView {
  FavoriteProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<DefaultUserStateProvider>(
            context,
          ).fetchUserFavouriteProductList(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ProductDetailEntity>> snapshot,
      ) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loadingView;
          case ConnectionState.done:
            if (snapshot.hasError || !snapshot.hasData) {
              return ErrorView(
                onButtonPressed: () {
                  coordinator.showTabsPage(context: context);
                },
              );
            }
            if (snapshot.hasData) {
              List<ProductDetailEntity> productList = snapshot.data ?? [];
              return GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return FavoriteProductCardView(
                    isFavorite: productList[index].isFavorite ?? true,
                    product: productList[index],
                    delegate: Provider.of<DefaultUserStateProvider>(context),
                  );
                },
              );
            } else {
              return Container();
            }
          default:
            return loadingView;
        }
      },
    );
  }
}
