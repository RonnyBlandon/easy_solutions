import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/main_search.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';

class ProductCategoriesPage extends StatelessWidget {
  const ProductCategoriesPage({super.key});

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
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate(
              [
                _businessInfo(context, businessName: 'Jaguar King'),
                _businessCategories(context, categoryName: 'Carnes y Pescado'),
                _businessCategories(context, categoryName: 'Frutas y Verduras'),
                _businessCategories(context, categoryName: 'Abarrotes'),
                _businessCategories(context,
                    categoryName: 'Bebidas sin alcohol'),
                _businessCategories(context, categoryName: 'Bebes'),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

Widget _businessInfo(BuildContext context, {required String businessName}) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 15.0, left: 10.0),
    child: Row(
      children: [
        const Image(
            width: 50.0,
            height: 50.0,
            image: AssetImage('assets/images/business/logo_business.png')),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerText(
                text: businessName,
                fontsize: 20.0,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Row(
              children: [
                headerText(
                    text: 'Minimo de compra',
                    fontsize: 14.0,
                    fontWeight: FontWeight.w300),
                const SizedBox(
                  width: 10.0,
                ),
                headerText(text: 'L. 110', fontsize: 14.0),
              ],
            )
          ],
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => _buildBottomSheetBusinessInfo(context,
                      businessName: 'Jaguar King'));
            },
            icon: const Icon(Icons.info_outlined)),
      ],
    ),
  );
}

Widget _buildBottomSheetBusinessInfo(BuildContext context,
    {required String businessName}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, size: 30.0),
          ),
          Container(
              width:
                  screenWidth.getScreenWidth(context: context, multiplier: 0.8),
              alignment: Alignment.center,
              child: headerText(
                  text: 'Información',
                  fontsize: 16.0,
                  fontWeight: FontWeight.w400)),
        ],
      ),
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: grey, width: 4.0))),
        child: Row(
          children: [
            const Image(
                width: 50.0,
                height: 50.0,
                image: AssetImage('assets/images/business/logo_business.png')),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText(
                    text: businessName,
                    fontsize: 20.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
      Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: headerText(
                text: 'Horarios', fontsize: 20.0, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  headerText(
                      text: 'Lunes',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: 'Martes',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: 'Miercoles',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: 'Jueves',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: 'Viernes',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: 'Sabado',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: 'Domingo',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                ],
              ),
              Column(
                children: [
                  headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: '09:00 AM - 08:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                  headerText(
                      text: 'Cerrado',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400),
                ],
              ),
            ],
          ),
        ],
      ),
    ]),
  );
}

Widget _businessCategories(BuildContext context,
    {required String categoryName}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 25.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: headerText(
                    text: categoryName,
                    fontsize: 20.0,
                    fontWeight: FontWeight.w500,
                    textAling: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'product_category');
                },
                child: Row(
                  children: [
                    headerText(
                        text: 'Ver todos',
                        fontsize: 14.0,
                        fontWeight: FontWeight.w400),
                    const Icon(Icons.arrow_right)
                  ],
                ),
              )
            ],
          ),
        ),
        _categoryProductList(context),
      ],
    ),
  );
}

Widget _categoryProductList(BuildContext context) {
  return SizedBox(
    height: screenHeight.getScreenHeight(context: context, multiplier: 0.22),
    child: ListView.builder(
      itemCount: 20,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, index) {
        return _cardProduct(context,
            productName: 'Juice Shop', productPrice: 'L 59.99');
      },
    ),
  );
}

_cardProduct(BuildContext context,
    {required String productName, required String productPrice}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, 'product_details');
    },
    child: Container(
      margin: const EdgeInsets.only(left: 12.0),
      decoration: BoxDecoration(
          border: Border.all(color: grey),
          borderRadius: BorderRadius.circular(6.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
            child: Image(
                width: screenWidth.getScreenWidth(
                    context: context, multiplier: 0.35),
                height: screenHeight.getScreenHeight(
                    context: context, multiplier: 0.15),
                fit: BoxFit.cover,
                image: const AssetImage('assets/images/business/product.jpg')),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: headerText(
                text: productName,
                fontsize: 14.0,
                fontWeight: FontWeight.w300,
                textAling: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: headerText(
                text: productPrice,
                fontsize: 16.0,
                fontWeight: FontWeight.w400,
                textAling: TextAlign.start),
          )
        ],
      ),
    ),
  );
}
