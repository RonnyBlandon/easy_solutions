import 'dart:convert';

class AuthErrorDecodable {
  String? detailMessage;
  List<AuthErrorDetail>? detailErrors;

  AuthErrorDecodable({
    this.detailMessage,
    this.detailErrors,
  });

  factory AuthErrorDecodable.fromJson(String str) =>
      AuthErrorDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthErrorDecodable.fromMap(Map<String, dynamic> json) {
    // Detecta si 'detail' es un String o una lista de errores
    if (json["detail"] is String) {
      return AuthErrorDecodable(
        detailMessage: json["detail"],
      );
    } else if (json["detail"] is List) {
      return AuthErrorDecodable(
        detailErrors: List<AuthErrorDetail>.from(
          json["detail"].map((x) => AuthErrorDetail.fromMap(x)),
        ),
      );
    } else {
      return AuthErrorDecodable();
    }
  }

  Map<String, dynamic> toMap() => {
        "detailMessage": detailMessage,
        "detailErrors": detailErrors?.map((e) => e.toMap()).toList(),
      };
}

class AuthErrorDetail {
  List<dynamic>? loc;
  String? msg;
  String? type;

  AuthErrorDetail({
    this.loc,
    this.msg,
    this.type,
  });

  factory AuthErrorDetail.fromJson(String str) =>
      AuthErrorDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthErrorDetail.fromMap(Map<String, dynamic> json) => AuthErrorDetail(
        loc: json["loc"] == null ? null : List<dynamic>.from(json["loc"]),
        msg: json["msg"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "loc": loc,
        "msg": msg,
        "type": type,
      };
}
