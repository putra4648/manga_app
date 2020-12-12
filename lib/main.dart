import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/cubit/connectivity_cubit.dart';
import 'package:manga_app/cubit/manga_cubit.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityCubit(connectivity: Connectivity()),
        ),
        BlocProvider(
          create: (context) => MangaCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

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
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              getExternalStorageDirectory().then((value) {
                // print(value.listSync().length);
                print(value.path);
              });
            },
            child: Text('Dir'),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<MangaCubit>().getMangaData('grand blue');
            },
            child: Text('Load'),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('Material App Bar'),
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
                        leading: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(mangas[index].imageUrl),
                            ),
                          ),
                        ),
                        title: Text(mangas[index].title),
                        subtitle: Text(mangas[index].score.toString()),
                      );
                    },
                  );
                }
                return SizedBox();
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
