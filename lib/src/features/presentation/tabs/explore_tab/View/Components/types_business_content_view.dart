import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/button_categories.dart';
import 'package:flutter/material.dart';

class TypeBusinessListContentView extends StatelessWidget with BaseView {
  final List<TypeBusinessDetailEntity> typeBusinessList;
  TypeBusinessListContentView({super.key, required this.typeBusinessList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: typeBusinessList.length,
          itemBuilder: (context, index) {
            final typeBusiness = typeBusinessList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ButtonCategories(
                  onTap: () {
                    coordinator.showRestaurantOrBusinessListPage(
                        context: context, typeBusinessId: typeBusiness.id);
                  },
                  text: typeBusiness.name,
                  networkImage: typeBusiness.imageUrl,
                  decoration: TextDecoration.underline,
                  textColor: Colors.yellow),
            );
          }),
    );
  }
}
