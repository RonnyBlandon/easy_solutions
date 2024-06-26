import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 142.0,
      height: 142.0,
      decoration: createBoxDecorationWithShadows(
          borderRadius: BorderRadius.circular(70)),
      child: const Icon(
        Icons.person,
        color: orange,
        size: 130.0,
      ),
    );
  }
}
