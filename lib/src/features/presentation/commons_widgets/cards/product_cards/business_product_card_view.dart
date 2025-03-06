import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:flutter/material.dart';

class BusinessProductCardView extends StatefulWidget {
  final ProductDetailEntity product;
  const BusinessProductCardView({super.key, required this.product});

  @override
  State<BusinessProductCardView> createState() =>
      _BusinessProductCardViewState();
}

class _BusinessProductCardViewState extends State<BusinessProductCardView>
    with BaseView {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        coordinator.showBusinessProductPage(
          context: context,
          product: widget.product,
        );
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
                  topRight: Radius.circular(5.0),
                ),
                child: Image(
                  height: 120.0, // Aumentar altura de la imagen
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image:
                      widget.product.productImageUrl.isNotEmpty
                          ? NetworkImage(widget.product.productImageUrl)
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
                    text: widget.product.name,
                    color: black,
                    fontsize: 14.0,
                    fontWeight: FontWeight.w400,
                    textAling: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2.0),
                  if (widget.product.discount > 0) ...[
                    Row(
                      children: [
                        Text(
                          "L ${widget.product.price.toStringAsFixed(2)}",
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
                          text: "L ${widget.product.price.toStringAsFixed(2)}",
                          color: green,
                          fontsize: 16.0,
                          fontWeight: FontWeight.w500,
                          textAling: TextAlign.start,
                        ),
                      ],
                    ),
                  ] else
                    headerText(
                      text: "L ${widget.product.price.toStringAsFixed(2)}",
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
}
