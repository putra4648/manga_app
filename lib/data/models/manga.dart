import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Manga extends Equatable {
  final num id;
  final String url;
  final String imageUrl;
  final String title;
  final bool isPublising;
  final double score;
  final String synopsis;
  final String type;
  final num chapters;
  final num volumes;
  final String startDate;

  const Manga({
    this.id = 0,
    this.url = '',
    this.imageUrl = '',
    this.title = '',
    this.isPublising = false,
    this.score = 0,
    this.synopsis = '',
    this.type = '',
    this.chapters = 0,
    this.volumes = 0,
    this.startDate = '',
  });

  factory Manga.fromJson(dynamic json) {
    return Manga(
      chapters: json['chapters'] as num,
      id: json['mal_id'] as num,
      imageUrl: json['image_url'] as String,
      title: json['title'] as String,
      isPublising: json['publishing'] as bool,
      // score: (json['score'] as num).toDouble() ?? 0.0,
      startDate: json['start_date'] as String,
      synopsis: json['synopsis'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      volumes: json['volumes'] as num,
    );
  }

  Map<String, dynamic> toJson(Manga manga, Uint8List byteImages) {
    return {
      'mal_id': manga.id,
      'url': manga.url,
      'image_url': manga.imageUrl,
      'title': manga.title,
      'publishing': manga.isPublising,
      'synopsis': manga.synopsis,
      'type': manga.type,
      'chapters': manga.chapters,
      'volumes': manga.volumes,
      'score': manga.score,
      'start_date': manga.startDate,
      'local_images': byteImages,
    };
  }

  @override
  List<Object> get props => [
        id,
        url,
        imageUrl,
        title,
        isPublising,
        score,
        synopsis,
        type,
        chapters,
        volumes,
        startDate
      ];
}
