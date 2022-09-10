/// uri : "http://dbpedia.org/resource/2010:_Odyssey_Two"
/// title : "2010: Odyssey Two"
/// author : "Arthur C. Clarke"
/// genre : "Science fiction"
/// abstract : "2010: Odyssey Two is a 1982 science fiction novel by British writer Arthur C. Clarke. It is the sequel to his 1968 novel 2001: A Space Odyssey, though Clarke changed some elements of the story to align with the film version of 2001. Set in the year 2010, the plot centres on a joint Soviet-US mission aboard the Soviet spacecraft The Cosmonaut Alexei Leonov. The mission has several objectives, including salvaging the spaceship Discovery and investigating the mysterious  monolith  discovered by Dave Bowman in 2001: A Space Odyssey. It was nominated for the Hugo Award for Best Novel in 1983. The novel was adapted for the screen by Peter Hyams and released as a film in 1984. The story is set nine years after the failure of the Discovery One mission to Jupiter. "

class BooksData {
  BooksData({
    String? uri,
    String? title,
    String? author,
    String? genre,
    String? abstract,
    bool? isFavorite,
  }) {
    _uri = uri;
    _title = title;
    _author = author;
    _genre = genre;
    _abstract = abstract;
    _isFavorite = isFavorite;
  }

  BooksData.fromJson(dynamic json) {
    _uri = json['uri'];
    _title = json['title'];
    _author = json['author'];
    _genre = json['genre'];
    _abstract = json['abstract'];
    _isFavorite = json['isFavorite'];
  }
  String? _uri;
  String? _title;
  String? _author;
  String? _genre;
  String? _abstract;
  bool? _isFavorite;
  BooksData copyWith({
    String? uri,
    String? title,
    String? author,
    String? genre,
    String? abstract,
    bool? isFavorite,
  }) =>
      BooksData(
        uri: uri ?? _uri,
        title: title ?? _title,
        author: author ?? _author,
        genre: genre ?? _genre,
        abstract: abstract ?? _abstract,
        isFavorite: isFavorite ?? _isFavorite,
      );
  String? get uri => _uri;
  String? get title => _title;
  String? get author => _author;
  String? get genre => _genre;
  String? get abstract => _abstract;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uri'] = _uri;
    map['title'] = _title;
    map['author'] = _author;
    map['genre'] = _genre;
    map['abstract'] = _abstract;
    map['isFavorite'] = _isFavorite;
    return map;
  }
}
