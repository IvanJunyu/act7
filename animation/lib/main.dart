import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation>
    with SingleTickerProviderStateMixin {
  bool _isTextVisible = true;
  bool _isImageVisible = true;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(_controller);
  }

  void toggleTextVisibility() {
    setState(() {
      _isTextVisible = !_isTextVisible;
    });
  }

  void toggleImageVisibility() {
    setState(() {
      _isImageVisible = !_isImageVisible;
    });
  }

  void rotateImage() {
    
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text and Image Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isTextVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 2),
              child: Text(
                'Here is a super cute cat ',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _isImageVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 2),
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/rolling_cat.png', 
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: toggleTextVisibility,
              child: Text(_isTextVisible ? 'Hide Text' : 'Show Text'), 
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: rotateImage,
              child: Text('Rotate Cat'),
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: toggleImageVisibility,
              child: Text(_isImageVisible ? 'Hide Image' : 'Show Image'), 
            ),
          ],
        ),
      ),
    );
  }
}
