import 'dart:async';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/logic/cubit/manga/top/top_bloc.dart';

import '../../logic/logic.dart';
import '../widgets/custom_style_hook.dart';
import '../widgets/loading.dart';
import '../pages/show_character_page.dart';
import '../pages/show_manga_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<void> refreshCompleter;

  @override
  void initState() {
    refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          title: const Text('Manga'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocConsumer<ConnectivityCubit, ConnectivityState>(
          listener: (context, state) {
            if (state is ConnectionResult) {
              if (state.connectivityResult.index == 2) {
                // listWidgetBody.clear();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'No Connection',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is ConnectionLoading) {
              return Loading();
            }
            if (state is ConnectionResult) {
              if (state.connectivityResult.index != 2) {
                return RefreshIndicator(
                  onRefresh: () {},
                  // onRefresh: () {
                  // context.read<SeasonBloc>().add(SeasonInitEvent());
                  // context.read<TopBloc>().add(TopInitEvent());
                  // context
                  //     .read<CharacterBloc>()
                  //     .add(CharacterRefreshRequested());
                  // return refreshCompleter.future;
                  // },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildContainerLabel('Top Character',
                            'Most popular character in 2020', theme),
                        buildContainerCharacterManga(size),
                        buildContainerLabel('Top Manga',
                            'You can see our top manga here', theme),
                        buildContainerTopManga(size),
                        buildContainerLabel(
                            'Season', 'List upcoming manga and anime', theme),
                        buildContainerSeasonManga(size)
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildContainerSeasonManga(Size size) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: size.height * 0.5,
      child: BlocConsumer<SeasonBloc, SeasonState>(
        listener: (context, state) {
          if (state is SeasonLoadedSuccess) {
            refreshCompleter?.complete();
            refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          if (state is SeasonLoadedSuccess) {
            return ShowMangaPage(listManga: state.seasons);
          }
          if (state is SeasonFailure) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget buildContainerTopManga(Size size) {
    return Container(
      height: size.height * 0.5,
      child: BlocConsumer<TopBloc, TopState>(
        listener: (context, state) {
          if (state is TopLoadedSuccess) {
            refreshCompleter?.complete();
            refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          if (state is TopLoading) {
            return Loading();
          }
          if (state is TopLoadedSuccess) {
            return ShowMangaPage(listManga: state.tops);
          }
          if (state is TopFailure) {
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
                onTap: () {
                  Navigator.of(context).pushNamed('/detail');
                },
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

  Widget buildContainerCharacterManga(Size size) {
    return Container(
      height: size.height * 0.35,
      child: BlocConsumer<CharacterBloc, CharacterState>(
        listener: (context, state) {
          if (state is CharacterLoadedSuccess) {
            // context.read<CharacterBloc>().add(CharacterInitEvent());
            refreshCompleter?.complete();
            refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          if (state is CharacterLoading) {
            return Loading();
          }
          if (state is CharacterLoadedSuccess) {
            return ShowCharacterPage(
              listCharacter: state.characters,
              size: size,
              isEmpty: state.isEmpty,
            );
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