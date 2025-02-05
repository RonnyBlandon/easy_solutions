import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_menu_page/View/Components/restaurant_menu_products_content_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_menu_page/View/Components/restaurant_profile_content_view.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_menu_page/ViewModel/restaurant_menu_view_model.dart';
import 'package:flutter/material.dart';

class RestaurantMenuContentView extends StatelessWidget {
  final RestaurantMenuViewModel viewModel;
  const RestaurantMenuContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        backgroundColor: Colors.blue,
        expandedHeight: 265.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
              color: Colors.white,
              child: RestaurantProfileContentView(
                  businessDetailEntity: viewModel.businessDetail)),
        ),
        leading: backButton(context, Colors.white),
        actions: [
          IconButton(
            onPressed: () {},
            color: Colors.white,
            icon: const Icon(Icons.favorite, size: 28.0),
          ),
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: () {},
            color: Colors.white,
            icon: const Icon(Icons.more_vert, size: 28.0),
          ),
          const SizedBox(width: 10.0)
        ],
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
            color: Colors.white,
            child: RestaurantMenuProductsContentView(
                businessCategories: viewModel.businessCategoryList)),
      ]))
    ]);
  }
}
