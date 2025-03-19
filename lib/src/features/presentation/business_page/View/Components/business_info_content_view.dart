import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
import 'package:flutter/material.dart';

class BusinessInfoContentView extends StatefulWidget {
  final BusinessDetailEntity businessDetailEntity;
  const BusinessInfoContentView({
    super.key,
    required this.businessDetailEntity,
  });

  @override
  State<BusinessInfoContentView> createState() =>
      _BusinessInfoContentViewState();
}

class _BusinessInfoContentViewState extends State<BusinessInfoContentView> {
  @override
  Widget build(BuildContext context) {
    // Buscar la imagen del logo en la lista de imágenes
    final logoImage = widget.businessDetailEntity.businessImages.firstWhere(
      (image) => image.imageType == "Logo",
      orElse: () => BusinessImageEntity(imageUrl: '', imageType: '', id: 0),
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 10.0,
        bottom: 15.0,
        left: 10.0,
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
                text: widget.businessDetailEntity.businessName,
                fontsize: 20.0,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: headerText(
                  text: 'Abierto',
                  color: Colors.white,
                  fontsize: 16.0,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                widget.businessDetailEntity.isFavorite =
                    !(widget.businessDetailEntity.isFavorite ?? false);
                (context).favouriteBusinessIconTapped(
                  widget.businessDetailEntity.isFavorite ?? false,
                  widget.businessDetailEntity.id,
                );
              });
            },
            icon: Icon(
              widget.businessDetailEntity.isFavorite ?? false
                  ? Icons.favorite
                  : Icons.favorite_border,
              color:
                  widget.businessDetailEntity.isFavorite ?? false ? red : black,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder:
                    (context) => _buildBottomSheetBusinessInfo(
                      context,
                      businessName: widget.businessDetailEntity.businessName,
                    ),
              );
            },
            icon: const Icon(Icons.info_outlined),
          ),
        ],
      ),
    );
  }
}

// Aqui se pone la informacion como los horarios y la dirección del negocio
Widget _buildBottomSheetBusinessInfo(
  BuildContext context, {
  required String businessName,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, size: 30.0),
            ),
            Container(
              width: getScreenWidth(context: context, multiplier: 0.8),
              alignment: Alignment.center,
              child: headerText(
                text: 'Información',
                fontsize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: grey, width: 4.0)),
          ),
          child: Row(
            children: [
              const Image(
                width: 50.0,
                height: 50.0,
                image: AssetImage('assets/images/business/logo_business.png'),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerText(
                    text: businessName,
                    fontsize: 20.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: headerText(
                text: 'Horarios',
                fontsize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    headerText(
                      text: 'Lunes',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: 'Martes',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: 'Miercoles',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: 'Jueves',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: 'Viernes',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: 'Sabado',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: 'Domingo',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Column(
                  children: [
                    headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: '07:00 AM - 05:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: '09:00 AM - 08:00 PM',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    headerText(
                      text: 'Cerrado',
                      fontsize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
