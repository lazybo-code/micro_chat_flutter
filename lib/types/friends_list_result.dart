class FriendsListItemResult {
  String friends_remark;
  String friends_status;
  String friends_refusal;
  String friends_createdTime;
  String friends_updatedTime;
  String friends_description;
  String user_nickname;
  String user_username;
  String user_avatar;
  String user_signature;
  int userId;
  int friendId;

  FriendsListItemResult({
    this.friends_remark,
    this.friends_status,
    this.friends_refusal,
    this.friends_createdTime,
    this.friends_updatedTime,
    this.friends_description,
    this.user_nickname,
    this.user_username,
    this.user_avatar,
    this.user_signature,
    this.userId,
    this.friendId,
  });

  FriendsListItemResult.fromJson(Map<String, dynamic> json)
      : friends_remark = json['friends_remark'] ?? null,
        friends_status = json['friends_status'] ?? null,
        friends_refusal = json['friends_refusal'] ?? null,
        friends_createdTime = json['friends_createdTime'] ?? null,
        friends_updatedTime = json['friends_updatedTime'] ?? null,
        friends_description = json['friends_description'] ?? null,
        user_nickname = json['user_nickname'] ?? null,
        user_username = json['user_username'] ?? null,
        user_avatar = json['user_avatar'] ?? null,
        user_signature = json['user_signature'] ?? null,
        userId = json['userId'] ?? null,
        friendId = json['friendId'] ?? null;
}
