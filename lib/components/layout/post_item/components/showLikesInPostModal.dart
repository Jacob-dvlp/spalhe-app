import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spalhe/controllers/post_item.controller.dart';
import 'package:spalhe/models/post.model.dart';

ShowLikesInPostModal({required PostData post, required BuildContext context}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return GetBuilder<PostItemController>(
          global: true,
          autoRemove: false,
          init: new PostItemController(post: post),
          tag: post.id.toString(),
          assignId: true,
          builder: (controlelr) {
            final userLiked = controlelr.userLikes.getPostLikes ?? [];

            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Wrap(
                  children: List.generate(
                    userLiked.length,
                    (index) {
                      final user = userLiked[index].user;

                      return Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user?.avatar ?? ''),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.name ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '@${user?.username ?? ''}',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          });
    },
  );
}
