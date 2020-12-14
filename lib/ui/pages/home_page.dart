import 'dart:async';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:manga_app/logic/logic.dart';
import 'package:manga_app/ui/widgets/custom_style_hook.dart';
import 'package:manga_app/ui/widgets/loading.dart';
import 'package:manga_app/ui/widgets/show_character_data.dart';
import 'package:manga_app/ui/widgets/show_manga_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> listWidgetBody;
  Completer<void> refreshCompleter;

  @override
  void initState() {
    listWidgetBody = <Widget>[];
    refreshCompleter = Completer<void>();
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
          title: const Text('Manga'),
          centerTitle: true,
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
        body: BlocConsumer<ConnectivityCubit, ConnectivityState>(
          listener: (context, state) {
            if (state is ConnectionLoading) {
              if (listWidgetBody.isEmpty) {
                listWidgetBody.add(buildContainerLabel(
                    'New Release!', 'Check out some new manga here', theme));
                listWidgetBody.add(buildContainerCharacterManga());
                listWidgetBody.add(buildContainerLabel(
                    'Top Manga', 'You can see our top manga here', theme));
                listWidgetBody.add(buildContainerTopManga());
                listWidgetBody.add(buildContainerLabel(
                    'Season', 'Here list upcoming manga', theme));
                listWidgetBody.add(buildContainerSeasonManga());
              } else {
                listWidgetBody.clear();
              }
            }
            if (state is ConnectionResult) {
              if (state.connectivityResult.index == 2) {
                listWidgetBody.clear();
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'No Connection',
                  textAlign: TextAlign.center,
                )));
              }
            }
          },
          builder: (context, state) {
            if (state is ConnectionLoading) {
              return Loading();
            }
            if (state is ConnectionResult) {
              return RefreshIndicator(
                onRefresh: () {
                  context.read<SeasonMangaCubit>().initSeason();
                  context.read<TopMangaCubit>().initTopManga();
                  context.read<CharacterCubit>().initCharacter();
                  return refreshCompleter.future;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: listWidgetBody,
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildContainerSeasonManga() {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 300,
      // SEASON MANGA
      child: BlocConsumer<SeasonMangaCubit, SeasonMangaState>(
        listener: (context, state) {
          if (state is SeasonMangaLoaded) {
            refreshCompleter?.complete();
            refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          if (state is SeasonMangaLoaded) {
            return ShowMangaData(listManga: state.mangaSeasons);
          }
          if (state is SeasonMangaFailure) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget buildContainerTopManga() {
    return Container(
      height: 300,
      // TOP MANGA
      child: BlocConsumer<TopMangaCubit, TopMangaState>(
        listener: (context, state) {
          if (state is TopMangaLoaded) {
            refreshCompleter?.complete();
            refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          if (state is TopMangaLoading) {
            return Loading();
          }
          if (state is TopMangaLoaded) {
            return ShowMangaData(listManga: state.topMangas);
          }
          if (state is TopMangaFailure) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget buildContainerLabel(
      String labelName, String description, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelName,
            style: theme.textTheme.headline5,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(description),
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
    );
  }

  Widget buildContainerCharacterManga() {
    return Container(
      child: BlocConsumer<CharacterCubit, CharacterState>(
        listener: (context, state) {
          refreshCompleter?.complete();
          refreshCompleter = Completer();
        },
        builder: (context, state) {
          if (state is CharacterLoading) {
            return Loading();
          }
          if (state is CharacterLoaded) {
            return ShowCharacterData(listCharacter: state.characters);
          }
          if (state is CharacterFailure) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
