import 'dart:ui';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:flutter/material.dart';

class RestaurantProfileContentView extends StatelessWidget {
  final BusinessDetailEntity businessDetailEntity;
  const RestaurantProfileContentView(
      {super.key, required this.businessDetailEntity});

  @override
  Widget build(BuildContext context) {
    // Buscar la imagen del logo en la lista de imágenes
    final logoImage = businessDetailEntity.businessImages
        .firstWhere((image) => image.imageType == "Logo",
            orElse: () => BusinessImageEntity(
                  imageUrl: '',
                  imageType: '',
                  id: 0,
                ));
    final portadaImage = businessDetailEntity.businessImages
        .firstWhere((image) => image.imageType == "Portada",
            orElse: () => BusinessImageEntity(
                  imageUrl: '',
                  imageType: '',
                  id: 0,
                ));
    // Buscar la imagen de la portada en la lista de imágenes
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: portadaImage.imageUrl.isNotEmpty
                      ? NetworkImage(portadaImage.imageUrl)
                      : const AssetImage(
                          'assets/images/image_empty.png'), // Imagen por defecto si no hay logo,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            Positioned(
              left: 20.0,
              bottom: 0.0,
              child: Container(
                width: 65.0,
                height: 65.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: logoImage.imageUrl.isNotEmpty
                          ? NetworkImage(logoImage.imageUrl)
                          : const AssetImage('assets/images/image_empty.png'),
                    ),
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            )
          ],
        ),
        _restaurantInfo(businessDetailEntity)
      ],
    );
  }
}

Widget _restaurantInfo(BusinessDetailEntity business) {
  return Container(
    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          business.businessName,
          style: const TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: const Text(
                'Abierto',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            const Text(
              'Horario 10:00 am - 8:00 pm',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ],
    ),
  );
}
