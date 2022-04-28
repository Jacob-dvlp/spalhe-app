import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/theme/colors.dart';

class PostItem extends StatelessWidget {
  PostItem({Key? key, this.post}) : super(key: key);
  final PostData? post;

  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final user = post?.user;
    final medias = post?.medias;

    return Container(
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: ImageNetwork(
                      src: user?.avatar ?? '',
                      width: 38,
                      height: 38,
                    ),
                  ),
                  Positioned(
                    right: -3,
                    bottom: -2,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
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
                          Text(user?.name ?? ''),
                          Text(
                            '@${user?.username}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '12:23',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
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
                text: post?.text ?? '',
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
                        borderRadius: BorderRadius.circular(4),
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
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: 0.5,
                child: Text(
                  'Ver todos os 10 comentários',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border_outlined),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FeatherIcons.messageCircle),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FeatherIcons.send),
                    iconSize: 20,
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
        ],
      ),
    );
  }
}
