import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:flutter/material.dart';

class RestaurantMenuContentView extends StatelessWidget with BaseView {
  final List<BusinessCategoryEntity> businessCategories;
  RestaurantMenuContentView({super.key, required this.businessCategories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 12.0, left: 15.0, bottom: 15.0, right: 15.0),
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
    BuildContext context, BusinessCategoryEntity businessCategory) {
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
                fontWeight: FontWeight.bold),
          ),
        ),
        _listmenuProduct(context, businessCategory.products),
      ],
    ),
  );
}

Widget _listmenuProduct(
    BuildContext context, List<ProductDetailEntity> categoryProducts) {
  return Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryProducts.length,
        itemBuilder: (BuildContext context, index) {
          return _cardProduct(context, categoryProducts[index]);
        },
      ),
    ],
  );
}

Widget _cardProduct(BuildContext context, ProductDetailEntity product) {
  return Container(
    width: double.infinity,
    color: Colors.grey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey))),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  MainCoordinator().showRestaurantProductPage(
                      context: context, product: product);
                },
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image(
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                        image: product.productImageUrl.isNotEmpty
                            ? NetworkImage(product.productImageUrl)
                                as ImageProvider
                            : const AssetImage(
                                'assets/images/image_empty.png')),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          product.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )
                ]),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                  ),
                  const Spacer(),
                  if (product.discount > 0.00) ...[
                    Text(
                      "L ${product.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration:
                            TextDecoration.lineThrough, // Precio tachado
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      "L ${(product.price - product.discount).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Resaltado en rojo
                      ),
                    ),
                  ] else
                    Text(
                      "L ${product.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
