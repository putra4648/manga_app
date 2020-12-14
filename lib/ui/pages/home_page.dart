import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:manga_app/logic/logic.dart';
import 'package:manga_app/ui/widgets/custom_style_hook.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<SeasonMangaCubit>().initSeason();
    context.read<TopMangaCubit>().initTopManga();
    context.read<CharacterCubit>().initCharacter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
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
        bottomNavigationBar: StyleProvider(
          style: CustomStyleHook(),
          child: ConvexAppBar(
            backgroundColor: Theme.of(context).appBarTheme.color,
            elevation: 0,
            style: TabStyle.flip,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.navigation, title: 'Navigation'),
              TabItem(icon: Icons.favorite_border, title: 'Favorite'),
              TabItem(icon: Icons.theaters, title: 'Upcoming'),
              TabItem(icon: Icons.more_horiz, title: 'Menu'),
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 16,
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good Morning'),
              Text('Your name'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Release!',
                    style: theme.textTheme.headline5,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Check out some new manga here'),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Text('Show more'),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: BlocBuilder<CharacterCubit, CharacterState>(
                builder: (context, state) {
                  if (state is CharacterLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CharacterLoaded) {
                    return CarouselSlider.builder(
                      itemCount: state.characters.take(8).length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              colorFilter: ColorFilter.mode(
                                  Colors.black38, BlendMode.darken),
                              image: CachedNetworkImageProvider(
                                  state.characters[index].imageUrl),
                            ),
                          ),
                          child: Text(
                            state.characters[index].title,
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
                  return SizedBox();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Manga',
                    style: theme.textTheme.headline5,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('You can see our top manga here'),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Text('Show more'),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              child: BlocBuilder<TopMangaCubit, TopMangaState>(
                builder: (context, state) {
                  if (state is MangaTopLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is MangaTopLoaded) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: state.topMangas.take(12).length,
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
                                  image: CachedNetworkImageProvider(
                                      state.topMangas[index].imageUrl),
                                ),
                              ),
                              child: Text(
                                state.topMangas[index].title,
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
                  return SizedBox();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Season',
                    style: theme.textTheme.headline5,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Here list upcoming manga',
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Text('Show more'),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: 300,
              child: BlocBuilder<SeasonMangaCubit, MangaSeasonState>(
                builder: (context, state) {
                  if (state is MangaSeasonLoaded) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 12,
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
                                  image: CachedNetworkImageProvider(
                                      state.mangaSeasons[index].imageUrl),
                                ),
                              ),
                              child: Text(
                                state.mangaSeasons[index].title,
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
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
