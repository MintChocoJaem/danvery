import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_time_formatter.dart';

import '../providers/bear_eats_board_provider.dart';
import '../widgets/board_tab.dart';
import '../widgets/post_preview_card.dart';

class BearEatsBoardScreen extends ConsumerStatefulWidget {
  const BearEatsBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _BearEatsBoardScreenState();
  }
}

class _BearEatsBoardScreenState extends ConsumerState<BearEatsBoardScreen>
    with DateTimeFormatter {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final bearEatsBoard = ref.watch(bearEatsBoardProvider);

    return BoardTab(
      board: bearEatsBoard,
      onFetch: () async {
        //await ref.read(noticeBoardProvider.notifier).fetch();
      },
      onFetchMore: (currentPage) async {},
      postTagItems: (post) => [
        PostTagItem(
          title: '${post.recruitedCount}명 모집',
        ),
        PostTagItem(
          title: post.deliveryPlace,
        ),
      ],
      onTapPost: (post){},
    );
  }
}
