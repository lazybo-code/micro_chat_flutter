class MessageNewsResult {
  Text _text;
  String _type;
  String _sId;
  int _userId;
  int _friendId;
  String _createTime;
  int _iV;

  MessageNewsResult({
    Text text,
    String type,
    String sId,
    int userId,
    int friendId,
    String createTime,
    int iV,
  }) {
    this._text = text;
    this._type = type;
    this._sId = sId;
    this._userId = userId;
    this._friendId = friendId;
    this._createTime = createTime;
    this._iV = iV;
  }

  Text get text => _text;

  set text(Text text) => _text = text;

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

  MessageNewsResult.fromJson(Map<String, dynamic> json) {
    _text = json['text'] != null ? new Text.fromJson(json['text']) : null;
    _type = json['type'];
    _sId = json['_id'];
    _userId = json['userId'];
    _friendId = json['friendId'];
    _createTime = json['createTime'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._text != null) {
      data['text'] = this._text.toJson();
    }
    data['type'] = this._type;
    data['_id'] = this._sId;
    data['userId'] = this._userId;
    data['friendId'] = this._friendId;
    data['createTime'] = this._createTime;
    data['__v'] = this._iV;
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
