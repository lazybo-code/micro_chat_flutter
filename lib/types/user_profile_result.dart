class UserProfileResult {
  String type;
  int id;
  String nickname;
  String username;
  String avatar;
  String signature;
  String createdTime;
  String updatedTime;
  String deletedTime;
  int pttl;

  UserProfileResult({
    this.id,
    this.type,
    this.nickname,
    this.username,
    this.avatar,
    this.createdTime,
    this.deletedTime,
    this.pttl,
    this.signature,
    this.updatedTime,
  });

  UserProfileResult.fromJson(Map<String, dynamic> json)
      : type = json['type'] ?? null,
        id = json['id'] ?? null,
        nickname = json['nickname'] ?? null,
        username = json['username'] ?? null,
        avatar = json['avatar'] ?? null,
        signature = json['signature'] ?? null,
        createdTime = json['createdTime'] ?? null,
        updatedTime = json['updatedTime'] ?? null,
        deletedTime = json['deletedTime'] ?? null,
        pttl = json['pttl'] ?? null;

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'nickname': nickname,
        'username': username,
        'avatar': avatar,
        'signature': signature,
        'createdTime': createdTime,
        'updatedTime': updatedTime,
        'deletedTime': deletedTime,
        'pttl': pttl,
      };
}
