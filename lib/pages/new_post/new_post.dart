import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/form/input/input.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('nova publicação'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Form(
            child: Column(
              children: [
                Input(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'o que você quer espalhar?',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FeatherIcons.image,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.video_collection_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FeatherIcons.atSign,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FeatherIcons.mapPin,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('postar'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
