import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:easy_solutions/src/features/presentation/search_page/View/Components/search_build_results_view.dart';
import 'package:easy_solutions/src/features/presentation/search_page/View/Components/search_suggestions_view.dart';
import 'package:easy_solutions/src/features/presentation/search_page/ViewModel/search_view_model.dart';
import 'package:flutter/material.dart';

class SearchPage extends SearchDelegate with BaseView {
  final String businessId;
  final SearchViewModel viewModel;

  SearchPage({required this.businessId, SearchViewModel? searchViewModel})
      : viewModel = searchViewModel ?? DefaultSearchViewModel();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: viewModel.fetchProductListByQuery(
            businessId: businessId, query: query),
        builder:
            (BuildContext context, AsyncSnapshot<ProductListEntity> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingView;
            case ConnectionState.done:
              if (snapshot.hasError || !snapshot.hasData) {
                return ErrorView(
                  onButtonPressed: () {
                    coordinator.showTabsPage(context: context);
                  },
                );
              }
              if (snapshot.data?.productList?.isEmpty ?? true) {
                return SearchSuggestionsView(businessId: businessId,
                                            textHeader: 'No se encontraron resultados', 
                                            textAction: '',
                                            isRecentSearchSuggestions: false,
                                            viewModel: viewModel);
              } else {
                return SearchBuildResultsView(products: snapshot.data?.productList ?? []);
              }
            default:
              return loadingView;
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return SearchSuggestionsView(businessId: businessId,
                                  textHeader: 'Visto recientemente', 
                                  textAction: 'Borrar Todo',
                                  isRecentSearchSuggestions: true,
                                  viewModel: viewModel);
    } else {
      return Container();
    }
  }
}