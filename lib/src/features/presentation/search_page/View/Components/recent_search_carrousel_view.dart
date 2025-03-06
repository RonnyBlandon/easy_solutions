import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:flutter/material.dart';

class RecentSearchCarrouselView extends StatelessWidget {
  // Dependencies
  final List<ProductDetailEntity> productList;
  const RecentSearchCarrouselView({ super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    // Invertir la lista para mostrar el último agregado primero
    final reversedProductList = productList.reversed.toList();

    return Container(
        margin: const EdgeInsets.only(top: 5.0),
        height: 240.0,
        child: ListView.builder(
          itemCount: productList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return RecentSearchVerticalCardView(product: reversedProductList[index]);
          },
        ));
  }
}

class RecentSearchVerticalCardView extends StatelessWidget with BaseView {
  final ProductDetailEntity product;

  RecentSearchVerticalCardView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () => coordinator.showBusinessProductPage(context: context, product: product),
    child: Container(
      width: 160.0,
      margin: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
                width: 160.0,
                height: 120.0,
                fit: BoxFit.cover,
                image: product.productImageUrl.isNotEmpty
                            ? NetworkImage(product.productImageUrl)
                                as ImageProvider
                            : const AssetImage(
                                'assets/images/image_empty.png')),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerText(
                  text: product.name,
                  color: Colors.black,
                  fontsize: 17.0,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              headerText(
                  text: product.price.toStringAsFixed(2),
                  color: Colors.black,
                  fontsize: 15.0,
                  fontWeight: FontWeight.w400)
            ],
          )
        ],
      ),
    ),
  );
  }
}