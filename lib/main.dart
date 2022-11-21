import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:imdb_clone/common/themes.dart';
import 'package:imdb_clone/navigation/router.dart';
import 'package:imdb_clone/notifications/notification.dart';
import 'package:imdb_clone/presentation/screens/error_default_page.dart';
import 'package:imdb_clone/repositories/local/favourites_local_repository.dart';
import 'package:imdb_clone/repositories/local/genre_local_repository.dart';
import 'package:imdb_clone/repositories/local/movies_local_repository.dart';
import 'package:imdb_clone/repositories/local/object_box.dart';
import 'package:imdb_clone/repositories/local/token_repository.dart';
import 'package:imdb_clone/repositories/remote/dio_client.dart';

late ObjectBox objectbox;
final FlutterLocalNotificationsPlugin localNotificationPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

Future<void> initialization() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  ErrorWidget.builder = (error) => ErrorDefaultPage(details: error, inDebug: false);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  DioClient().init("https://api.themoviedb.org/3/", "", TokenRepository());
  IMDbCloneNotification.initialize(localNotificationPlugin);
  objectbox = await ObjectBox.create();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FavouritesLocalRepository(store: objectbox.store),
        ),
        RepositoryProvider(
          create: (context) => MoviesLocalRepository(store: objectbox.store),
        ),
        RepositoryProvider(
          create: (context) => GenreLocalRepository(store: objectbox.store),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'IMDb Clone - Q',
        theme: appTheme,
        //home: const HomePage(), //const MyHomePage(title: ''),
      ),
    );
  }
}
