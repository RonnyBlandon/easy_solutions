import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/managers/businessManager/Decodables/business_list_decodable.dart';
import 'package:easy_solutions/src/managers/businessManager/Interfaces/business_manager_interfaces.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';
import 'package:easy_solutions/src/services/GeolocationService/Interfaces/geolocation_service_interfaces.dart';

class DefaultBusinessManager extends BusinessManager {
  final String _businessListPath = "businesses/";
  final String _typesBusinessPath = "businesses/types_business/";
  //final double _distanceRange = 10.0;

  // Dependencies
  final RealtimeDatabaseService _realtimeDatabaseService;
  //final GeolocationHelpersService _geolocationHelpersService;

  DefaultBusinessManager(
      {RealtimeDatabaseService? realtimeDataBaseService,
      GeolocationService? geolocationService,
      GeolocationHelpersService? geolocationHelpersService})
      : _realtimeDatabaseService =
            realtimeDataBaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<TypeBusinessListDecodable> fetchTypeBusinessList() async {
    try {
      final response =
          await _realtimeDatabaseService.getData(path: _typesBusinessPath, requiresAuth: false);
      TypeBusinessListDecodable decodable = TypeBusinessListDecodable.fromMap(response);
      return decodable;
    } on Failure catch (f) {
      return Future.error(f);
    }
  }

  @override
  Future<BusinessListDecodable> fetchBusinessList() async {
    try {
      final response =
          await _realtimeDatabaseService.getData(path: _businessListPath, requiresAuth: false);
      BusinessListDecodable decodable = BusinessListDecodable.fromMap(response);
      decodable.businessList = _mapMunicipalityBusinessList(
          businessList: decodable.businessList ?? [], municipalityId: 1);
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
    fullBusinessList.businessList = _mapPopularBusinessList(
        businessList: fullBusinessList.businessList ?? []);
    return fullBusinessList;
  }

  @override
  Future<BusinessListDecodable> fetchBusinessListByTypeBusiness(
      {required int typeBusinessId}) async {
    String path = _typesBusinessPath + typeBusinessId.toString();
    try {
      final response =
          await _realtimeDatabaseService.getData(path: path, requiresAuth: false);
      BusinessListDecodable decodable = BusinessListDecodable.fromMap(response);
      decodable.businessList = _mapMunicipalityBusinessList(
          businessList: decodable.businessList ?? [], municipalityId: 1);
      return decodable;
    } on Failure catch (f) {
      return Future.error(f);
    }
  }

  @override
  Future<BusinessListDecodable> fetchBusinessListByQuery(
      {required String query}) async {
    final fullBusinessList = await fetchBusinessList();
    fullBusinessList.businessList = _mapBusinessListByQuery(
        businessList: fullBusinessList.businessList ?? [], query: query);
    return fullBusinessList;
  }

  @override
  Future<BusinessListDecodable> fetchBusinessListByRecentSearches(
      {required List<String> businessIds}) async {
    final fullBusinessList = await fetchBusinessList();
    fullBusinessList.businessList = _mapBusinessListByRecentSearches(
        businessList: fullBusinessList.businessList ?? [],
        businessIds: businessIds);
    return fullBusinessList;
  }
}

extension Mappers on DefaultBusinessManager {
  List<BusinessDetailDecodable> _mapMunicipalityBusinessList(
      {required List<BusinessDetailDecodable> businessList,
      required int municipalityId}) {
    List<BusinessDetailDecodable> businessListFiltered = [];
    businessList.forEach((business) {
      if (business.municipalityId == municipalityId) {
        businessListFiltered.add(business);
      }
    });
    return businessListFiltered;
  }

  List<BusinessDetailDecodable> _mapNoveltyBusinessList(
      {required List<BusinessDetailDecodable> businessList}) {
    List<BusinessDetailDecodable> businessListFiltered = [];
    businessList.forEach((business) {
      if (business.isNovelty) {
        businessListFiltered.add(business);
      }
    });
    return businessListFiltered;
  }

  List<BusinessDetailDecodable> _mapPopularBusinessList(
      {required List<BusinessDetailDecodable> businessList}) {
    List<BusinessDetailDecodable> businessListFiltered = [];
    businessList.forEach((business) {
      if (business.isPopularThisWeek) {
        businessListFiltered.add(business);
      }
    });
    return businessListFiltered;
  }

  List<BusinessDetailDecodable> _mapBusinessListByQuery(
      {required List<BusinessDetailDecodable> businessList,
      required String query}) {
    List<BusinessDetailDecodable> businessListFiltered = [];
    businessList.forEach((business) {
      if (query.isNotEmpty &&
          business.businessName.toLowerCase().contains(query.toLowerCase())) {
        businessListFiltered.add(business);
      }
    });
    return businessListFiltered;
  }

  List<BusinessDetailDecodable> _mapBusinessListByRecentSearches(
      {required List<BusinessDetailDecodable> businessList,
      required List<String> businessIds}) {
    List<BusinessDetailDecodable> businessListFiltered = [];
    for (var businessId in businessIds) {
      businessList.forEach((business) {
        if (business.id == businessId) {
          businessListFiltered.add(business);
        }
      });
    }
    return businessListFiltered;
  }
}
