class UserLoginResult {
  String access_token;
  String refresh_token;

  UserLoginResult({this.access_token, this.refresh_token});

  UserLoginResult.fromJson(Map<String, dynamic> json)
      : access_token = json['access_token'] ?? null,
        refresh_token = json['refresh_token'] ?? null;

  Map<String, dynamic> toJson() =>
      {'access_token': access_token, 'refresh_token': refresh_token};
}
