import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:flutter/material.dart';

class ProductListCarousel extends StatefulWidget {
  final List<ProductDetailEntity> productList;
  const ProductListCarousel({super.key, required this.productList});

  @override
  State<ProductListCarousel> createState() => _ProductListCarouselState();
}

class _ProductListCarouselState extends State<ProductListCarousel>
    with BaseView {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.productList.length,
      itemBuilder: (BuildContext context, index) {
        return _cardProduct(context, widget.productList[index]);
      },
    );
  }
}

extension _PrivateMethods on _ProductListCarouselState {
  Widget _cardProduct(BuildContext context, ProductDetailEntity product) {
    return Container(
      width: double.infinity,
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    coordinator.showRestaurantProductPage(
                      context: context,
                      product: product,
                    );
                  },
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image(
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                            image:
                                product.productImageUrl.isNotEmpty
                                    ? NetworkImage(product.productImageUrl)
                                        as ImageProvider
                                    : const AssetImage(
                                      'assets/images/image_empty.png',
                                    ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                product.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          product.isFavorite = !(product.isFavorite ?? true);
                          (context).favouriteProductIconTapped(
                            product.isFavorite ?? true,
                            product.id,
                          );
                        });
                      },
                      icon: Icon(
                        product.isFavorite ?? true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite ?? true ? red : black,
                      ),
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
                          color: Colors.green,
                        ),
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
}
