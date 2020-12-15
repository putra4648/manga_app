import 'package:manga_app/constant/constant.dart';

class EnumDefinition {
  static String typeDefinition(Type type) {
    String typeOfString;
    switch (type) {
      case Type.anime:
        typeOfString = 'anime';
        break;
      case Type.manga:
        typeOfString = 'manga';
        break;
      case Type.people:
        typeOfString = 'people';
        break;
      case Type.characters:
        typeOfString = 'characters';
        break;
      default:
        typeOfString = null;
        break;
    }
    return typeOfString;
  }
}

class MangaDefnition {
  static String mangaSubtypeDefinition(MangaSubtype mangaSubtype) {
    String typeOfDefinition;
    switch (mangaSubtype) {
      case MangaSubtype.manga:
        typeOfDefinition = 'manga';
        break;
      case MangaSubtype.doujin:
        typeOfDefinition = 'doujin';
        break;
      case MangaSubtype.manhua:
        typeOfDefinition = 'manhua';
        break;
      case MangaSubtype.manhwa:
        typeOfDefinition = 'manhwa';
        break;
      case MangaSubtype.novels:
        typeOfDefinition = 'novels';
        break;
      case MangaSubtype.oneshots:
        typeOfDefinition = 'oneshots';
        break;
    }
    return typeOfDefinition;
  }
}

class AnimeDefinition {
  static String animeDefinition(AnimeSubtype animeSubtype) {
    String typeOfDefinition;
    switch (animeSubtype) {
      case AnimeSubtype.airing:
        typeOfDefinition = 'airing';
        break;
      case AnimeSubtype.movie:
        typeOfDefinition = 'movie';
        break;
      case AnimeSubtype.ova:
        typeOfDefinition = 'ova';
        break;
      case AnimeSubtype.special:
        typeOfDefinition = 'special';
        break;
      case AnimeSubtype.tv:
        typeOfDefinition = 'tv';
        break;
      case AnimeSubtype.upcoming:
        typeOfDefinition = 'upcoming';
        break;
    }
    return typeOfDefinition;
  }
}
