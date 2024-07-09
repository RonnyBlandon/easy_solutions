import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
// Components
import 'package:easy_solutions/src/features/presentation/profile_details_page/View/components/avatar_view.dart';
import 'package:easy_solutions/src/features/presentation/profile_details_page/View/components/textfields_view.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';
//Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(text: 'Editar Perfil', fontsize: 18.0),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(right: 15.0),
              child: headerText(
                text: 'Guardar',
                color: orange,
                fontsize: 17.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: screenWidth.getScreenWidth(context: context),
                height: screenHeight.getScreenHeight(
                    context: context, multiplier: 0.55),
                margin: EdgeInsets.only(
                    top: screenHeight.getScreenHeight(
                        context: context, multiplier: 0.1),
                    left: 15.0,
                    right: 15.0),
                decoration: createBoxDecorationWithShadows(),
                child: Column(
                  children: [
                    Transform.translate(
                        offset: const Offset(0.0, -60.0),
                        child: const AvatarView()),
                    const TextfieldsProfileDetailView(),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
