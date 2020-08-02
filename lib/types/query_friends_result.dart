class QueryFriendsResult {
  int user_id;
  String user_nickname;
  String user_username;
  String user_avatar;
  String user_signature;
  String friend_remark;
  String friend_status;

  QueryFriendsResult({
    this.user_avatar,
    this.user_signature,
    this.user_username,
    this.user_nickname,
    this.friend_remark,
    this.friend_status,
    this.user_id,
  });

  QueryFriendsResult.fromJson(Map<String, dynamic> json)
      : user_avatar = json['user_avatar'] ?? null,
        user_signature = json['user_signature'] ?? null,
        user_username = json['user_username'] ?? null,
        user_nickname = json['user_nickname'] ?? null,
        friend_remark = json['friend_remark'] ?? null,
        friend_status = json['friend_status'] ?? null,
        user_id = json['user_id'] ?? null;
}
