import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/layout/image/image.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: ImageNetwork(
                  src: '',
                  width: 20,
                  height: 20,
                ),
              ),
              SizedBox(width: 10),
              Row(
                children: [
                  Text('thiagobruno'),
                  Text(
                    '12:23',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nossa equeipe pronta'),
              SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: ImageNetwork(
                  src:
                      'https://blog.portalpos.com.br/app/uploads/2021/05/tipos-de-perfil-profissional.jpg',
                  width: Size.infinite.width,
                  height: 300,
                ),
              )
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ver todos os 10 comentários',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
