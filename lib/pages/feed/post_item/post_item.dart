import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/post_item.controller.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';

class PostItem extends StatelessWidget {
  PostItem({Key? key, this.post, this.inPostItem = false}) : super(key: key);

  final PostData? post;
  final bool inPostItem;

  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostItemController>(
      init: PostItemController(post: post!),
      tag: post?.id.toString(),
      builder: (_post) {
        final post = _post.post;
        final user = _post.post.user;
        final medias = _post.post.medias;

        final isLiked = post.likes!.isNotEmpty &&
            post.likes?.firstWhere((el) => el.userId == user?.id).userId !=
                null;

        return GestureDetector(
          onTap: () => inPostItem ? null : OnRoute.push(PostPage(post: post)),
          child: Container(
            padding: EdgeInsets.all(20).copyWith(bottom: 8),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Avatar(
                      user: user as UserModel,
                      width: 38,
                      heigth: 38,
                      iconSize: 10,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(user.name?.split(' ').first ?? ''),
                                    if (post.location != null)
                                      Flexible(
                                        child: Text(
                                          '  •  ${post.location?.name}',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  '@${user.username}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30),
                          Row(
                            children: [
                              Text(
                                '12:23',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return SafeArea(
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                                leading: Icon(
                                                  FeatherIcons.edit,
                                                ),
                                                title: Text('Editar'),
                                                onTap: () => {}),
                                            ListTile(
                                              leading: Icon(
                                                FeatherIcons.delete,
                                              ),
                                              title: Text('Excluir'),
                                              onTap: () => {},
                                            ),
                                            ListTile(
                                              leading: Icon(FeatherIcons.save),
                                              title: Text('Salvar'),
                                              onTap: () => {},
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.more_vert_rounded,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HashTagText(
                      text: post.text ?? '',
                      decorateAtSign: true,
                      basicStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      decoratedStyle: TextStyle(
                        color: primary,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 6),
                    if ((medias?.length ?? 0) > 0)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: PageView(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          scrollBehavior: ScrollBehavior(),
                          children: List.generate(
                            medias?.length ?? 0,
                            (index) => ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: ImageNetwork(
                                src: medias?[index].url,
                                width: Size.infinite.width,
                                height: 300,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${post.cCount?.likes}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          (post.cCount?.likes ?? 0) > 1 ? 'gosteis' : 'gostei',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${post.cCount?.comments}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          (post.cCount?.comments ?? 0) > 1
                              ? 'comentários'
                              : 'comentário',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _post.likePost(user.id!);
                          },
                          child: Icon(
                            isLiked
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            size: 24,
                            color: isLiked ? Colors.redAccent : Colors.black87,
                          ),
                        ),
                        SizedBox(width: 30),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            FeatherIcons.messageCircle,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 30),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            FeatherIcons.send,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      width: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ...List.generate(
                            3,
                            (index) => Positioned(
                              right: 22 + (index * 14.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: ImageNetwork(
                                    src: '',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                '+10',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
