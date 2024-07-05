import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_double.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 40.0,
                  )),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTitle('Buscar', Colors.black),
                      _searchInput(),
                      const SizedBox(height: 30.0),
                      headerDoubleText(
                          textHeader: 'Búsqueda reciente',
                          textAction: 'Borrar todo'),
                      _sliderRencentSearch(),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

Widget _searchInput() {
  return Container(
    height: 40.0,
    margin: const EdgeInsets.only(top: 5.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(20.0)),
    child: const TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search),
          hintText: 'Buscar Producto',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget _sliderRencentSearch() {
  return Container(
    height: 190.0,
    margin: const EdgeInsets.only(top: 5.0),
    child: ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, index) {
        return _cardProduct(context,
            productName: 'Juice Shop dedeswswswdeddeded',
            productPrice: 'L 59.99');
      },
    ),
  );
}

Widget _cardProduct(BuildContext context,
    {required String productName, required String productPrice}) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, 'product_details'),
    child: Container(
      width: 160.0,
      margin: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: const Image(
                width: 160.0,
                height: 120.0,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/business/product.jpg')),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTitle(productName, Colors.black,
                  fontsize: 17.0,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              customTitle(productPrice, Colors.black,
                  fontsize: 15.0, fontWeight: FontWeight.w400)
            ],
          )
        ],
      ),
    ),
  );
}
