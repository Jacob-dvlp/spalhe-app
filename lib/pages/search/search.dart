import 'package:spalhe/components/user_item/user_item.dart';
import 'package:spalhe/controllers/search/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: TextField(
            autocorrect: false,
            onChanged: (a) => _.getSearch(a),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              border: InputBorder.none,
              hintText: 'Pesquisar pelo nome de usuário...',
            ),
          ),
        ),
        body: ListView(
          children: List.generate(
            _.users.length,
            (index) => UserItem(user: _.users[index]),
          ),
        ),
      ),
    );
  }
}
