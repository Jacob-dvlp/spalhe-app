import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/controllers/moments/moments.dart';
import 'package:spalhe/utils/utils.dart';

class MomentsPage extends StatefulWidget {
  final moments;
  final Function(String) callback;
  const MomentsPage(this.moments, this.callback, {Key? key}) : super(key: key);

  @override
  _MomentsPage createState() => _MomentsPage();
}

class _MomentsPage extends State<MomentsPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animtionController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animtionController = AnimationController(vsync: this);

    final firstMoment = widget.moments['moments'][0];
    _loadMoment(moment: firstMoment, animateToPage: false);

    _animtionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animtionController.stop();
        if (_currentIndex + 1 < widget.moments['moments'].length) {
          _animtionController.reset();
          setState(() {
            _currentIndex += 1;
          });
          _loadMoment(moment: widget.moments['moments'][_currentIndex]);
        } else {
          // PASSA PRO PROXIMO STORIES
          _animtionController.stop();
          widget.callback('fim');
        }
      }
    });
  }

  // functions
  void _onTapDown(TapUpDetails details, momentlist) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (_currentIndex - 1 >= 0) {
        setState(() {
          _currentIndex -= 1;
        });
        _loadMoment(moment: widget.moments['moments'][_currentIndex]);
      } else {
        widget.callback('back');
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (_currentIndex + 1 < widget.moments['moments'].length) {
        setState(() {
          _currentIndex += 1;
        });
        _loadMoment(moment: widget.moments['moments'][_currentIndex]);
      } else {
        widget.callback('fim');
      }
    } else {
      //
    }
  }

  void _pauseMoment(status) async {
    if (status) {
      _animtionController.stop();
    } else {
      _animtionController.forward();
    }
  }

  void _loadMoment({moment, bool animateToPage = true}) {
    _animtionController.stop();
    _animtionController.reset();

    if (moment['type'] != null) {
      _animtionController.duration = const Duration(seconds: 3);
      _animtionController.forward();
    }

    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(microseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animtionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List moment = widget.moments['moments'];
    final momentlist = widget.moments['moments'][_currentIndex];
    return GetBuilder<MomentsController>(
      init: MomentsController(),
      builder: (_) => Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
            onTapUp: (details) => _onTapDown(details, momentlist),
            onLongPressStart: (details) => _pauseMoment(true),
            onLongPressEnd: (details) => _pauseMoment(false),
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: moment.length,
                  itemBuilder: (context, index) {
                    final moment = widget.moments['moments'][index];
                    if (moment['type'] != null) {
                      return CachedNetworkImage(
                        imageUrl: moment['url'],
                        fit: BoxFit.contain,
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
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: moment
                            .asMap()
                            .map((i, e) {
                              return MapEntry(
                                i,
                                AnimatedBar(
                                  animController: _animtionController,
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
                        child: UserInfo(widget.moments, _currentIndex),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  right: 20,
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _.likeMoment(moment[_currentIndex]['id']),
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${moment[_currentIndex]['__meta__']['likes_count']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () => {},
                                  icon: const Icon(
                                    FeatherIcons.messageCircle,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${moment[_currentIndex]['__meta__']['comments_count']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () => {},
                                  icon: const Icon(
                                    FeatherIcons.eye,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${moment[_currentIndex]['__meta__']['views_count']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () => {},
                              icon: const Icon(
                                FeatherIcons.trash,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Apagar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key? key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  }) : super(key: key);

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
  final user, currentIndex;
  const UserInfo(this.user, this.currentIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
            user['avatar'],
            fit: BoxFit.cover,
            width: 35,
            height: 35,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '@${user['username']}  -',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    Utils.date(user['moments'][currentIndex]['created_at']),
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
