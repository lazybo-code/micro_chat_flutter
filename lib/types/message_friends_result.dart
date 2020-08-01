class MessageFriendsResult {
  Text _text;
  Image _image;
  Voice _voice;
  String _type;
  String _sId;
  int _userId;
  int _friendId;
  String _createTime;
  int _iV;
  User _user;
  int _count;

  MessageFriendsResult({
    Text text,
    Image image,
    Voice voice,
    String type,
    String sId,
    int userId,
    int friendId,
    String createTime,
    int iV,
    User user,
    int count,
  }) {
    this._text = text;
    this._image = image;
    this._voice = voice;
    this._type = type;
    this._sId = sId;
    this._userId = userId;
    this._friendId = friendId;
    this._createTime = createTime;
    this._iV = iV;
    this._user = user;
    this._count = count;
  }

  int get count => _count;

  set count(int count) => _count = count;

  Text get text => _text;

  set text(Text text) => _text = text;

  Image get image => _image;

  set image(Image image) => _image = image;

  Voice get voice => _voice;

  set voice(Voice voice) => _voice = voice;

  String get type => _type;

  set type(String type) => _type = type;

  String get sId => _sId;

  set sId(String sId) => _sId = sId;

  int get userId => _userId;

  set userId(int userId) => _userId = userId;

  int get friendId => _friendId;

  set friendId(int friendId) => _friendId = friendId;

  String get createTime => _createTime;

  set createTime(String createTime) => _createTime = createTime;

  int get iV => _iV;

  set iV(int iV) => _iV = iV;

  User get user => _user;

  set user(User user) => _user = user;

  MessageFriendsResult.fromJson(Map<String, dynamic> json) {
    _text = json['text'] != null ? new Text.fromJson(json['text']) : null;
    _image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    _voice = json['voice'] != null ? new Voice.fromJson(json['voice']) : null;
    _type = json['type'];
    _sId = json['_id'];
    _userId = json['userId'];
    _friendId = json['friendId'];
    _createTime = json['createTime'];
    _iV = json['__v'];
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._text != null) {
      data['text'] = this._text.toJson();
    }
    if (this._image != null) {
      data['image'] = this._image.toJson();
    }
    if (this._voice != null) {
      data['voice'] = this._voice.toJson();
    }
    data['type'] = this._type;
    data['_id'] = this._sId;
    data['userId'] = this._userId;
    data['friendId'] = this._friendId;
    data['createTime'] = this._createTime;
    data['__v'] = this._iV;
    data['count'] = this._count;
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    return data;
  }
}

class Text {
  String _text;

  Text({String text}) {
    this._text = text;
  }

  String get text => _text;

  set text(String text) => _text = text;

  Text.fromJson(Map<String, dynamic> json) {
    _text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this._text;
    return data;
  }
}

class Image {
  String _uri;
  String _thumbnail;

  Image({String uri, String thumbnail}) {
    this._uri = uri;
    this._thumbnail = thumbnail;
  }

  String get uri => _uri;

  set uri(String uri) => _uri = uri;

  String get thumbnail => _thumbnail;

  set thumbnail(String thumbnail) => _thumbnail = thumbnail;

  Image.fromJson(Map<String, dynamic> json) {
    _uri = json['uri'];
    _thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this._uri;
    data['thumbnail'] = this._thumbnail;
    return data;
  }
}

class Voice {
  String _uri;

  Voice({String uri}) {
    this._uri = uri;
  }

  String get uri => _uri;

  set uri(String uri) => _uri = uri;

  Voice.fromJson(Map<String, dynamic> json) {
    _uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this._uri;
    return data;
  }
}

class User {
  int _id;
  String _nickname;
  String _username;
  String _avatar;
  String _signature;
  String _remark;
  String _status;

  User(
      {int id,
        String nickname,
        String username,
        String avatar,
        String signature,
        String remark,
        String status}) {
    this._id = id;
    this._nickname = nickname;
    this._username = username;
    this._avatar = avatar;
    this._signature = signature;
    this._remark = remark;
    this._status = status;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get nickname => _nickname;
  set nickname(String nickname) => _nickname = nickname;
  String get username => _username;
  set username(String username) => _username = username;
  String get avatar => _avatar;
  set avatar(String avatar) => _avatar = avatar;
  String get signature => _signature;
  set signature(String signature) => _signature = signature;
  String get remark => _remark;
  set remark(String remark) => _remark = remark;
  String get status => _status;
  set status(String status) => _status = status;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nickname = json['nickname'];
    _username = json['username'];
    _avatar = json['avatar'];
    _signature = json['signature'];
    _remark = json['remark'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nickname'] = this._nickname;
    data['username'] = this._username;
    data['avatar'] = this._avatar;
    data['signature'] = this._signature;
    data['remark'] = this._remark;
    data['status'] = this._status;
    return data;
  }
}
