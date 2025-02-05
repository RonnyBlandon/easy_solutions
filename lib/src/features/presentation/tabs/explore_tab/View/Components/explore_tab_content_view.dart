import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/tabs/explore_tab/View/Components/types_business_content_view.dart';
import 'package:easy_solutions/src/features/presentation/tabs/explore_tab/ViewModel/explore_tab_view_model.dart';
import 'package:flutter/material.dart';

class ExploreTabContentView extends StatelessWidget {
  final ExploreTabViewModel viewModel;
  const ExploreTabContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headerText(text: '¿Qué necesitas?'),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(
                      height: 5.0,
                    ),
                    const SizedBox(),
                    TypeBusinessListContentView(
                      typeBusinessList: viewModel.typeBusinessList,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
