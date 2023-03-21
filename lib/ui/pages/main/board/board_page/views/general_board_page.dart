import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/widgets/board/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralBoardPage extends GetView<BoardPageController> {
  const GeneralBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 8, bottom: 8 , left: 16, right: 16),
              itemCount: controller.postController.generalBoard.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.post, arguments: controller.postController.generalBoard[index].id);
                  },
                  child: Container(
                    color: Palette.pureWhite,
                    child: Column(
                      children: [
                        PostCard(
                          nickname: controller.postController.generalBoard[index].author,
                          title: controller.postController.generalBoard[index].title,
                          subtitle: controller.postController.generalBoard[index].body,
                          publishDate:
                          controller.postController.generalBoard[index].createdAt,
                          commentCount: 0,
                          likeCount: 0,
                        ),
                        Divider(color: Palette.grey,height: 1,),
                      ],
                    ),
                  ),
                );
              }),
        ],
      )
    );
  }
}
