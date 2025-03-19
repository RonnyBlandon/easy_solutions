import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
import 'package:flutter/material.dart';

class BusinessCategoriesContentView extends StatelessWidget with BaseView {
  final List<BusinessCategoryEntity> businessCategories;
  BusinessCategoriesContentView({super.key, required this.businessCategories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: businessCategories.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  bottom: 18.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: headerText(
                        text: businessCategories[index].name,
                        fontsize: 20.0,
                        fontWeight: FontWeight.w500,
                        textAling: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        MainCoordinator().showBusinessCategoryPage(
                          context: context,
                          businessCategoryId: businessCategories[index].id,
                          businessId: businessCategories[index].businessId,
                        );
                      },
                      child: Row(
                        children: [
                          headerText(
                            text: 'Ver todos',
                            fontsize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          const Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _firstProductsCategory(
                context,
                businessCategories[index].products,
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _firstProductsCategory(
  BuildContext context,
  List<ProductDetailEntity> productList,
) {
  return SizedBox(
    height: getScreenHeight(context: context, multiplier: 0.22),
    child: ListView.builder(
      itemCount: productList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, index) {
        return _cardProduct(context, product: productList[index]);
      },
    ),
  );
}

_cardProduct(BuildContext context, {required ProductDetailEntity product}) {
  double cardWidth = getScreenWidth(context: context, multiplier: 0.35);

  return GestureDetector(
    onTap: () {
      MainCoordinator().showBusinessProductPage(
        context: context,
        product: product,
      );
    },
    child: Container(
      width: cardWidth,
      margin: const EdgeInsets.only(left: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: grey),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            child: Image(
              width: cardWidth,
              height: getScreenHeight(context: context, multiplier: 0.15),
              fit: BoxFit.cover,
              image:
                  product.productImageUrl.isNotEmpty
                      ? NetworkImage(product.productImageUrl)
                      : const AssetImage('assets/images/image_empty.png'),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: SizedBox(
              width: cardWidth - 10, // Resta padding para evitar desbordamiento
              child: headerText(
                text: product.name,
                fontsize: 12.0,
                fontWeight: FontWeight.w400,
                textAling: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: SizedBox(
              width: cardWidth - 10,
              child:
                  product.discount > 0
                      ? Row(
                        children: [
                          Text(
                            "L ${product.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              decoration:
                                  TextDecoration.lineThrough, // Precio tachado
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          headerText(
                            text: "L ${product.price.toStringAsFixed(2)}",
                            color: green,
                            fontsize: 16.0,
                            fontWeight: FontWeight.w500,
                            textAling: TextAlign.start,
                          ),
                        ],
                      )
                      : headerText(
                        text: "L ${product.price.toStringAsFixed(2)}",
                        fontsize: 14.0,
                        fontWeight: FontWeight.w500,
                        textAling: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
            ),
          ),
        ],
      ),
    ),
  );
}
