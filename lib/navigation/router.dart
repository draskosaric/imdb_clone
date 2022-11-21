import 'package:go_router/go_router.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/presentation/screens/details_screen.dart';
import 'package:imdb_clone/presentation/screens/home.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: "home",
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (context, state) {
            return DetailsScreen(
              movie: state.extra! as Movie,
            );
          },
        ),
      ],
    ),
  ],
);
