import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final int rank;
  final String title;
  final String url;
  final String imageUrl;
  final List<Animeography> animeography;
  final List<Mangaography> mangaography;

  Character({
    this.id,
    this.rank,
    this.title,
    this.url,
    this.imageUrl,
    this.animeography,
    this.mangaography,
  });

  factory Character.fromJson(dynamic json) {
    final newAnimeography = <Animeography>[];
    final newMangaography = <Mangaography>[];

    json['animeography'].forEach((e) {
      newAnimeography.add(Animeography.fromJson(e));
    });

    json['mangaography'].forEach((e) {
      newMangaography.add(Mangaography.fromJson(e));
    });

    return Character(
      id: json['mal_id'] as int,
      rank: json['rank'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      imageUrl: json['image_url'] as String,
      animeography: newAnimeography,
      mangaography: newMangaography,
    );
  }
  @override
  List<Object> get props =>
      [id, rank, title, url, imageUrl, animeography, mangaography];
}

class Animeography extends Equatable {
  final int id;
  final String name;
  final String url;

  Animeography({this.id, this.name, this.url});

  factory Animeography.fromJson(dynamic json) {
    return Animeography(
      id: json['mal_id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  @override
  List<Object> get props => [id, name, url];
}

class Mangaography extends Equatable {
  final int id;
  final String name;
  final String url;

  Mangaography({this.id, this.name, this.url});

  factory Mangaography.fromJson(dynamic json) {
    return Mangaography(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
  @override
  List<Object> get props => [id, name, url];
}
