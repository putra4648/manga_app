import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/data/models/models.dart';

class DetailSearchScreen extends StatelessWidget {
  final Manga anime;

  const DetailSearchScreen({Key key, @required this.anime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(anime.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.6,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black38, BlendMode.darken),
                  image: CachedNetworkImageProvider(anime.imageUrl),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Synopsis',
                      style: Theme.of(context).textTheme.headline4),
                  Divider(color: Colors.white),
                  Text(anime.synopsis),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Detail Info',
                      style: Theme.of(context).textTheme.headline4),
                  Divider(color: Colors.white),
                  Text('Volumes : ' + anime.volumes.toString()),
                  Text('Chapters: ' + anime.chapters.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
