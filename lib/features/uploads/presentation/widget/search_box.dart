import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player_app/features/uploads/model/search_history_data.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_cubit.dart';
import 'package:video_player_app/features/uploads/presentation/cubit/get_channel_videos_state.dart';

final LayerLink layerLink = LayerLink();

class SearchBox extends HookConsumerWidget {
  const SearchBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.overlayEntry,
    this.overlayState,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueNotifier<OverlayState>? overlayState;
  final ValueNotifier<OverlayEntry?> overlayEntry;

  void removeOverlay() {
    if (overlayEntry.value != null) {
      overlayEntry.value?.remove();
      focusNode.unfocus();
    }
  }

  void insertOverlay() {
    if (overlayEntry.value != null) {
      overlayEntry.value?.remove();
    }

    overlayState!.value.insert(overlayEntry.value!);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getChannelVideosCubitProvider);

    void listener() {
      if (focusNode.hasFocus) {
        overlayEntry.value = createOverlay(context, cubit);

        overlayState!.value.insert(overlayEntry.value!);
      }
    }

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
              onTap: () {
                if (controller.text.isNotEmpty) {
                  removeOverlay();

                  cubit.call(query: controller.text);

                  cubit.addToSearchHistory(controller.text);
                }
              },
              child: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry createOverlay(
    BuildContext context,
    GetChannelVideosCubit cubit,
  ) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;

    final searchHistory =
        ValueNotifier<List<SearchHistoryData>>(cubit.getSearchHistory());

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 15),
          child: searchHistory.value.isNotEmpty
              ? Material(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          removeOverlay();

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
                              removeOverlay();

                              // updates controller text to selected value
                              controller.text =
                                  searchHistory.value[index].text!;

                              cubit.call(query: controller.text);
                            },
                            child: ListTile(
                              title: Text(searchHistory.value[index].text!),
                              trailing: IconButton(
                                onPressed: () async {
                                  insertOverlay();

                                  cubit.deleteSingleSearchHistory(
                                      searchHistory.value[index].id!);

                                  // updates search history list
                                  searchHistory.value =
                                      cubit.getSearchHistory();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
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
}
