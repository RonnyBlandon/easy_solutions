import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/carts_list_page/ViewModel/carts_list_view_model.dart';
import 'package:flutter/material.dart';

class CartsListContentView extends StatelessWidget with BaseView {
  final CartsListViewModel viewModel;
  CartsListContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
