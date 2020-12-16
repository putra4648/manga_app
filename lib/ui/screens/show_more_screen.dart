import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manga_app/logic/logic.dart';

class ShowMoreScreen extends StatelessWidget {
  final bool showMangas;

  const ShowMoreScreen({Key key, this.showMangas}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).copyWith(
      dialogTheme: DialogTheme(
        backgroundColor: Colors.black87,
        titleTextStyle: TextStyle(),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 14,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        headline5: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Back'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (showMangas == null)
                BlocBuilder<CharacterBloc, CharacterState>(
                  builder: (context, state) {
                    if (state is CharacterLoadedSuccess) {
                      final characters = state.characters;
                      return Column(
                        children: characters
                            .map(
                              (char) => Container(
                                margin: const EdgeInsets.all(10),
                                height: size.height * 0.2,
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: size.height,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: CachedNetworkImageProvider(
                                            char.imageUrl,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(char.title),
                                        TextButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: char
                                                          .animeography
                                                          .map(
                                                            (anime) => ListTile(
                                                              leading: Icon(
                                                                Icons.adjust,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              title: Text(
                                                                  anime.name),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child:
                                                const Text('See Animeography')),
                                        TextButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: char
                                                          .mangaography
                                                          .map(
                                                            (manga) => ListTile(
                                                              leading: FaIcon(
                                                                Icons
                                                                    .remove_circle_outline,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              title: Text(
                                                                  manga.name),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child:
                                                const Text('See Mangaography')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return SizedBox();
                  },
                ),
              if (showMangas == true)
                BlocBuilder<TopBloc, TopState>(
                  builder: (context, state) {
                    if (state is TopLoadedSuccess) {
                      final tops = state.tops;
                      return Column(
                        children: tops
                            .map(
                              (top) => Container(
                                margin: const EdgeInsets.all(10),
                                height: size.height * 0.2,
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: size.height,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: CachedNetworkImageProvider(
                                            top.imageUrl,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              top.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  top.startDate,
                                                ),
                                                Text('-'),
                                                Text(
                                                  top.endDate ?? 'N/a',
                                                ),
                                              ],
                                            ),
                                            Chip(
                                              avatar: CircleAvatar(
                                                child: Icon(Icons.star_outline),
                                              ),
                                              label: Text(
                                                top.score.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return SizedBox();
                  },
                ),
              if (showMangas == false)
                BlocBuilder<SeasonBloc, SeasonState>(
                  builder: (context, state) {
                    if (state is SeasonLoadedSuccess) {
                      final tops = state.seasons;
                      return Column(
                        children: tops
                            .map(
                              (top) => Container(
                                margin: const EdgeInsets.all(10),
                                height: size.height * 0.3,
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: size.height,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: CachedNetworkImageProvider(
                                            top.imageUrl,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              top.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              top.synopsis ?? '',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Chip(
                                              avatar: CircleAvatar(
                                                child: Icon(Icons.star_outline),
                                              ),
                                              label: Text(
                                                top.score.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return SizedBox();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
