import 'package:anxietynomore/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:anxietynomore/pop_fidget_toy.dart';
import 'package:anxietynomore/flash_card_grid.dart';
import 'package:confetti/confetti.dart';

class FidgetPage extends StatefulWidget {
  @override
  _FidgetPageState createState() => _FidgetPageState();
}

class _FidgetPageState extends State<FidgetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ConfettiController _confcontroller;
  bool isToggleOn = false;
  bool isSpacebarPressed = false;
  bool isLampOn = false;
  bool isPenClicked = false;
  double red = 0;
  double green = 0;
  double blue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _confcontroller = ConfettiController(duration: Duration(seconds: 2));
  }

  void _toggleToggle() {
    setState(() {
      isToggleOn = !isToggleOn;
    });
  }

  void _toggleSpacebar() {
    setState(() {
      isSpacebarPressed = true;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        isSpacebarPressed = false;
      });
    });
  }

  void _toggleLamp() {
    setState(() {
      isLampOn = !isLampOn;
    });
  }

  void _togglePenClick() {
    setState(() {
      isPenClicked = !isPenClicked;
      if (isPenClicked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Toggle Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Switch(
                    value: isToggleOn,
                    onChanged: (newValue) {
                      _toggleToggle();
                    },
                  ),
                  GestureDetector(
                    onTap: _toggleLamp,
                    child: Container(
                      width: 100,
                      height: 150,
                      decoration: BoxDecoration(
                        color: isLampOn ? Colors.yellow[200] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          isLampOn ? Icons.lightbulb : Icons.lightbulb_outline,
                          size: 48,
                          color:
                              isLampOn ? Colors.yellow[800] : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Custom Spacebar Key
              GestureDetector(
                onTap: _toggleSpacebar,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: isSpacebarPressed ? 350 : 400,
                  height: isSpacebarPressed ? 40 : 50,
                  decoration: BoxDecoration(
                    color: isSpacebarPressed ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'SPACE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RGBBox(Color.fromRGBO(
                      red.toInt(), green.toInt(), blue.toInt(), 1)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Slider(
                        thumbColor: Colors.red,
                        activeColor: Colors.red,
                        value: red,
                        min: 0,
                        max: 255,
                        onChanged: (value) {
                          setState(() {
                            red = value;
                          });
                        },
                      ),
                      Slider(
                        thumbColor: Colors.green,
                        activeColor: Colors.green,
                        value: green,
                        min: 0,
                        max: 255,
                        onChanged: (value) {
                          setState(() {
                            green = value;
                          });
                        },
                      ),
                      Slider(
                        thumbColor: Colors.blue,
                        activeColor: Colors.blue,
                        value: blue,
                        min: 0,
                        max: 255,
                        onChanged: (value) {
                          setState(() {
                            blue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              // Lamp
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            _confcontroller.play();
                          },
                          child: Image.asset("assets/fidget/popper_icon.png"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.all(50),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ConfettiWidget(
                          confettiController: _confcontroller,
                          blastDirectionality: BlastDirectionality.explosive,
                          // blastDirection: 3.14, // radial value
                          maxBlastForce:
                              50, // set a lower number for slow explosions
                          minBlastForce:
                              30, // set a higher number for faster explosions
                          emissionFrequency: 0.05, // how often it should emit
                          numberOfParticles: 50,
                          maximumSize: const Size(10.0, 10.0),
                          minimumSize: const Size(
                              5.0, 5.0), // number of particles to emit
                          gravity: 1,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // Clicking Pen
              GestureDetector(
                onTap: _togglePenClick,
                child: Container(
                  width: 100,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                      child: Icon(
                        Icons.edit,
                        size: 48,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _navigateToPage(PopFidgetToy()),
                    child: Image.asset("assets/fidget/popper_icon.png"),
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToPage(CounterScreen()),
                    child: Image.asset("assets/fidget/tap_icon.png"),
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToPage(FlashCardPage()),
                    child: Image.asset("assets/fidget/flash_icon.png"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RGBBox extends StatelessWidget {
  final Color color;

  RGBBox(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 100,
      height: 200,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
    );
  }
}
