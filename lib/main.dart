import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/common/utils.dart';
import 'package:dicoding_mfde_submission/injection.dart' as di;
import 'package:dicoding_mfde_submission/presentation/pages/about_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/home_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/detail_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/popular_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/search_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/top_rated_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/watchlist_page.dart';
import 'package:dicoding_mfde_submission/presentation/provider/detail_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/list_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/search_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/popular_movies_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/top_rated_notifier.dart';
import 'package:dicoding_mfde_submission/presentation/provider/watchlist_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<ListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<DetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        // home: HomeMoviePage(),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case PopularPage.routeName:
              final type = settings.arguments as String;
              return CupertinoPageRoute(
                  builder: (_) => PopularPage(type: type));
            case TopRatedPage.routeName:
              final type = settings.arguments as String;
              return CupertinoPageRoute(
                  builder: (_) => TopRatedPage(type: type));
            case DetailPage.routeName:
              final args = settings.arguments as DetailPageArguments;
              return MaterialPageRoute(
                builder: (_) => DetailPage(args: args),
                settings: settings,
              );
            case SearchPage.routeName:
              var type = settings.arguments as String;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(
                        type: type,
                      ));
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
