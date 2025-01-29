import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_list_page/ViewModel/restaurante_list_view_model.dart';
import 'package:flutter/material.dart';

class RestaurantListContentView extends StatelessWidget {
  final RestaurantListViewModel viewModel;
  const RestaurantListContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Elige tu restaurante:',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        _gridRestaurantList(context, viewModel),
      ],
    );
  }
}

Widget _gridRestaurantList(
    BuildContext context, RestaurantListViewModel viewModel) {
  return Expanded(
    child: GridView.count(
      crossAxisCount: 3,
      children: List.generate(viewModel.restaurantList.length, (index) {
        final restaurant = viewModel.restaurantList[index];
        // Filtrar la imagen del logo
        final logoImage = restaurant.images.firstWhere(
          (image) => image.imageType == 'Logo',
          orElse: () => BusinessImage(
            imageUrl:
                'https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png', // URL de fallback
            imageType: 'Placeholder',
            id: '0',
          ),
        );
        // Mostrar el card con la imagen del logo
        return _cardRestaurant(
            context, restaurant.businessName, logoImage.imageUrl);
      }),
    ),
  );
}

Widget _cardRestaurant(
    BuildContext context, String businessName, String imageUrl) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'restaurant_menu');
        },
        child: Container(
          width: 85.0,
          height: 85.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(3.0, 3.0), // Desplazamiento de la sombra
                  blurRadius: 4.0, // Difuminación de la sombra
                )
              ],
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(imageUrl))),
        ),
      ),
      Text(
        businessName,
        style: const TextStyle(
            color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),
      )
    ],
  );
}
