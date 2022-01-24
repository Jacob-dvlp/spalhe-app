import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/errors/errors.dart';
import 'package:spalhe/controllers/posts/posts.dart';
import 'package:spalhe/pages/moments/moment-list.dart';
import 'package:spalhe/pages/newpost/newpost.dart';
import 'package:spalhe/pages/posts/components/postItem.dart';
import 'package:spalhe/pages/search/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "create",
            onPressed: () => Get.to(NewPostPage()),
            child: const Icon(
              FeatherIcons.edit,
              color: Colors.white,
            ),
            backgroundColor: Colors.teal,
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "search",
            onPressed: () => Get.to(SearchPage()),
            child: const Icon(
              FeatherIcons.search,
              color: Colors.white,
            ),
            backgroundColor: Colors.grey.withOpacity(0.6),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        elevation: 0,
        title: SizedBox(
          child: Image.asset('assets/icon.png'),
          width: 40,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      body: GetBuilder<PostsController>(
        init: PostsController(),
        builder: (_) => RefreshIndicator(
          onRefresh: () async {
            _.getPosts();
            _.getMoments();
          },
          color: Colors.teal,
          child: ListView(
            children: [
              MomentList(),
              if (_.loading)
                const Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                  ),
                ),
              if (!_.loading && _.posts.isEmpty)
                const Errors(
                  icon: 'empty',
                  title: 'Você não tem nenhuma publicação',
                  description: 'Siga novas pessoas ou crie uma nova publicação',
                ),
              Column(
                children: List.generate(
                  _.posts.length,
                  (index) => PostItem(post: _.posts[index]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
