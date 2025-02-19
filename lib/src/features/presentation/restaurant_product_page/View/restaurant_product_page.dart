import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';
import 'package:flutter/material.dart';
//Extension
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
//Third party package
import 'package:another_carousel_pro/another_carousel_pro.dart';

class RestaurantProductPage extends StatefulWidget {
  final ProductDetailEntity productDetailEntity;
  const RestaurantProductPage({super.key, required this.productDetailEntity});

  @override
  State<RestaurantProductPage> createState() => _RestaurantProductPageState();
}

class _RestaurantProductPageState extends State<RestaurantProductPage> {
  final Map<String, Set<String>> _selectedExtras = {};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: backButton(context, Colors.black),
          title:
              headerText(text: widget.productDetailEntity.name, fontsize: 18.0),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'shopping_cart');
                },
                color: Colors.black,
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: CustomScrollView(slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            _productImage(context, widget.productDetailEntity.productImageUrl),
            Container(
                color: Colors.white,
                child: _productInfoContainer(
                  productName: widget.productDetailEntity.name,
                  productDescription: widget.productDetailEntity.description,
                  productPrice: widget.productDetailEntity.price,
                  productDiscount: widget.productDetailEntity.discount,
                )),
            _productOptions(context, widget.productDetailEntity.options)
          ]))
        ]),
        bottomNavigationBar:
            _addCart(context, widget.productDetailEntity.price),
      ),
    );
  }
}

extension PrivateMethods on _RestaurantProductPageState {
  Widget _productImage(BuildContext context, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight.getScreenHeight(
                  context: context, multiplier: 0.35),
              child: AnotherCarousel(
                  dotSize: 4.0,
                  indicatorBgPadding: 3.0,
                  images: [NetworkImage(imageUrl)]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productInfoContainer(
      {required String productName,
      required String productDescription,
      required double productPrice,
      required double productDiscount}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 12.0, left: 15.0, bottom: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerText(text: productName, fontsize: 21.0),
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (productDiscount > 0)
                Row(
                  children: [
                    Text(
                      "L ${productPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration:
                            TextDecoration.lineThrough, // Precio tachado
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      "L ${(productPrice - productDiscount).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Resaltado en rojo
                      ),
                    ),
                  ],
                )
              else
                headerText(
                    text: "L ${productPrice.toStringAsFixed(2)}",
                    color: Colors.green,
                    fontsize: 24.0),
              IconButton(
                  onPressed: () {},
                  iconSize: 30.0,
                  icon: const Icon(Icons.favorite_border))
            ],
          ),
          const SizedBox(height: 10.0),
          headerText(
              text: 'Descripción y Especificaciones',
              color: Colors.black,
              fontsize: 20.0,
              fontWeight: FontWeight.w500),
          const SizedBox(height: 2.0),
          headerText(text: '-', fontWeight: FontWeight.w400),
          const SizedBox(height: 2.0),
          headerText(
            text: productDescription,
            fontsize: 16.0,
            fontWeight: FontWeight.w400,
            textAling: TextAlign.start,
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _addCart(BuildContext context, double totalPrice) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
          top: 5.0, right: 10.0, bottom: 10.0, left: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              headerText(
                  text: "Tu pedido",
                  fontsize: 20.0,
                  fontWeight: FontWeight.w600),
              const Spacer(),
              headerText(
                  text: "L ${totalPrice.toStringAsFixed(2)}",
                  fontsize: 20.0,
                  fontWeight: FontWeight.w600),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.remove)),
                    headerText(text: ' 1 ', fontsize: 16.0),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  ],
                ),
              ),
              createElevatedButton(
                  onPressed: () {},
                  width: screenWidth.getScreenWidth(
                      context: context, multiplier: 0.5),
                  height: 49.0,
                  radius: 10.0,
                  backgroundColor: Colors.blue,
                  labelButton: 'Agregar',
                  fontSize: 18.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productOptions(BuildContext context, List<Option> options) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (options.isNotEmpty) headerText(text: 'Opciones', fontsize: 22.0),
          ...options.map((option) => _optionItem(context, option)),
        ],
      ),
    );
  }

  Widget _optionItem(BuildContext context, Option option) {
    _selectedExtras.putIfAbsent(option.title, () => {});

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey,
            height: 5.0,
          ),
          Row(
            children: [
              headerText(
                text: option.title,
                fontsize: 20.0,
                fontWeight: FontWeight.w600,
              ),
              const Spacer(),
              if (option.isRequired)
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: _selectedExtras[option.title]!.length ==
                                option.maxExtras
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: headerText(
                        text: _selectedExtras[option.title]!.length ==
                                option.maxExtras
                            ? "Completado"
                            : "Requisito*",
                        fontsize: 14.0,
                        color: Colors.white)),
            ],
          ),
          if (option.maxExtras > 1)
            SizedBox(
              width: double.infinity,
              child: headerText(
                  text: "Elige ${option.maxExtras} opciones",
                  fontWeight: FontWeight.w500,
                  fontsize: 14.0),
            )
          else
            SizedBox(
              width: double.infinity,
              child: headerText(
                  text: "Elige 1 opción",
                  fontWeight: FontWeight.w500,
                  fontsize: 14.0),
            ),
          const SizedBox(height: 5.0),
          ...option.extras.map((extra) => CheckboxListTile(
                title: Row(
                  children: [
                    headerText(
                        text: extra.title,
                        fontsize: 16.0,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    if (extra.price > 0)
                      Text("+ L ${extra.price.toStringAsFixed(2)}"),
                  ],
                ),
                value: _selectedExtras[option.title]!.contains(extra.title),
                onChanged: (isChecked) {
                  setState(() {
                    if (isChecked == true) {
                      if (option.maxExtras == 1) {
                        // Si solo se permite un extra, reemplaza el seleccionado anterior
                        _selectedExtras[option.title]!.clear();
                        _selectedExtras[option.title]!.add(extra.title);
                      } else {
                        // Si hay un límite mayor a 1, solo permite hasta maxExtras elementos
                        if (_selectedExtras[option.title]!.length <
                            option.maxExtras) {
                          _selectedExtras[option.title]!.add(extra.title);
                        }
                      }
                    } else {
                      // Si el usuario deselecciona, simplemente elimina el extra
                      _selectedExtras[option.title]!.remove(extra.title);
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              )),
        ],
      ),
    );
  }
}
