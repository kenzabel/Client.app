import '/model/Info.dart';

/// info : [{"book":"http://dbpedia.org/resource/Havana_Storm","callret-1":"Havana Storm","name":"Clive Cussler","callret-3":"Havana Storm is a 2014 mystery novel written by international best-selling author Clive Cussler."},{"book":"http://dbpedia.org/resource/Harry_Potter_and_the_Chamber_of_Secrets","callret-1":"Harry Potter and the Chamber of Secrets","name":"J. K. Rowling","callret-3":"Harry Potter and the Chamber of Secrets is a fantasy novel written by British author J. K. Rowling and the second novel in the Harry Potter series. The plot follows Harry's second year at Hogwarts School of Witchcraft and Wizardry, during which a series of messages on the walls of the school's corridors warn that the \"Chamber of Secrets\" has been opened and that the \"heir of Slytherin\" would kill all pupils who do not come from all-magical families. These threats are found after attacks that leave residents of the school petrified. Throughout the year, Harry and his friends Ron and Hermione investigate the attacks. The book was published in the United Kingdom on 2 July 1998 by Bloomsbury and later in the United States on 2 June 1999 by Scholastic Inc. Although Rowling says she found it difficult to finish the book, it won high praise and awards from critics, young readers, and the book industry, although some critics thought the story was perhaps too frightening for younger children. Much like with other novels in the series, Harry Potter and the Chamber of Secrets triggered religious debates; some religious authorities have condemned its use of magical themes, whereas others have praised its emphasis on self-sacrifice and the way one's character is the result of one's choices. Several commentators have noted that personal identity is a strong theme in the book and that it addresses issues of racism through the treatment of non-human, non-magical, and non-living people. Some commentators regard the story's diary that writes back as a warning against uncritical acceptance of information from sources whose motives and reliability cannot be checked. Institutional authority is portrayed as self-serving and incompetent. The film adaptation of the novel, released in 2002, became (at the time) the fifth highest-grossing film ever and received generally favourable reviews. Video games loosely based on Harry Potter and the Chamber of Secrets were also released for several platforms, and most obtained favourable reviews."}]

class BooksInfo {
  BooksInfo({
    List<Info>? info,
  }) {
    _info = info;
  }

  BooksInfo.fromJson(dynamic json) {
    if (json['info'] != null) {
      _info = [];
      json['info'].forEach((v) {
        _info?.add(Info.fromJson(v));
      });
    }
  }
  List<Info>? _info;
  BooksInfo copyWith({
    List<Info>? info,
  }) =>
      BooksInfo(
        info: info ?? _info,
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
