import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/utils/routes.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('escolher localização'),
      ),
      body: GetBuilder<PostController>(
        builder: (_post) {
          return ListViewWraper(
            padding: EdgeInsets.all(20),
            children: [
              Input(
                label: 'digite o endereço',
                onChanged: (v) => _post.getPlaces(v),
              ),
              SizedBox(height: 14),
              Column(
                children: List.generate(
                  _post.locations?.length ?? 0,
                  (index) => InkWell(
                    onTap: () {
                      final loc = _post.locations![index];
                      _post.setData('location', {
                        "name": loc.description ?? '',
                        "long": loc.distanceMeters,
                        "lat": loc.distanceMeters,
                      });
                      OnRoute.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              _post.locations?[index].description ?? '',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
