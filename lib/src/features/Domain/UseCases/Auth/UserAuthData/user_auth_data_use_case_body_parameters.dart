class GetUserDataUseCaseParameters {
  GetUserDataUseCaseParameters({required this.accessToken});

  final String accessToken;

  Map<String, dynamic> toMap() => {
        "accessToken": accessToken,
      };
}
