import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/main_search.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';

class ProductCategoryPage extends StatelessWidget {
  const ProductCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        toolbarHeight:
            screenHeight.getScreenHeight(context: context, multiplier: 0.1),
        leading: backButton(context, black),
        actions: [searchProduct(context)],
      ),
      body: Column(
        children: [
          _businessCategories(context, categoryName: 'Carnes y Pescado')
        ],
      ),
    ));
  }
}

Widget _businessCategories(BuildContext context,
    {required String categoryName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
          child: customTitle(categoryName, black,
              fontsize: 20.0,
              fontWeight: FontWeight.w500,
              textAling: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
      ),
      _categoryProductList(context),
    ],
  );
}

Widget _categoryProductList(BuildContext context) {
  return SizedBox(
    height: screenHeight.getScreenHeight(context: context, multiplier: 0.788),
    child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 20,
        itemBuilder: (context, index) {
          return _cardProduct(context,
              productName: 'Juice Shop', productPrice: 'L 59.99');
        }),
  );
}

_cardProduct(BuildContext context,
    {required String productName, required String productPrice}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, 'product_details');
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 12.0, left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: grey),
          borderRadius: BorderRadius.circular(6.0)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
            child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/business/product.jpg')),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: customTitle(productName, black,
                fontsize: 14.0,
                fontWeight: FontWeight.w300,
                textAling: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: customTitle(productPrice, black,
                fontsize: 16.0,
                fontWeight: FontWeight.w400,
                textAling: TextAlign.start),
          ),
        ],
      ),
    ),
  );
}
