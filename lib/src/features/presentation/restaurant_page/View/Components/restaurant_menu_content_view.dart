import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/cards/product_cards/restaurant_product_card_view.dart';
import 'package:flutter/material.dart';

class RestaurantMenuContentView extends StatelessWidget with BaseView {
  final List<BusinessCategoryEntity> businessCategories;
  RestaurantMenuContentView({super.key, required this.businessCategories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 15.0,
        bottom: 15.0,
        right: 15.0,
      ),
      child: Column(
        children: [
          const Text(
            'Menú',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: businessCategories.length,
            itemBuilder: (BuildContext context, index) {
              return _listMenuCategories(context, businessCategories[index]);
            },
          ),
        ],
      ),
    );
  }
}

Widget _listMenuCategories(
  BuildContext context,
  BusinessCategoryEntity businessCategory,
) {
  return Container(
    color: Colors.grey,
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            businessCategory.name,
            style: const TextStyle(
              color: Colors.amber,
              backgroundColor: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _listmenuProduct(context, businessCategory.products),
      ],
    ),
  );
}

Widget _listmenuProduct(
  BuildContext context,
  List<ProductDetailEntity> categoryProducts,
) {
  return Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryProducts.length,
        itemBuilder: (BuildContext context, index) {
          return RestaurantProductCardView(
            context,
            product: categoryProducts[index],
          );
        },
      ),
    ],
  );
}
