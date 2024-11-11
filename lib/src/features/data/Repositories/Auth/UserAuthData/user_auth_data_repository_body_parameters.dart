class GetUserDataBodyParameters {
  GetUserDataBodyParameters({required this.accessToken});

  final String accessToken;

  Map<String, dynamic> toMap() => {
        "idToken": accessToken,
      };
}
