import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/business_list_page/ViewModel/business_list_view_model.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
import 'package:flutter/material.dart';

class BusinessListContentView extends StatelessWidget with BaseView {
  final BusinessListViewModel viewModel;
  BusinessListContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Elige el establecimiento:',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        _businessList(context, viewModel.businessList, coordinator),
      ],
    );
  }
}

Widget _businessList(BuildContext context,
    List<BusinessDetailEntity> businessList, MainCoordinator coordinator) {
  return SizedBox(
    height: screenHeight.getScreenHeight(context: context, multiplier: 0.84),
    child: ListView.builder(
      itemCount: businessList.length,
      itemBuilder: (BuildContext context, index) {
        final business = businessList[index];
        return _cardBusinnes(context, business, coordinator);
      },
    ),
  );
}

Widget _cardBusinnes(BuildContext context, BusinessDetailEntity business,
    MainCoordinator coordinator) {
  // Filtrar la imagen del logo
  final logoImage = business.businessImages.firstWhere(
    (image) => image.imageType == 'Logo',
    orElse: () => BusinessImageEntity(
      imageUrl:
          'https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png', // URL de fallback
      imageType: 'Placeholder',
      id: 0,
    ),
  );

  return GestureDetector(
    onTap: () {
      coordinator.showBusinessCategoriesPage(
          context: context, businessId: business.id);
    },
    child: Container(
      padding: const EdgeInsets.all(7.0),
      margin: const EdgeInsets.all(10.0),
      decoration: createBoxDecorationWithShadows(
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          Image(
              width: 80.0,
              height: 80.0,
              image: NetworkImage(logoImage.imageUrl)),
          const SizedBox(width: 10.0),
          Expanded(
            // Hace que el contenido ocupe el espacio disponible
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText(
                  text: business.businessName,
                  color: Colors.black,
                  fontsize: 18.0,
                  overflow: TextOverflow.ellipsis, // Corta con "..."
                  maxLines: 1, // Limita a una línea
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: headerText(
                      text: 'Abierto', color: Colors.white, fontsize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
