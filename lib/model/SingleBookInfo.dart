/// info : [{"book":"http://dbpedia.org/resource/Havana_Storm","callret-1":"Havana Storm","name":"Clive Cussler","callret-3":"Havana Storm is a 2014 mystery novel written by international best-selling author Clive Cussler."}]

class SingleBookInfo {
  SingleBookInfo({
      List<Info>? info,}){
    _info = info;
}

  SingleBookInfo.fromJson(dynamic json) {
    if (json['info'] != null) {
      _info = [];
      json['info'].forEach((v) {
        _info?.add(Info.fromJson(v));
      });
    }
  }
  List<Info>? _info;
SingleBookInfo copyWith({  List<Info>? info,
}) => SingleBookInfo(  info: info ?? _info,
);
  List<Info>? get info => _info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_info != null) {
      map['info'] = _info?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// book : "http://dbpedia.org/resource/Havana_Storm"
/// callret-1 : "Havana Storm"
/// name : "Clive Cussler"
/// callret-3 : "Havana Storm is a 2014 mystery novel written by international best-selling author Clive Cussler."

class Info {
  Info({
      String? book, 
      String? callret1, 
      String? name, 
      String? callret3,}){
    _book = book;
    _callret1 = callret1;
    _name = name;
    _callret3 = callret3;
}

  Info.fromJson(dynamic json) {
    _book = json['book'];
    _callret1 = json['callret-1'];
    _name = json['name'];
    _callret3 = json['callret-3'];
  }
  String? _book;
  String? _callret1;
  String? _name;
  String? _callret3;
Info copyWith({  String? book,
  String? callret1,
  String? name,
  String? callret3,
}) => Info(  book: book ?? _book,
  callret1: callret1 ?? _callret1,
  name: name ?? _name,
  callret3: callret3 ?? _callret3,
);
  String? get book => _book;
  String? get callret1 => _callret1;
  String? get name => _name;
  String? get callret3 => _callret3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['book'] = _book;
    map['callret-1'] = _callret1;
    map['name'] = _name;
    map['callret-3'] = _callret3;
    return map;
  }

}