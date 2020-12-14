import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/logic/cubit_observer.dart';
import 'package:manga_app/logic/logic.dart';

import 'ui/pages/home_page.dart';

void main() {
  Bloc.observer = CubitObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityCubit(connectivity: Connectivity()),
        ),
        BlocProvider(
          create: (context) => MangaCubit(),
        ),
        BlocProvider(
          create: (context) => SeasonMangaCubit(),
        ),
        BlocProvider(
          create: (context) => TopMangaCubit(),
        ),
        BlocProvider(
          create: (context) => CharacterCubit(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xff17181c),
        ),
        canvasColor: Color(0xff17181c),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        iconTheme: IconThemeData(
          size: 20,
          color: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xff17181c),
          elevation: 0,
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      title: 'Material App',
      home: HomePage(),
    );
  }
}
