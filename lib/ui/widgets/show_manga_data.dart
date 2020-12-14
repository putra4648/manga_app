import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/data/models/manga.dart';

class ShowMangaData extends StatelessWidget {
  final List<Manga> listManga;

  const ShowMangaData({Key key, @required this.listManga}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
      ),
      itemCount: listManga.take(12).length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  colorFilter: ColorFilter.mode(
                    Colors.black38,
                    BlendMode.darken,
                  ),
                  image: CachedNetworkImageProvider(listManga[index].imageUrl),
                ),
              ),
              child: Text(
                listManga[index].title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
