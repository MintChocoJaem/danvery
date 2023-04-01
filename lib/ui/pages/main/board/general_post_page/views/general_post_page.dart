import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/general_post_page_controller.dart';

class GeneralPostPage extends GetView<GeneralPostPageController> {
  const GeneralPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "자유게시판",
        automaticallyImplyLeading: true,
        onPressedLeading: () {
          Get.back(result: controller.generalPostModel.value);
        },
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Obx(() => controller.isLoadedGeneralPost.value &&
                controller.isLoadedGeneralComment.value
            ? RefreshIndicator(
                onRefresh: () async {
                  await controller
                      .getGeneralPost(controller.generalPostModel.value.id);
                  await controller
                      .getGeneralComment(controller.generalPostModel.value.id);
                },
                child: SingleChildScrollView(
                  controller: controller.generalCommentScrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: Image.asset(
                                        "assets/icons/user/profile_icon.png")
                                    .image,
                                backgroundColor: Colors.transparent,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                controller.generalPostModel.value.author,
                                style: regularStyle.copyWith(
                                    color: Palette.darkGrey,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                controller.generalPostModel.value.createdAt,
                                style: tinyStyle.copyWith(color: Palette.grey),
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Palette.darkGrey,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.generalPostModel.value.title,
                            style: regularStyle.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            controller.generalPostModel.value.body,
                            style: regularStyle,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            width: 128,
                            height: 128,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            width: 128,
                            height: 128,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "댓글 ${controller.generalCommentList.value.totalElements.toString()}",
                            style: titleStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Palette.black),
                          ),
                          Obx(
                            () => OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(
                                  width: 2,
                                  color: controller.generalPostModel.value.liked
                                      ? Palette.lightBlue
                                      : Palette.lightGrey,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    controller.generalPostModel.value.liked
                                        ? "assets/icons/post/like_selected.png"
                                        : "assets/icons/post/like_unselected.png",
                                    width: 18,
                                    height: 18,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "LIKE",
                                    style: lightStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: controller
                                              .generalPostModel.value.liked
                                          ? Palette.lightBlue
                                          : Palette.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    controller.generalPostModel.value.likes
                                        .toString(),
                                    style: lightStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: controller
                                              .generalPostModel.value.liked
                                          ? Palette.lightBlue
                                          : Palette.grey,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () async {
                                controller.likeGeneralPost(
                                    controller.generalPostModel.value.id);
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Palette.lightGrey,
                        thickness: 1,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.generalComments.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == controller.generalComments.length) {
                            if (controller.generalCommentList.value.last) {
                              return const SizedBox();
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                          }
                          return Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: Image.asset(
                                                "assets/icons/user/profile_icon.png")
                                            .image,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller
                                                .generalComments[index].author,
                                            style: regularStyle.copyWith(
                                                color: Palette.darkGrey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            controller.generalComments[index]
                                                .createdAt,
                                            style: tinyStyle.copyWith(
                                                color: Palette.grey),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            controller
                                                .generalComments[index].text,
                                            style: regularStyle,
                                          ),
                                          /*
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/icons/post/like_unselected.png",
                                                width: 12,
                                                height: 12,
                                                color: Palette.grey,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),

                                              Text(
                                                "0",
                                                style: lightStyle.copyWith(
                                                    color: Palette.grey),
                                              )
                                            ],
                                          ),

                                           */
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Divider(
                                    color: Palette.lightGrey,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Palette.grey,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )),
      ),
    );
  }
}
