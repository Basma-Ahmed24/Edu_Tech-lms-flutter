import 'dart:async';
import 'package:flutter/material.dart';

class AutomaticSliderCard extends StatefulWidget {
  final List<Widget>? children;
  final double? height;
  final Duration? duration;

  AutomaticSliderCard({this.children, this.height, this.duration});

  @override
  _AutomaticSliderCardState createState() => _AutomaticSliderCardState();
}

class _AutomaticSliderCardState extends State<AutomaticSliderCard> {
  PageController? _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(widget.duration ?? Duration(seconds: 3), (Timer timer) {
      if (_pageController!.page! >= (widget.children!.length ~/ 2) - 1) {
        _pageController!.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        _pageController!.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: widget.height,
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            final pairIndex = index % (widget.children!.length ~/ 2);
            final firstChildIndex = pairIndex * 2;
            final secondChildIndex = pairIndex * 2 + 1;
            return Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.children![firstChildIndex],
                widget.children![secondChildIndex],
              ],
            );
          },
        ),
      ),
    );
  }
}
