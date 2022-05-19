import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/common/ssl_pinning.dart';
import 'package:dicoding_mfde_submission/common/utils.dart';
import 'package:dicoding_mfde_submission/injection.dart' as di;
import 'package:dicoding_mfde_submission/presentation/bloc/detail/detail_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/now_playing/now_playing_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/popular/popular_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/recommendation/recommendation_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/search/search_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/toprated/top_rated_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:dicoding_mfde_submission/presentation/pages/about_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/detail_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/home_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/popular_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/search_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/top_rated_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/watchlist_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HttpSslPinning.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
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
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
