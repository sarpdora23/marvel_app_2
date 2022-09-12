class ComicDataWrapper {
  late int _code;
  late String _status;
  late String _attributionText;
  late String _attributionHTML;
  late String _etag;
  late ComicDataContainer _data;
  ComicDataWrapper(
      this._code, this._status, this._attributionText, this._etag, this._data);
  int getCode() {
    return this._code;
  }

  String getStatus() {
    return this._status;
  }

  String getAttributionText() {
    return this._attributionText;
  }

  String getAttributionHtml() {
    return this._attributionHTML;
  }

  String getEtag() {
    return this._etag;
  }

  ComicDataContainer getData() {
    return this._data;
  }
}

class ComicDataContainer {
  late int offset;
  late int limit;
  late int total;
  late int count;
  late List<Comic> results;
}

class Comic {
  late String title;
  late String desc;
  late Image thumbnail;
  late CharacterList characters;
  late CreatorList creators;
  late List<ComicDate> dates;
}

class ComicDate {
  late String type;
  // late DateTime date;
}

class CreatorList {
  late int available;
  late int returned;
  late String collectionURI;
  late List<CreatorSummary> items;
}

class CreatorSummary {
  late String resourceURI;
  late String name;
  late String role;
}

class CharacterList {
  late int available;
  late int returned;
  late String collectionURI;
  late List<CharacterSummary> items;
}

class CharacterSummary {
  late String resourceURI;
  late String name;
  late String role;
}

class Image {
  late String path;
  late String extension;
}
