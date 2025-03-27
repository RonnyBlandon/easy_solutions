import 'dart:convert';

import 'package:easy_solutions/src/features/data/Decodables/Address/address_decodable.dart';

class AddressListBodyParameters {
  final List<AddressBodyParameters> addressList;

  AddressListBodyParameters({required this.addressList});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "address_list": List<dynamic>.from(addressList.map((x) => x.toMap())),
  };

  factory AddressListBodyParameters.fromMap(Map<String, dynamic> json) =>
      AddressListBodyParameters(
        addressList:
            json["address_list"] == null
                ? []
                : List<AddressBodyParameters>.from(
                  (json["address_list"] as List<dynamic>).map(
                    (x) => AddressBodyParameters.fromMap(x),
                  ),
                ),
      );

  static AddressListBodyParameters getEmptyPaymentMethods() {
    return AddressListBodyParameters(addressList: []);
  }
}

class AddressBodyParameters {
  int id;
  String alias;
  String address;
  String reference;
  String sector;
  double latitude;
  double longitude;
  bool isMainAddress;
  int municipalityId;
  Municipality? municipality;

  AddressBodyParameters({
    required this.id,
    required this.alias,
    required this.address,
    required this.reference,
    required this.sector,
    required this.latitude,
    required this.longitude,
    required this.isMainAddress,
    required this.municipalityId,
    required this.municipality,
  });

  factory AddressBodyParameters.fromMap(Map<String, dynamic> json) =>
      AddressBodyParameters(
        id: json["id"],
        alias: json["alias"],
        address: json["address"],
        reference: json["reference"],
        sector: json["sector"],
        latitude: double.parse(json["latitude"].toString()),
        longitude: double.parse(json["longitude"].toString()),
        isMainAddress: json["is_main_address"],
        municipalityId: json["municipality_id"],
        municipality:
            json["municipality"] == null
                ? null
                : Municipality.fromMap(json["municipality"]),
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "alias": alias,
    "address": address,
    "reference": reference,
    "sector": sector,
    "latitude": latitude,
    "longitude": longitude,
    "is_main_address": isMainAddress,
    "municipality_id": municipalityId,
    "municipality": municipality?.toMap(),
  };
}
