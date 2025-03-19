import 'package:easy_solutions/src/features/presentation/search_page/View/search_page.dart';
import 'package:flutter/material.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
//Helpers
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';

Widget searchProduct({
  required BuildContext context,
  required String businessId,
}) {
  return GestureDetector(
    onTap: () {
      showSearch(
        context: context,
        delegate: SearchPage(businessId: businessId),
      );
    },
    child: Container(
      width: getScreenWidth(context: context, multiplier: 0.8),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black, size: 20.0),
          const SizedBox(width: 10.0),
          headerText(
            text: 'Buscar',
            color: Colors.grey,
            fontsize: 17.0,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    ),
  );
}
