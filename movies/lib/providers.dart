import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:movies/network/movie_api_service.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/movie_viewmodel.dart';

part 'providers.g.dart';

// providers.dart - com anotações
@Riverpod(keepAlive: true)
MovieAPIService movieAPIService(MovieAPIServiceRef ref) {
  return MovieAPIService();
}

@Riverpod(keepAlive: true)
Future<MovieViewModel> movieViewModel(MovieViewModelRef ref) async {
  final model = MovieViewModel(
    movieAPIService: ref.read(movieAPIServiceProvider)
  );
  await model.setup();  // Carrega dados da API
  return model;
}

// ⚙️ IMPORTANTE: Depois de editar, rodar:
// dart run build_runner build --delete-conflicting-outputs

final heroTagProvider = StateProvider<String>((ref) {
  return '';
});


@Riverpod(keepAlive: true)
AppRouter appRouter(AppRouterRef ref) => AppRouter();

