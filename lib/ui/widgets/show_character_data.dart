import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/data/models/character.dart';

class ShowCharacterData extends StatelessWidget {
  final List<Character> listCharacter;

  const ShowCharacterData({Key key, @required this.listCharacter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: listCharacter.take(8).length,
      itemBuilder: (context, index) {
        return Container(
          width: 100,
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                image:
                    CachedNetworkImageProvider(listCharacter[index].imageUrl)),
          ),
          child: Text(
            listCharacter[index].title,
            textAlign: TextAlign.center,
          ),
        );
      },
      options: CarouselOptions(
        viewportFraction: 0.3,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
