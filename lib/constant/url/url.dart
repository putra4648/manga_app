class Url {
  static Url url = Url();

  // Manga
  String season = 'https://api.jikan.moe/v3/season';
  String mangaSearch =
      'https://api.jikan.moe/v3/search/manga?q={search}&page=1';
  String top = 'https://api.jikan.moe/v3/top/{type}/1';

  // Character
  String character = 'https://api.jikan.moe/v3/top/characters/1';
}
