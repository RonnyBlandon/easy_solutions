import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
import 'package:flutter/material.dart';

mixin FavouriteBusinessCardViewDelegate {
  favouriteBusinessIconTapped(bool isTapped, String businessId);
}

class FavoriteBusinessCardView extends StatefulWidget {
  bool isFavorite;
  final BusinessDetailEntity business;
  final FavouriteBusinessCardViewDelegate? delegate;

  FavoriteBusinessCardView({
    super.key,
    required this.isFavorite,
    required this.business,
    this.delegate,
  });

  @override
  State<FavoriteBusinessCardView> createState() =>
      _FavoriteBusinessCardViewState();
}

class _FavoriteBusinessCardViewState extends State<FavoriteBusinessCardView>
    with BaseView {
  @override
  Widget build(BuildContext context) {
    // Buscar la imagen del logo en la lista de imágenes
    final logoImage = widget.business.businessImages.firstWhere(
      (image) => image.imageType == "Logo",
      orElse: () => BusinessImageEntity(imageUrl: '', imageType: '', id: 0),
    );

    return GestureDetector(
      onTap: () {
        widget.business.typeBusiness.id == 1
            ? coordinator.showRestaurantCategoriesPage(
              context: context,
              businessId: widget.business.id,
            )
            : coordinator.showBusinessCategoriesPage(
              context: context,
              businessId: widget.business.id,
            );
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: createBoxDecorationWithShadows(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Image(
              width: 50.0,
              height: 50.0,
              image:
                  logoImage.imageUrl.isNotEmpty
                      ? NetworkImage(logoImage.imageUrl)
                      : const AssetImage('assets/images/image_empty.png'),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText(
                  text: widget.business.businessName,
                  color: black,
                  fontsize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: headerText(
                    text: 'Abierto',
                    color: white,
                    fontsize: 14.0,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              color: widget.isFavorite ? red : black,
              onPressed: () {
                setState(() {
                  widget.isFavorite = !widget.isFavorite;
                  widget.delegate?.favouriteBusinessIconTapped(
                    widget.isFavorite,
                    widget.business.id,
                  );
                });
              },
              icon: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
