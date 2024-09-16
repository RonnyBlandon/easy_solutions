import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/managers/businessManager/Decodables/business_list_decodable.dart';
import 'package:easy_solutions/src/managers/businessManager/Interfaces/business_manager_interfaces.dart';
import 'package:easy_solutions/src/services/FirebaseServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/FirebaseServices/RealtimeDatabaseService/Services/realtime_database_service.dart';
import 'package:easy_solutions/src/services/GeolocationService/Interfaces/geolocation_service_interfaces.dart';
import 'package:easy_solutions/src/services/GeolocationService/Service/geolocation_helpers_service.dart';
import 'package:easy_solutions/src/services/GeolocationService/Service/mock_geolocation_service.dart';

class DefaultBusinessManager extends BusinessManager {
  final String _businessListPath = "businessList";

  // Dependencies
  final RealtimeDatabaseService _realtimeDatabaseService;
  final GeolocationService _geolocationService;
  final GeolocationHelpersService _geolocationHelpersService;

  DefaultBusinessManager(
      {RealtimeDatabaseService? realtimeDataBaseService,
      GeolocationService? geolocationService,
      GeolocationHelpersService? geolocationHelpersService})
      : _realtimeDatabaseService =
            realtimeDataBaseService ?? DefaultRealtimeDatabaseService(),
        _geolocationService = geolocationService ??
            MockGeolocationService(), // Bueno: DefaultGeolocationService() Mock: MockGeolocationService()
        _geolocationHelpersService =
            geolocationHelpersService ?? DefaultGeolocationHelpersService();

  @override
  Future<BusinessListDecodable> fetchBusinessList() async {
    try {
      final response =
          await _realtimeDatabaseService.getData(path: _businessListPath);
      final userPosition = await _geolocationService.getCurrentPosition();
      BusinessListDecodable decodable =
          _mapToDefaultBusinessManager(response: response);
      decodable.businessList =
          _mapMunicipalityPlaceList(businessList: decodable.businessList ?? []);

      return decodable;
    } on Failure catch (f) {
      return Future.error(f);
    }
  }

  @override
  Future<BusinessListDecodable> fetchNoveltyBusinessList() async {
    final fullBusinessList = await fetchBusinessList();
    fullBusinessList.businessList = _mapNoveltyBusinessList(
        businessList: fullBusinessList.businessList ?? []);
    return fullBusinessList;
  }

  @override
  Future<BusinessListDecodable> fetchPopularBusinessList() async {
    final fullBusinessList = await fetchBusinessList();
    fullBusinessList.businessList =
        _mapPopularPlaceList(businessList: fullBusinessList.businessList ?? []);
    return fullBusinessList;
  }

  @override
  Future<BusinessListDecodable> fetchBusinessListByCategory(
      {required int categoryId}) async {
    final fullBusinessList = await fetchBusinessList();
    fullBusinessList.businessList = _mapPlaceListByCategory(
        businessList: fullBusinessList.businessList ?? [],
        categoryId: categoryId);

    return fullBusinessList;
  }

  @override
  Future<BusinessListDecodable> fetchBusinessListByQuery(
      {required String query}) async {
    final fullBusinessList = await fetchBusinessList();
    fullBusinessList.businessList = _mapPlaceListByQuery(
        businessList: fullBusinessList.businessList ?? [], query: query);

    return fullBusinessList;
  }

  @override
  Future<BusinessListDecodable> fetchBusinessListByRecentSearches(
      {required List<String> businessIds}) async {
    final fullBusinessList = await fetchBusinessList();
    fullBusinessList.businessList = _mapPlaceListByRecentSearches(
        businessList: fullBusinessList.businessList ?? [],
        businessIds: businessIds);

    return fullBusinessList;
  }
}

extension Mappers on DefaultBusinessManager {
  BusinessListDecodable _mapToDefaultBusinessManager(
      {required Map<String, dynamic> response}) {
    List<BusinessList> businessList = [];
    response.forEach((key, value) {
      businessList.add(BusinessList.fromJson(value));
    });

    return BusinessListDecodable(businessList: businessList);
  }

  List<BusinessList> _mapMunicipalityPlaceList(
      {required List<BusinessList> businessList}) {
    List<BusinessList> businessListFiltered = [];
    businessList.forEach((place) {
      String municipality = "Barcelona";
      if (municipality == place.municipality) {
        businessListFiltered.add(place);
      }
    });
    return businessListFiltered;
  }

  List<BusinessList> _mapNoveltyBusinessList(
      {required List<BusinessList> businessList}) {
    List<BusinessList> businessListFiltered = [];
    businessList.forEach((place) {
      if (place.isNovelty) {
        businessListFiltered.add(place);
      }
    });
    return businessListFiltered;
  }

  List<BusinessList> _mapPopularPlaceList(
      {required List<BusinessList> businessList}) {
    List<BusinessList> businessListFiltered = [];
    businessList.forEach((place) {
      if (place.isPopularThisWeek) {
        businessListFiltered.add(place);
      }
    });
    return businessListFiltered;
  }

  List<BusinessList> _mapPlaceListByCategory(
      {required List<BusinessList> businessList, required int categoryId}) {
    List<BusinessList> businessListFiltered = [];
    businessList.forEach((place) {
      if (place.categoryId == categoryId) {
        businessListFiltered.add(place);
      }
    });
    return businessListFiltered;
  }

  List<BusinessList> _mapPlaceListByQuery(
      {required List<BusinessList> businessList, required String query}) {
    List<BusinessList> businessListFiltered = [];
    businessList.forEach((place) {
      if (query.isNotEmpty &&
          place.businessName.toLowerCase().contains(query.toLowerCase())) {
        businessListFiltered.add(place);
      }
    });
    return businessListFiltered;
  }

  List<BusinessList> _mapPlaceListByRecentSearches(
      {required List<BusinessList> businessList,
      required List<String> businessIds}) {
    List<BusinessList> businessListFiltered = [];
    for (var businessId in businessIds) {
      businessList.forEach((business) {
        if (business.businessId == businessId) {
          businessListFiltered.add(business);
        }
      });
    }
    return businessListFiltered;
  }
}
