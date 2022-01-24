import 'package:flutter/material.dart';
import 'moment.dart';

class UserMomentsPage extends StatefulWidget {
  final moments;
  const UserMomentsPage(this.moments, {Key? key}) : super(key: key);
  @override
  UserMomentsState createState() => UserMomentsState(moments);
}

class UserMomentsState extends State<UserMomentsPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  final moments;
  UserMomentsState(this.moments);

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  callback(String value) {
    if (value == 'fim') {
      if (_currentIndex + 1 < widget.moments.length) {
        _pageController.animateToPage(
          _currentIndex + 1,
          duration: Duration(microseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: Duration(microseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: PageView.builder(
          onPageChanged: (int page) {
            setState(() {
              _currentIndex = page;
            });
          },
          controller: _pageController,
          itemCount: widget.moments.length,
          itemBuilder: (context, index) {
            return MomentsPage(widget.moments[index], callback);
          },
        ),
      ),
    );
  }
}
