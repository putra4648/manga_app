class Url {
  static Url url = Url();

  // Manga
  String mangaSearch =
      'https://api.jikan.moe/v3/search/manga?q={search}&page=1';
  String topManga = 'https://api.jikan.moe/v3/top/manga/1';
  String topMangaWithSubtype =
      'https://api.jikan.moe/v3/top/manga/1/subtype={type}';
}
