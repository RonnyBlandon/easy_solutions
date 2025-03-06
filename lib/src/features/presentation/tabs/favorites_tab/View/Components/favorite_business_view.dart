import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/cards/favorites_cards/favorite_business_card_view.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBusinessView extends StatelessWidget with BaseView {
  FavoriteBusinessView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<DefaultUserStateProvider>(
            context,
          ).fetchUserFavouriteBusinessList(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<BusinessDetailEntity>> snapshot,
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
              List<BusinessDetailEntity> businessList = snapshot.data ?? [];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: businessList.length,
                  itemBuilder: (BuildContext context, index) {
                    return FavoriteBusinessCardView(
                      isFavorite: businessList[index].isFavorite ?? true,
                      business: businessList[index],
                      delegate: Provider.of<DefaultUserStateProvider>(context),
                    );
                  },
                ),
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
