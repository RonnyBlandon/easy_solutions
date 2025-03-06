import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/business_category_page/View/Components/business_category_content_view.dart';
import 'package:easy_solutions/src/features/presentation/business_category_page/ViewModel/business_category_view_model.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/main_search.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';

class BusinessCategoryPage extends StatefulWidget with BaseView {
  final int businessCategoryId;
  final String businessId;
  final BusinessCategoryViewModel viewModel;
  BusinessCategoryPage(
      {super.key,
      required this.businessCategoryId,
      required this.businessId,
      BusinessCategoryViewModel? businessCategoryviewModel})
      : viewModel =
            businessCategoryviewModel ?? DefaultBusinessCategoryViewModel();

  @override
  State<BusinessCategoryPage> createState() => _BusinessCategoryPageState();
}

class _BusinessCategoryPageState extends State<BusinessCategoryPage> {
  late Future<BusinessCategoryViewModelState> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.viewModel
        .viewInitState(businessCategoryId: widget.businessCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          toolbarHeight:
              screenHeight.getScreenHeight(context: context, multiplier: 0.1),
          leading: backButton(context, black),
          actions: [searchProduct(context: context, businessId: widget.businessId)],
        ),
        body: FutureBuilder(
          future: _future, // Usamos el Future almacenado
          builder: (BuildContext context,
              AsyncSnapshot<BusinessCategoryViewModelState> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return widget.loadingView;
              case ConnectionState.done:
                switch (snapshot.data) {
                  case BusinessCategoryViewModelState.viewLoadedState:
                    return BusinessCategoryContentView(viewModel: widget.viewModel);
                  default:
                    return ErrorView(
                      onButtonPressed: () {
                        MainCoordinator().showTabsPage(context: context);
                      },
                    );
                }
              default:
                return widget.loadingView;
            }
          },
        ),
      ),
    );
  }
}