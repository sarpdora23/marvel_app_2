class UserModel {
  late String username;
  late String email;
  late String password;
  late String? imageURL;
  late List favs;
  late List reviews;
  late List comicLists;
  late List diary;
  late List watchlist;
  late List activity;
  late List comments;

  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      this.imageURL,
      this.favs = const [],
      this.reviews = const [],
      this.comicLists = const [],
      this.diary = const [],
      this.watchlist = const [],
      this.activity = const [],
      this.comments = const []});
}

class UserPreview {
  late String username;
  late String? imageURL;
  late List favs;
  late List reviews;
  late List comicLists;
  late List diary;
  late List watchlist;
  late List activity;
  late List comments;

  UserPreview(
      {required this.username,
      this.imageURL,
      this.favs = const [],
      this.reviews = const [],
      this.comicLists = const [],
      this.diary = const [],
      this.watchlist = const [],
      this.activity = const [],
      this.comments = const []});
}
