import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/movie_response.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/screens/home/title_row.dart';

import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/movie_viewmodel.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/movie_widget.dart';
import 'package:movies/ui/widgets/not_ready.dart';
import 'package:movies/ui/screens/home/home_screen_image.dart';
import 'package:movies/ui/screens/home/horiz_movies.dart';

@RoutePage(name: 'HomeRoute')
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late MovieViewModel movieViewModel;
  Future<List<MovieResponse?>>? movieFuture;

  Future<void> toggleThemeMode() async {
    final currentMode = ref.read(themeModeProvider);
    final nextMode =
        currentMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    ref.read(themeModeProvider.notifier).state = nextMode;

    final prefs = await ref.read(prefsProvider.future);
    prefs.setString(
      themeModePreferenceKey,
      nextMode == ThemeMode.light ? 'light' : 'dark',
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieViewModelAsync = ref.watch(movieViewModelProvider);
    return movieViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        movieViewModel = viewModel;
        return buildScreen();
      },
    );
  }

  Widget buildScreen() {
    final themeMode = ref.watch(themeModeProvider);
    return SafeArea(
      child: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if ((snapshot.connectionState != ConnectionState.active) &&
              (snapshot.connectionState != ConnectionState.done)) {
            return const NotReady();
          }
          return SingleChildScrollView(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Now Playing',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                          onPressed: toggleThemeMode,
                          icon: Icon(
                            themeMode == ThemeMode.dark
                                ? Icons.wb_sunny
                                : Icons.nights_stay,
                          ),
                          tooltip: themeMode == ThemeMode.dark
                              ? 'Light mode'
                              : 'Dark mode',
                        ),
                      ],
                    ),
                  ),
                  HomeScreenImage(
                      movieViewModel: movieViewModel,
                      onMovieTap: (movieId) {
                        context.router.push(MovieDetailRoute(movieId: movieId));
                      }),
                  TitleRow(
                    text: 'Trending',
                    onMoreClicked: () {},
                  ),
                  HorizontalMovies(
                    movies: movieViewModel.trendingMovies,
                    onMovieTap: onMovieTap,
                    movieType: MovieType.trending,
                  ),
                  TitleRow(
                    text: 'Popular',
                    onMoreClicked: () {},
                  ),
                  HorizontalMovies(
                    movies: movieViewModel.popularMovies,
                    onMovieTap: onMovieTap,
                    movieType: MovieType.popular,
                  ),
                  TitleRow(
                    text: 'Top Rated',
                    onMoreClicked: () {},
                  ),
                  HorizontalMovies(
                    movies: movieViewModel.topRatedMovies,
                    onMovieTap: onMovieTap,
                    movieType: MovieType.topRated,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onMovieTap(int movieId) {
    context.router.push(MovieDetailRoute(movieId: movieId));
  }

  Future loadData() async {
    movieFuture ??= Future.wait([
      movieViewModel.getTrendingMovies(1),
      movieViewModel.getTopRated(1),
      movieViewModel.getPopular(1),
      movieViewModel.getNowPlaying(1)
    ]);
    return movieFuture;
  }
}
