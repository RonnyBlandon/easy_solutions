import 'dart:convert';

import 'package:easy_solutions/src/features/data/Decodables/Address/address_decodable.dart';
import 'package:easy_solutions/src/features/data/Repositories/Address/BodyParameters/delivery_address_body_parameters.dart';

class AddressListEntity {
  List<AddressEntity> addressList;

  AddressListEntity({required this.addressList});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "address_list": List<dynamic>.from(addressList.map((x) => x.toMap())),
  };

  factory AddressListEntity.fromMap(Map<String, dynamic> json) =>
      AddressListEntity(
        addressList:
            json["address_list"] == null
                ? []
                : List<AddressEntity>.from(
                  (json["address_list"] as List<dynamic>).map(
                    (x) => AddressEntity.fromMap(x),
                  ),
                ),
      );

  bool hasAddress() {
    return addressList.isNotEmpty;
  }

  AddressListBodyParameters getAddressListBodyParameters() {
    return AddressListBodyParameters.fromMap(toMap());
  }

  updateMainAddress({required int id}) {
    addressList =
        addressList.map((address) {
          address.isMainAddress = address.id == id ? true : false;
          return address;
        }).toList();
  }
}

class AddressEntity {
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

  AddressEntity({
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

  bool isValidAddress() {
    if (alias.isEmpty ||
        address.isEmpty ||
        latitude == 0.0 ||
        longitude == 0.0 ||
        reference.isEmpty ||
        sector.isEmpty ||
        municipality == null ||
        municipalityId == -1) {
      return false;
    } else {
      return true;
    }
  }

  static AddressEntity getEmptyAddress() {
    return AddressEntity(
      id: 0,
      alias: "",
      address: "",
      latitude: 0.0,
      longitude: 0.0,
      reference: "",
      sector: "",
      municipality: Municipality(),
      isMainAddress: false,
      municipalityId: 0,
    );
  }

  factory AddressEntity.fromMap(Map<String, dynamic> json) => AddressEntity(
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

  AddressBodyParameters getAddressBodyParameters() {
    return AddressBodyParameters.fromMap(toMap());
  }
}
