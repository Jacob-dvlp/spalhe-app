import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/comment_item/comment_item.dart';
import 'package:spalhe/controllers/posts/post.dart';
import 'package:spalhe/pages/posts/components/postItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';

class PostPage extends StatelessWidget {
  final int id;
  const PostPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      init: PostController(id),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Publicação'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  if (!_.postLoading && _.postError)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/error.svg',
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'A publicação não está mais disponível',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('Ela pode ter sido removida pelo autor.'),
                      ],
                    ),
                  if (!_.postLoading && !_.postError)
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        PostItem(post: _.post, type: 'post_comment'),
                        Column(
                          children: List.generate(
                            _.comments.length,
                            (index) => CommentsComponent(
                              comment: _.comments[index],
                              reply: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (_.postLoading)
                    const Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.grey),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
              ),
              child: SafeArea(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: HashTagTextField(
                          controller: _.textController,
                          decoration: const InputDecoration(
                            hintText: 'Insira o seu comentário',
                            border: InputBorder.none,
                          ),
                          decoratedStyle: const TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          decorateAtSign: true,
                        ),
                      ),
                      InkWell(
                        child: const Icon(FeatherIcons.send),
                        onTap: () => _.comment(),
                      ),
                      const SizedBox(width: 20)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
