import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_app/bloc_provider.dart';
import 'package:video_player_app/features/uploads/model/search_history_data.dart';
import 'package:video_player_app/features/uploads/model/snippet_data.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_state.dart';
import 'package:video_player_app/features/uploads/usecase/get_channel_videos_use_case.dart';
import 'package:video_player_app/features/uploads/usecase/search_channel_videos_use_case.dart';
import 'package:video_player_app/providers.dart';
import 'package:video_player_app/shared/data.dart';

final getChannelVideosCubitProvider = cubitAutoDispose<GetChannelVideosCubit>(
  (ref) => GetChannelVideosCubit(
      GetChannelVideosUseCase(
        ref.read(uploadsRepositoryProvider),
        ref.read(connectivityProvider),
      ),
      SearchChannelVideosUseCase(
        ref.read(uploadsRepositoryProvider),
        ref.read(connectivityProvider),
        ref.read(offlineClientProvider),
      )),
);

class GetChannelVideosCubit extends Cubit<GetChannelVideosState> {
  final GetChannelVideosUseCase getChannelVideosUseCase;
  final SearchChannelVideosUseCase searchChannelVideosUseCase;

  GetChannelVideosCubit(
      this.getChannelVideosUseCase, this.searchChannelVideosUseCase)
      : super(const GetChannelVideosState.initial());

  Future<void> call({String? query}) async {
    Data<SnippetData> result;
    emit(const GetChannelVideosState.loading());
    if (query != null) {
      result = await searchChannelVideosUseCase(query);
    } else {
      result = await getChannelVideosUseCase();
    }

    result.maybeWhen(
      success: (data) async => emit(GetChannelVideosState.finished(data: data)),
      failure: (exception) => emit(GetChannelVideosState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }

  void addToSearchHistory(String text) =>
      searchChannelVideosUseCase.addToSearchHistory(text);

  void clearSearchHistory() => searchChannelVideosUseCase.clearSearchHistory();

  List<SearchHistoryData> getSearchHistory() =>
      searchChannelVideosUseCase.getSearchHistory();

  void deleteSingleSearchHistory(String id) =>
      searchChannelVideosUseCase.deleteSingleSearchHistory(id);
}
