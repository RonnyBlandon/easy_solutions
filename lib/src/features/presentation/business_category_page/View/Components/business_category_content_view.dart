import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/business_category_page/ViewModel/business_category_view_model.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/cards/product_cards/business_product_card_view.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
import 'package:flutter/material.dart';

class BusinessCategoryContentView extends StatelessWidget with BaseView {
  final BusinessCategoryViewModel viewModel;
  BusinessCategoryContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _businessCategories(
          context,
          category: viewModel.businessCategory,
          coordinator: coordinator,
        ),
      ],
    );
  }
}

Widget _businessCategories(
  BuildContext context, {
  required BusinessCategoryEntity category,
  required MainCoordinator coordinator,
}) {
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
          overflow: TextOverflow.ellipsis,
        ),
      ),
      _categoryProductList(
        context,
        category: category,
        coordinator: coordinator,
      ),
    ],
  );
}

Widget _categoryProductList(
  BuildContext context, {
  required BusinessCategoryEntity category,
  required MainCoordinator coordinator,
}) {
  return SizedBox(
    height: getScreenHeight(context: context, multiplier: 0.788),
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
        return BusinessProductCardView(product: category.products[index]);
      },
    ),
  );
}
