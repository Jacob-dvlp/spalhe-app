import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spalhe/models/moment.model.dart';
import 'package:spalhe/utils/date.dart';

class StoreStoriesPage extends StatefulWidget {
  final MomentModel moment;
  final Function(String) callback;
  StoreStoriesPage({required this.moment, required this.callback});

  @override
  _MomentsPage createState() => _MomentsPage();
}

class _MomentsPage extends State<StoreStoriesPage>
    with SingleTickerProviderStateMixin {
  PageController? _pageController;
  AnimationController? _animtionController;
  int _currentIndex = 0;

  @override
  void initState() {
    final story = widget.moment;

    super.initState();
    _pageController = PageController();
    _animtionController = AnimationController(vsync: this);

    final firstMoment = story.moments?[0];

    _loadMoment(story: firstMoment, animateToPage: false);

    _animtionController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animtionController?.stop();
        if (_currentIndex + 1 < story.moments!.length) {
          _animtionController?.reset();
          setState(() {
            _currentIndex += 1;
          });
          _loadMoment(story: story.moments![_currentIndex]);
        } else {
          // PASSA PRO PROXIMO STORIES
          _animtionController?.stop();
          widget.callback('fim');
        }
      }
    });
  }

  // functions
  void _onTapDown(TapUpDetails details, momentlist) {
    final story = widget.moment;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (_currentIndex - 1 >= 0) {
        setState(() {
          _currentIndex -= 1;
        });
        _loadMoment(story: story.moments![_currentIndex]);
      } else {
        widget.callback('back');
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (_currentIndex + 1 < story.moments!.length) {
        setState(() {
          _currentIndex += 1;
        });
        _loadMoment(story: story.moments![_currentIndex]);
      } else {
        widget.callback('fim');
      }
    } else {
      //
    }
  }

  void _pauseMoment(status) async {
    if (status) {
      _animtionController?.stop();
    } else {
      _animtionController?.forward();
    }
  }

  void _loadMoment({Moments? story, bool animateToPage = true}) {
    _animtionController?.stop();
    _animtionController?.reset();

    if (story?.type != null) {
      Image _image = new Image.network(
        '${story?.url ?? ''}',
      );

      _image.image.resolve(new ImageConfiguration()).addListener(
        ImageStreamListener(
          (ImageInfo info, bool syncCall) {
            _animtionController?.duration = Duration(seconds: 3);
            _animtionController?.forward();
          },
        ),
      );
    }

    if (animateToPage) {
      _pageController?.animateToPage(
        _currentIndex,
        duration: Duration(microseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _animtionController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.moment.moments;
    final momentlist = story![_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: (details) => _onTapDown(details, momentlist),
        onLongPressStart: (details) => _pauseMoment(true),
        onLongPressEnd: (details) => _pauseMoment(false),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: story.length,
              itemBuilder: (context, index) {
                final stories = story[index];
                if (stories.type != null) {
                  return Stack(
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: '${stories.url ?? ''}',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Positioned(
                          bottom: 30,
                          left: 20,
                          right: 20,
                          child: SafeArea(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '2',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 20),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.tag_faces_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '2',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Positioned(
              top: 40.0,
              left: 10.0,
              right: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: story
                          .asMap()
                          .map((i, e) {
                            return MapEntry(
                              i,
                              AnimatedBar(
                                animController: _animtionController!,
                                position: i,
                                currentIndex: _currentIndex,
                              ),
                            );
                          })
                          .values
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.0,
                      ),
                      child: UserInfo(widget.moment, _currentIndex),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    required this.animController,
    required this.position,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 3.5,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black.withOpacity(0.3),
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final MomentModel user;
  final int currentIndex;
  UserInfo(this.user, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
            user.avatar ?? '',
            fit: BoxFit.cover,
            width: 35,
            height: 35,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.username ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    fromNow(user.moments?[currentIndex].createdAt ?? ''),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
