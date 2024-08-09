import 'dart:convert';

class CorrectPostBodyParams {
  String? tittle;
  String? body;
  int? userId;

  CorrectPostBodyParams({
    this.tittle,
    this.body,
    this.userId,
  });

  factory CorrectPostBodyParams.fromJson(String str) =>
      CorrectPostBodyParams.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CorrectPostBodyParams.fromMap(Map<String, dynamic> json) =>
      CorrectPostBodyParams(
        tittle: json["tittle"],
        body: json["body"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "tittle": tittle,
        "body": body,
        "userId": userId,
      };
}

class CorrectPutBodyParams {
  int? id;
  String? tittle;
  String? body;
  int? userId;

  CorrectPutBodyParams({
    this.id,
    this.tittle,
    this.body,
    this.userId,
  });

  factory CorrectPutBodyParams.fromJson(String str) =>
      CorrectPutBodyParams.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CorrectPutBodyParams.fromMap(Map<String, dynamic> json) =>
      CorrectPutBodyParams(
        id: json["id"],
        tittle: json["tittle"],
        body: json["body"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tittle": tittle,
        "body": body,
        "userId": userId,
      };
}
