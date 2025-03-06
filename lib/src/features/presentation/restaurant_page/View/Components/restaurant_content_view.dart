import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_page/View/Components/restaurant_menu_content_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_page/View/Components/restaurant_profile_content_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_page/ViewModel/restaurant_view_model.dart';
import 'package:flutter/material.dart';

class RestaurantContentView extends StatefulWidget {
  final RestaurantViewModel viewModel;
  const RestaurantContentView({super.key, required this.viewModel});

  @override
  State<RestaurantContentView> createState() => _RestaurantContentViewState();
}

class _RestaurantContentViewState extends State<RestaurantContentView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.blue,
          expandedHeight: 265.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.white,
              child: RestaurantProfileContentView(
                businessDetailEntity: widget.viewModel.businessDetail,
              ),
            ),
          ),
          leading: backButton(context, Colors.white),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.viewModel.businessDetail.isFavorite =
                      !(widget.viewModel.businessDetail.isFavorite ?? false);
                  ;
                  (context).favouriteBusinessIconTapped(
                    widget.viewModel.businessDetail.isFavorite ?? false,
                    widget.viewModel.businessDetail.id,
                  );
                });
              },
              color:
                  widget.viewModel.businessDetail.isFavorite ?? false
                      ? pink
                      : white,
              icon: const Icon(Icons.favorite, size: 28.0),
            ),
            const SizedBox(width: 10.0),
            IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: const Icon(Icons.more_vert, size: 28.0),
            ),
            const SizedBox(width: 10.0),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              color: Colors.white,
              child: RestaurantMenuContentView(
                businessCategories: widget.viewModel.businessCategoryList,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
