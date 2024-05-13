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
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // Toggle Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      height: 150,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          value: isToggleOn,
                          onChanged: (newValue) {
                            _toggleToggle();
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggleLamp,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color:
                              isLampOn ? Colors.yellow[200] : Colors.grey[200],
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
                            isLampOn
                                ? Icons.lightbulb
                                : Icons.lightbulb_outline,
                            size: 48,
                            color: isLampOn
                                ? Colors.yellow[800]
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Custom Spacebar Key
                GestureDetector(
                  onTap: _toggleSpacebar,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    width: isSpacebarPressed ? 350 : 400,
                    height: isSpacebarPressed ? 60 : 70,
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
                    child: const Center(
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
                const SizedBox(
                  height: 20,
                ),
                //RGB Colour Fidget
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 200,
                          child: RGBBox(Color.fromRGBO(
                              red.toInt(), green.toInt(), blue.toInt(), 1)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 230,
                          child: Column(
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
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Confetti Fidget
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Clicking Pen
                    GestureDetector(
                      onTap: _togglePenClick,
                      child: Container(
                        width: 230,
                        height: 150,
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
                            turns: Tween(begin: 0.0, end: 0.5)
                                .animate(_controller),
                            child: const Icon(
                              Icons.edit,
                              size: 48,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              _confcontroller.play();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            child: Image.asset(
                              "assets/fidget/confetti_icon.png",
                              fit: BoxFit.contain,
                              width: 120,
                              height: 150,
                            ),
                          ),
                        ),
                        Container(
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _navigateToPage(PopFidgetToy()),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.all(50),
                      ),
                      child: Image.asset(
                        "assets/fidget/popper_icon.png",
                        fit: BoxFit.contain,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _navigateToPage(CounterScreen()),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.all(50),
                      ),
                      child: Image.asset(
                        "assets/fidget/tap_icon.png",
                        fit: BoxFit.contain,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _navigateToPage(FlashCardPage()),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.all(50),
                      ),
                      child: Image.asset(
                        "assets/fidget/flash_icon.png",
                        fit: BoxFit.contain,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
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
