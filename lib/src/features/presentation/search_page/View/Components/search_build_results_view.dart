import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/carousel/product_list_carousel.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:flutter/material.dart';

class SearchBuildResultsView extends StatefulWidget {
  //Dependencias
  final List<ProductDetailEntity> products;
  const SearchBuildResultsView({super.key, required this.products});

  @override
  State<SearchBuildResultsView> createState() => _SearchBuildResultsViewState();
}

class _SearchBuildResultsViewState extends State<SearchBuildResultsView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  headerText(text: 'Resultados', fontsize: 22),
                  const SizedBox(height: 15.0),
                  ProductListCarousel(productList: widget.products)
                ],
              ),
            )
          ]),
        )
      ],
    );
  }
}
