import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/features/uploads/model/search_history_data.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_cubit.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_state.dart';
import 'package:video_player_app/shared/extensions/text_editing_controller_extension.dart';

final LayerLink layerLink = LayerLink();

class SearchBox extends HookConsumerWidget {
  const SearchBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.overlayEntry,
    this.onSearch,
    this.overlayState,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueNotifier<OverlayState>? overlayState;
  final ValueNotifier<OverlayEntry?> overlayEntry;
  final Function()? onSearch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getChannelVideosCubitProvider);
    final searchHistory =
        useState<List<SearchHistoryData>>(cubit.getSearchHistory());

    OverlayEntry createOverlay(BuildContext context) {
      RenderBox renderBox = context.findRenderObject() as RenderBox;

      var size = renderBox.size;

      return OverlayEntry(
        builder: (context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: searchHistory.value.isNotEmpty
                ? Material(
                    elevation: 5.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            overlayEntry.value?.remove();
                            cubit.clearSearchHistory();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 16, top: 10),
                            child: Text('Clear history'),
                          ),
                        ),
                        Column(
                          children: List.generate(
                            searchHistory.value.length,
                            (index) => GestureDetector(
                              onTap: () {
                                focusNode.unfocus();
                                controller.text =
                                    searchHistory.value[index].text!;
                                // cubit.call(query: controller.text);
                              },
                              child: ListTile(
                                title:
                                    Text(searchHistory.value[index].text ?? ''),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      );
    }

    void listener() {
      if (focusNode.hasFocus) {
        overlayEntry.value = createOverlay(context);

        overlayState!.value.insert(overlayEntry.value!);
      }
    }

    controller.addHookListener(listener);

    useEffect(() {
      focusNode.addListener(listener);
      return () {
        focusNode.removeListener(listener);
      };
    }, []);

    return BlocBuilder<GetChannelVideosCubit, GetChannelVideosState>(
      bloc: cubit..getSearchHistory(),
      builder: (context, state) => CompositedTransformTarget(
        link: layerLink,
        child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Search',
            suffix: GestureDetector(
              onTap: onSearch,
              child: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
