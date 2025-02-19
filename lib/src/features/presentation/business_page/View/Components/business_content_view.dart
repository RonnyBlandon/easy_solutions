import 'package:easy_solutions/src/features/presentation/business_page/View/Components/business_categories_content_view.dart';
import 'package:easy_solutions/src/features/presentation/business_page/View/Components/business_info_content_view.dart';
import 'package:easy_solutions/src/features/presentation/business_page/ViewModel/business_categories_view_model.dart';
import 'package:flutter/material.dart';

class BusinessContentView extends StatelessWidget {
  final BusinessCategoriesViewModel viewModel;
  const BusinessContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate(
          [
            BusinessInfoContentView(
                businessDetailEntity: viewModel.businessDetail),
            BusinessCategoriesContentView(
                businessCategories: viewModel.businessCategoryList)
          ],
        )),
      ],
    );
  }
}
