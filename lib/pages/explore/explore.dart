import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/explore/explore.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      init: ExploreController(),
      builder: (_) => Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Explorar'),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await _.getImages();
              await _.getUsers();
            },
            color: ThemeData(
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                        secondary: Theme.of(context).primaryColorLight))
                .colorScheme
                .secondary,
            backgroundColor: Theme.of(context).primaryColorDark,
            child: ListView(
              children: <Widget>[
                Container(
                  height: 90,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    children: List.generate(_.users.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(200),
                          onTap: () => Utils.routeUser(_.users[index]),
                          child: Column(
                            children: [
                              Avatar(
                                  url: _.users[index]['avatar'],
                                  width: 45.0,
                                  height: 45.0),
                              const SizedBox(height: 5),
                              Text(
                                _.users[index]['name'].split(" ")[0],
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  children: List.generate(
                    _.images.length,
                    (index) => InkWell(
                      onTap: () => Get.to(PostPage(_.images[index]['id'])),
                      child: CachedNetworkImage(
                        imageUrl: _.images[index]['files'][0]['url'],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
