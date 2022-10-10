import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_app/bloc_provider.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_state.dart';
import 'package:video_player_app/features/uploads/usecase/get_channel_videos_use_case.dart';
import 'package:video_player_app/providers.dart';

final getChannelVideosCubitProvider = cubitAutoDispose<GetChannelVideosCubit>(
  (ref) => GetChannelVideosCubit(
    GetChannelVideosUseCase(
      ref.read(uploadsRepositoryProvider),
      ref.read(connectivityProvider),
    ),
  ),
);

class GetChannelVideosCubit extends Cubit<GetChannelVideosState> {
  final GetChannelVideosUseCase getChannelVideosUseCase;

  GetChannelVideosCubit(this.getChannelVideosUseCase)
      : super(const GetChannelVideosState.initial());

  Future<void> call() async {
    emit(const GetChannelVideosState.loading());

    final result = await getChannelVideosUseCase();

    result.maybeWhen(
      success: (data) async => emit(GetChannelVideosState.finished(data: data)),
      failure: (exception) => emit(GetChannelVideosState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }
}
