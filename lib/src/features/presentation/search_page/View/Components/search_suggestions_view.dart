import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/texts/DoubleTextView/View/double_text_view.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:easy_solutions/src/features/presentation/search_page/View/Components/recent_search_carrousel_view.dart';
import 'package:easy_solutions/src/features/presentation/search_page/ViewModel/search_view_model.dart';
import 'package:flutter/material.dart';

class SearchSuggestionsView extends StatefulWidget {
  final String businessId;
  final String textHeader;
  final String textAction;
  final Function()? textActionTapped;
  final bool isRecentSearchSuggestions;
  final SearchViewModel viewModel;

  const SearchSuggestionsView({ super.key,
                              required this.businessId,
                              required this.textHeader,
                              required this.textAction,
                              required this.isRecentSearchSuggestions,
                              required this.viewModel,
                              this.textActionTapped});

  @override
  State<SearchSuggestionsView> createState() => _SearchSuggestionsViewState();
}

class _SearchSuggestionsViewState extends State<SearchSuggestionsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: SearchPageSuggestionsListView(
                businessId: widget.businessId,
                textHeader: widget.textHeader,
                textAction: widget.textAction,
                isRecentSearchSuggestions: widget.isRecentSearchSuggestions,
                viewModel: widget.viewModel,
                textActionTapped: () {
                  setState(() {
                    widget.viewModel.clearRecentProductSearchInLocalStorage(businessId: widget.businessId);
                  });
                }));
  }
}

class SearchPageSuggestionsListView extends StatelessWidget with BaseView {
  final String businessId;
  final String textHeader;
  final String textAction;
  final Function()? textActionTapped;
  final bool isRecentSearchSuggestions;
  final SearchViewModel viewModel;

  SearchPageSuggestionsListView({ super.key,
                                  required this.businessId,
                                  required this.textHeader,
                                  required this.textAction,
                                  required this.isRecentSearchSuggestions,
                                  required this.viewModel,
                                  this.textActionTapped });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.fetchProductListByRecentSearches(businessId: businessId),
        builder:
            (BuildContext context, AsyncSnapshot<ProductListEntity> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingView;
            case ConnectionState.done:
              if (snapshot.hasError || !snapshot.hasData) {
                return ErrorView(onButtonPressed: () {coordinator.showTabsPage(context: context);},);
              }

              return Column(
                children: [
                  const SizedBox(height: 20.0),
                  DoubleTextView(
                      textHeader: textHeader,
                      textAction: textAction,
                      textActionTapped: textActionTapped),
                  if (!isRecentSearchSuggestions) ...[
                    const Divider(),
                    const SizedBox(height: 20.0),
                    headerText(text: "Visto recientemente", fontsize: 20.0),
                  ], 
                  RecentSearchCarrouselView(productList: snapshot.data?.productList ?? [])
                ],
              );
            default:
              return loadingView;
          }
        });
  }
}

