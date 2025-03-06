import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:flutter/material.dart';

mixin FavouriteProductCardViewDelegate {
  favouriteProductIconTapped(bool isTapped, String productId);
}

class FavoriteProductCardView extends StatefulWidget {
  bool isFavorite;
  final ProductDetailEntity product;
  final FavouriteProductCardViewDelegate? delegate;

  FavoriteProductCardView({
    super.key,
    required this.isFavorite,
    required this.product,
    this.delegate,
  });

  @override
  State<FavoriteProductCardView> createState() =>
      _FavoriteProductCardViewState();
}

class _FavoriteProductCardViewState extends State<FavoriteProductCardView>
    with BaseView {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        coordinator.showRestaurantProductPage(
          context: context,
          product: widget.product,
        );
      },
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen del producto
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
              child: Image(
                height: 120.0,
                width: double.infinity,
                fit: BoxFit.cover,
                image:
                    widget.product.productImageUrl.isNotEmpty
                        ? NetworkImage(widget.product.productImageUrl)
                        : const AssetImage("assets/images/image_empty.png")
                            as ImageProvider,
              ),
            ),
            // Nombre del producto
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            // Precios (viejo y actual)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.product.discount > 0.00) ...[
                    Text(
                      'L ${(widget.product.price - widget.product.discount).toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      'L ${widget.product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: green,
                      ),
                    ),
                  ] else
                    Text(
                      'L ${widget.product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: green,
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            // Botón de favorito abajo
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: grey)),
              ),
              child: IconButton(
                icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.isFavorite ? red : black,
                ),
                onPressed: () {
                  setState(() {
                    widget.isFavorite = !widget.isFavorite;
                    widget.delegate?.favouriteProductIconTapped(
                      widget.isFavorite,
                      widget.product.id,
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
