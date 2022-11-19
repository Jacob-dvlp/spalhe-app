import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/search.controller.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/utils/debouncer.dart';
import 'package:spalhe/utils/routes.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _debouncer = Debouncer(milliseconds: 500);

    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (searchController) {
        final users = searchController.users?.data ?? [];

        return Scaffold(
          appBar: AppBar(
            leadingWidth: 20,
            title: Container(
              height: 48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Input(
                  onChanged: (search) {
                    _debouncer.run(() {
                      searchController.getUsers(search);
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: 'search_users_explore'.tr,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Get.theme.scaffoldBackgroundColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: ListViewWraper(
            children: List.generate(
              users.length,
              (index) => InkWell(
                onTap: () => OnRoute.push(UserPage(
                  userId: users[index].id!,
                )),
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColorLight,
                    border: Border(
                      bottom: BorderSide(
                        color: Get.theme.dividerColor.withOpacity(0.05),
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Avatar(
                        user: users[index],
                        width: 40,
                        heigth: 40,
                        iconSize: 14,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            users[index].name ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          if (users[index].username != null)
                            Text(
                              '@${users[index].username ?? ''}',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
