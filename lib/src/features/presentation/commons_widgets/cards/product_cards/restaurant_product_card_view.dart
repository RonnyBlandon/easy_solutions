import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:flutter/material.dart';

class RestaurantProductCardView extends StatefulWidget {
  final ProductDetailEntity product;
  const RestaurantProductCardView(
    BuildContext context, {
    super.key,
    required this.product,
  });

  @override
  State<RestaurantProductCardView> createState() =>
      _RestaurantProductCardViewState();
}

class _RestaurantProductCardViewState extends State<RestaurantProductCardView>
    with BaseView {
  @override
  Widget build(BuildContext context) {
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
                      product: widget.product,
                    );
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image(
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                          image:
                              widget.product.productImageUrl.isNotEmpty
                                  ? NetworkImage(widget.product.productImageUrl)
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
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.product.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        widget.product.isFavorite ?? false
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.product.isFavorite ?? false ? red : black,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.product.isFavorite =
                              !(widget.product.isFavorite ?? false);
                          (context).favouriteProductIconTapped(
                            widget.product.isFavorite ?? false,
                            widget.product.id,
                          );
                        });
                      },
                    ),
                    const Spacer(),
                    if (widget.product.discount > 0.00) ...[
                      Text(
                        "L ${widget.product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration:
                              TextDecoration.lineThrough, // Precio tachado
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "L ${(widget.product.price - widget.product.discount).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Resaltado en rojo
                        ),
                      ),
                    ] else
                      Text(
                        "L ${widget.product.price.toStringAsFixed(2)}",
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
