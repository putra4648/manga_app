import 'package:flutter/material.dart';
import 'package:manga_app/logic/cubit_observer.dart';
import 'package:manga_app/logic/logic.dart';
import 'package:manga_app/ui/screens/search_screen.dart';

import 'ui/screens/show_more_screen.dart';
import 'ui/screens/home_screen.dart';

void main() {
  Bloc.observer = CubitObserver();
  runApp(
    MyApp(),
  );
}

// MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => ConnectivityCubit(connectivity: Connectivity()),
//         ),
//         BlocProvider(
//           create: (context) => SearchMangaCubit(),
//         ),
//         BlocProvider(
//           create: (context) => SeasonMangaCubit(),
//         ),
//         BlocProvider(
//           create: (context) => TopMangaCubit(),
//         ),
//         BlocProvider(
//             create: (context) =>
//                 CharacterBloc(<Character>[])..add(CharacterInitEvent())),
//       ],

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityCubit(connectivity: Connectivity()),
        ),
        BlocProvider(
          create: (context) => CharacterBloc()
            ..add(CharacterInitEvent())
            ..add(CharacterLoadEvent()),
        ),
        BlocProvider(
          create: (context) =>
              SeasonBloc()..add(SeasonInitEvent())..add(SeasonLoadEvent()),
        ),
        BlocProvider(
          create: (context) => SearchBloc()..add(SearchInitEvent()),
        ),
        BlocProvider(
          create: (context) =>
              TopBloc()..add(TopInitEvent())..add(TopLoadEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          cardColor: Colors.blueGrey[800],
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
            bodyText2: TextStyle(
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
                fontSize: 20,
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
        // home: HomeScreen(),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          final name = settings.name;
          if (name == '/') {
            return MaterialPageRoute(
              builder: (context) => HomeScreen(),
            );
          }
          if (name == '/show_more') {
            final args = settings.arguments;
            return MaterialPageRoute(
              builder: (context) => ShowMoreScreen(
                showMangas: args,
              ),
            );
          }
          if (name == '/search') {
            return MaterialPageRoute(builder: (context) => SearchScreen());
          }
          return null;
        },
      ),
    );
  }
}
