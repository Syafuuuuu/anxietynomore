import 'package:flutter/material.dart';
import 'package:anxietynomore/counter_screen.dart';
import 'package:anxietynomore/pop_fidget_toy.dart';
import 'package:anxietynomore/flash_card_grid.dart';

class AnimatedFidgetPage extends StatefulWidget {
  @override
  _AnimatedFidgetPageState createState() => _AnimatedFidgetPageState();
}

class _AnimatedFidgetPageState extends State<AnimatedFidgetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _lampOffsetAnimation;
  late Animation<Offset> _penOffsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _lampOffsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, 0.5),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _penOffsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.count(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          padding: EdgeInsets.all(16),
          children: [
            // Toggle Button
            // Wrap with SlideTransition
            SlideTransition(
              position: _lampOffsetAnimation,
              child: Switch(
                value: false,
                onChanged: (newValue) {
                  // Add your logic here
                },
              ),
            ),
            // Custom Spacebar Key
            // Wrap with SlideTransition
            SlideTransition(
              position: _penOffsetAnimation,
              child: GestureDetector(
                onTap: () {
                  // Add your logic here
                },
                child: Container(
                  // Your container widget
                ),
              ),
            ),
            // Lamp
            // Wrap with SlideTransition
            SlideTransition(
              position: _lampOffsetAnimation,
              child: GestureDetector(
                onTap: () {
                  // Add your logic here
                },
                child: Container(
                  // Your container widget
                ),
              ),
            ),
            // Clicking Pen
            // Wrap with SlideTransition
            SlideTransition(
              position: _penOffsetAnimation,
              child: GestureDetector(
                onTap: () {
                  // Add your logic here
                },
                child: Container(
                  // Your container widget
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(PopFidgetToy()),
              child: Text('Page 1'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(CounterScreen()),
              child: Text('Page 2'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(FlashCardPage()),
              child: Text('Page 3'),
            ),
          ],
        ),
      ),
    );
  }
}