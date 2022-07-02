import 'package:flutter/material.dart';
import 'package:spalhe/models/moment.model.dart';
import 'package:spalhe/pages/stories/components/moment.dart';

class MomentPage extends StatefulWidget {
  final List<MomentModel> moments;
  final int index;
  const MomentPage({required this.moments, required this.index});
  @override
  createState() => _MomentPageState();
}

class _MomentPageState extends State<MomentPage> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  callback(String value) {
    if (value == 'fim') {
      if (_currentIndex + 1 < widget.moments.length) {
        _pageController?.animateToPage(
          _currentIndex + 1,
          duration: Duration(microseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _pageController?.animateToPage(
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
            return StoreStoriesPage(
              moment: widget.moments[index],
              callback: callback,
            );
          },
        ),
      ),
    );
  }
}
