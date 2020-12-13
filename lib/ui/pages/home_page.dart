import 'package:cached_network_image/cached_network_image.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manga_app/cubit/connectivity_cubit.dart';
import 'package:manga_app/cubit/manga_cubit.dart';
import 'package:manga_app/ui/widgets/style_hook.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Text('Good Morning'),
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
      body: BlocConsumer<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          if (state is ConnectionResult) {
            if (state.connectivityResult.index != 2) {
              // context.read<MangaCubit>().getMangaData('grand blue');
              print('this is wifi or mobile connection');
            } else {
              print('no connection');
            }
          }
        },
        builder: (context, connectionState) {
          if (connectionState is ConnectionLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (connectionState is ConnectionResult) {
            return BlocBuilder<MangaCubit, MangaState>(
              builder: (context, mangaState) {
                if (mangaState is MangaLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (mangaState is MangaLoadedFromLocal) {
                  final mangas = mangaState.mangas;

                  return ListView.builder(
                    itemCount: mangas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CachedNetworkImage(
                          width: 100,
                          imageUrl: mangas[index].imageUrl,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(image: imageProvider),
                              ),
                            );
                          },
                        ),
                        title: Text(mangas[index].title),
                        subtitle: Text(mangas[index].score.toString()),
                      );
                    },
                  );
                }
                return ListView(
                  children: [
                    Text('Some text'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Some text'),
                        Material(
                          child: Row(
                            children: [
                              const Text('Show more'),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        )
                      ],
                    ),
                    Placeholder(
                      fallbackHeight: 100,
                    ),
                    Text('Some text'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Some text'),
                        Material(
                          child: Row(
                            children: [
                              const Text('Show more'),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 300,
                      color: Colors.red,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: 12,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 100,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
