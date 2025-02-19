import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/MainCoordinator/main_coordinator.dart';
import 'package:easy_solutions/src/features/presentation/business_page/View/Components/business_content_view.dart';
import 'package:easy_solutions/src/features/presentation/business_page/ViewModel/business_categories_view_model.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/main_search.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';

class BusinessPage extends StatefulWidget with BaseView {
  final String businessId;
  final BusinessCategoriesViewModel viewModel;
  BusinessPage(
      {super.key,
      required this.businessId,
      BusinessCategoriesViewModel? businessCategoriesviewModel})
      : viewModel =
            businessCategoriesviewModel ?? DefaultBusinessCategoriesViewModel();

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  late Future<BusinessCategoriesViewModelState> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.viewModel.viewInitState(businessId: widget.businessId);
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
            future: _future, // 🔹 Usa el Future almacenado
            builder: (BuildContext context,
                AsyncSnapshot<BusinessCategoriesViewModelState> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return widget.loadingView;
                case ConnectionState.done:
                  switch (snapshot.data) {
                    case BusinessCategoriesViewModelState.viewLoadedState:
                      return BusinessContentView(viewModel: widget.viewModel);
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
            }),
      ),
    );
  }
}
