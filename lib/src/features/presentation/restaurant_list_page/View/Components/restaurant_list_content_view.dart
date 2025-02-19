import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_list_page/ViewModel/restaurante_list_view_model.dart';
import 'package:flutter/material.dart';

class RestaurantListContentView extends StatelessWidget with BaseView {
  final RestaurantListViewModel viewModel;
  RestaurantListContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Elige tu restaurante:',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        _gridRestaurantList(context, viewModel, coordinator),
      ],
    );
  }
}

Widget _gridRestaurantList(BuildContext context,
    RestaurantListViewModel viewModel, MainCoordinator coordinator) {
  return Expanded(
    child: GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10.0,
      padding: const EdgeInsets.only(top: 10.0),
      children: List.generate(viewModel.restaurantList.length, (index) {
        final restaurant = viewModel.restaurantList[index];
        // Filtrar la imagen del logo
        final logoImage = restaurant.businessImages.firstWhere(
          (image) => image.imageType == 'Logo',
          orElse: () => BusinessImageEntity(
            imageUrl:
                'https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png', // URL de fallback
            imageType: 'Placeholder',
            id: 0,
          ),
        );
        // Mostrar el card con la imagen del logo
        return _cardRestaurant(context, restaurant.id, restaurant.businessName,
            logoImage.imageUrl, coordinator);
      }),
    ),
  );
}

Widget _cardRestaurant(BuildContext context, String businessId,
    String businessName, String imageUrl, MainCoordinator coordinator) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          coordinator.showRestaurantCategoriesPage(
              context: context, businessId: businessId);
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
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
      ),
      SizedBox(
        width: 85.0, // Asegura que el texto no se desborde
        child: Text(
          businessName,
          textAlign: TextAlign.center, // Centra el texto
          maxLines: 2, // Limita el texto a 2 líneas
          overflow: TextOverflow.ellipsis, // Agrega "..." si es muy largo
          softWrap: true, // Permite saltos de línea
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
