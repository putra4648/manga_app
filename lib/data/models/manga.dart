import 'package:equatable/equatable.dart';

class Manga extends Equatable {
  final num id;
  final String url;
  final String imageUrl;
  final String title;
  final bool isPublising;
  final String score;
  final String synopsis;
  final String type;
  final num chapters;
  final num volumes;
  final String startDate;
  final String endDate;

  const Manga({
    this.id = 0,
    this.url = '',
    this.imageUrl = '',
    this.title = '',
    this.isPublising = false,
    this.score = '',
    this.synopsis = '',
    this.type = '',
    this.chapters = 0,
    this.volumes = 0,
    this.startDate = '',
    this.endDate = '',
  });

  factory Manga.fromJson(dynamic json) {
    return Manga(
      chapters: json['chapters'] as num,
      id: json['mal_id'] as num,
      imageUrl: json['image_url'] as String,
      title: json['title'] as String,
      isPublising: json['publishing'] as bool,
      score: (json['score'] as num).toString(),
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      synopsis: json['synopsis'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      volumes: json['volumes'] as num,
    );
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
