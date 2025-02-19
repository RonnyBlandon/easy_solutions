import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/business_category_page/ViewModel/business_category_view_model.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';
import 'package:flutter/material.dart';

class BusinessCategoryContentView extends StatelessWidget with BaseView {
  final BusinessCategoryViewModel viewModel;
  BusinessCategoryContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _businessCategories(context,
            category: viewModel.businessCategory, coordinator: coordinator)
      ],
    );
  }
}

Widget _businessCategories(BuildContext context,
    {required BusinessCategoryEntity category,
    required MainCoordinator coordinator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: headerText(
            text: category.name,
            color: black,
            fontsize: 20.0,
            fontWeight: FontWeight.w500,
            textAling: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ),
      _categoryProductList(context,
          category: category, coordinator: coordinator),
    ],
  );
}

Widget _categoryProductList(BuildContext context,
    {required BusinessCategoryEntity category,
    required MainCoordinator coordinator}) {
  return SizedBox(
    height: screenHeight.getScreenHeight(context: context, multiplier: 0.788),
    child: GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Reducir columnas para más espacio
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.83, // Ajustar relación ancho-alto
      ),
      itemCount: category.products.length,
      itemBuilder: (context, index) {
        return _cardProduct(context,
            product: category.products[index], coordinator: coordinator);
      },
    ),
  );
}

Widget _cardProduct(BuildContext context,
    {required ProductDetailEntity product,
    required MainCoordinator coordinator}) {
  return GestureDetector(
    onTap: () {
      coordinator.showBusinessProductPage(context: context, product: product);
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: grey),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0)),
              child: Image(
                height: 120.0, // Aumentar altura de la imagen
                width: double.infinity,
                fit: BoxFit.cover,
                image: product.productImageUrl.isNotEmpty
                    ? NetworkImage(product.productImageUrl)
                    : const AssetImage("assets/images/image_empty.png")
                        as ImageProvider,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText(
                  text: product.name,
                  color: black,
                  fontsize: 14.0,
                  fontWeight: FontWeight.w400,
                  textAling: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2.0),
                if (product.discount > 0) ...[
                  Row(
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
                  ),
                ] else
                  headerText(
                    text: "L ${product.price.toStringAsFixed(2)}",
                    color: green,
                    fontsize: 16.0,
                    fontWeight: FontWeight.w500,
                    textAling: TextAlign.start,
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
