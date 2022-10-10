import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_app/bloc_provider.dart';
import 'package:video_player_app/features/playlist/presentation/cubit/get_channel_playlists_state.dart';
import 'package:video_player_app/features/playlist/usecase/get_channel_playlists_use_case.dart';
import 'package:video_player_app/providers.dart';

final getChannelPlaylistsCubitProvider =
    cubitAutoDispose<GetChannelPlaylistsCubit>(
  (ref) => GetChannelPlaylistsCubit(
    GetChannelPlaylistsUseCase(
      ref.read(playlistRepositoryProvider),
      ref.read(connectivityProvider),
    ),
  ),
);

class GetChannelPlaylistsCubit extends Cubit<GetChannelPlaylistsState> {
  final GetChannelPlaylistsUseCase getChannelPlaylistsUseCase;

  GetChannelPlaylistsCubit(this.getChannelPlaylistsUseCase)
      : super(const GetChannelPlaylistsState.initial());

  Future<void> call() async {
    emit(const GetChannelPlaylistsState.loading());

    final result = await getChannelPlaylistsUseCase();

    result.maybeWhen(
      success: (data) async =>
          emit(GetChannelPlaylistsState.finished(data: data)),
      failure: (exception) => emit(GetChannelPlaylistsState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }
}
