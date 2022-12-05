import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imdb_clone/bloc/set_favourite/listen_favourite_bloc.dart';
import 'package:imdb_clone/common/colors.dart';
import 'package:imdb_clone/common/const.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/presentation/widgets/loadin_widget.dart';
import 'package:imdb_clone/repositories/local/favourites_local_repository.dart';

class FavouriteWidget extends StatelessWidget {
  final Movie movie;

  const FavouriteWidget({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListenFavouriteBloc>(
      create: (context) => ListenFavouriteBloc(RepositoryProvider.of<FavouritesLocalRepository>(context))
        ..add(ListFavouriteEventRequested(movieId: movie.id)),
      child: BlocBuilder<ListenFavouriteBloc, ListenFavouriteState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              context.read<ListenFavouriteBloc>().add(ChangeFavouriteEvent(movieId: movie.id));
            },
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(10.0),
              child: StateFavouriteWidget(movie: movie, state: state),
            ),
          );
        },
      ),
    );
  }
}

class StateFavouriteWidget extends StatelessWidget {
  final Movie movie;
  final ListenFavouriteState state;

  const StateFavouriteWidget({required this.movie, required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    if (state.status.isFetched) {
      return FaveIcon(
        isFavourite: state.isFavourite ?? false,
      );
    }
    if (state.status.isLoading) {
      return const LoadingWidget();
    }
    return const SizedBox(
      height: 20,
    );
  }
}

class FaveIcon extends StatelessWidget {
  final bool isFavourite;

  const FaveIcon({
    required this.isFavourite,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        isFavourite ? checkedFavouriteFilledImagePath : favouriteImagePath,
        color: AppColors.qDefaultColor,
        height: 20,
        width: 20,
      );
}
