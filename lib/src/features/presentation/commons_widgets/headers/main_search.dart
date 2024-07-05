import 'package:flutter/material.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';

Widget searchProduct(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, 'search'),
    child: Container(
      width: screenWidth.getScreenWidth(context: context, multiplier: 0.8),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.black,
            size: 20.0,
          ),
          const SizedBox(width: 10.0),
          customTitle('Buscar', Colors.grey,
              fontsize: 17.0, fontWeight: FontWeight.w400),
        ],
      ),
    ),
  );
}
