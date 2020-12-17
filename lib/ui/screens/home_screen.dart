import 'dart:async';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../logic/logic.dart';
import '../widgets/custom_style_hook.dart';
import '../widgets/loading.dart';
import '../pages/show_character_page.dart';
import '../pages/show_manga_page.dart';

class HomeScreen extends StatefulWidget {
  final TabController tabController;
  const HomeScreen({
    Key key,
    @required this.tabController,
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
            controller: widget.tabController,
            backgroundColor: Theme.of(context).appBarTheme.color,
            elevation: 0,
            style: TabStyle.flip,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: FontAwesomeIcons.calendarAlt, title: 'Schedule'),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('WeaBook'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).pushNamed('/search');
              },
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      buildContainerLabel('Top Character',
                          'Most popular character in 2020', theme, null),
                      buildContainerCharacterManga(size),
                      buildContainerLabel('Top Manga',
                          'You can see our top manga here', theme, true),
                      buildContainerTopManga(size),
                      buildContainerLabel('Season',
                          'List upcoming manga and anime', theme, false),
                      buildContainerSeasonManga(size)
                    ],
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

  Widget buildContainerCharacterManga(Size size) {
    return Container(
      height: size.height * 0.35,
      child: BlocConsumer<CharacterBloc, CharacterState>(
        listener: (context, state) {
          if (state is CharacterLoadedSuccess) {
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

  Widget buildContainerSeasonManga(Size size) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: size.height * 0.5,
      child: BlocConsumer<SeasonBloc, SeasonState>(
        listener: (context, state) {
          if (state is SeasonLoadedSuccess) {
            // context.read<CharacterBloc>().add(CharacterInitEvent());
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
      String labelName, String description, ThemeData theme, bool isShow) {
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
                  Navigator.of(context)
                      .pushNamed('/show_more', arguments: isShow);
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
}
