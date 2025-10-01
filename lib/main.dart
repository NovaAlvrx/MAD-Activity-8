import 'package:flutter/material.dart';


//------ Main Entry Point of the App -------
void main() {
  runApp(MyApp());
}


//------ MyApp Widget: Root of the Application -------
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


//------ _MyAppState: Manages Theme State and Builds MaterialApp -------
class _MyAppState extends State<MyApp> {
  // Track whether the app is currently in dark mode or not
  bool _isDarkMode = false;

  // Toggle the theme mode between light and dark
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode; // Switch theme mode flag
    });
  }

  // Build the MaterialApp with theme settings and home widget
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(), // Light theme configuration
      darkTheme: ThemeData.dark(), // Dark theme configuration
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light, // Apply theme based on _isDarkMode
      home: FadingTextAnimation(
        toggleTheme: _toggleTheme, // Pass toggle function to child widget
      ),
    );
  }
}


//------ FadingTextAnimation Widget: Displays Text with Fade Animation and Theme Toggle Button -------
class FadingTextAnimation extends StatefulWidget {
  final VoidCallback toggleTheme; // Callback to toggle the app theme

  FadingTextAnimation({required this.toggleTheme});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}


//------ _FadingTextAnimationState: Controls Visibility Animation and UI Elements -------
class _FadingTextAnimationState extends State<FadingTextAnimation> {
  // Controls visibility of the text for fade animation
  bool _isVisible = true;

  // Toggle the visibility state to trigger fade animation
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // Build the UI with animated fading text, buttons to toggle visibility and theme
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          // Icon button in AppBar to toggle between light and dark themes
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedOpacity widget to fade the text in and out based on _isVisible
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text(
                'Hello, Flutter!',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 16),
            // Elevated button to toggle the app theme (light/dark)
            ElevatedButton(
              onPressed: widget.toggleTheme,
              child: Text("Toggle Theme"),
            ),
          ],
        ),
      ),
      // Floating action buttons to control text animation and theme toggle
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Button to start/stop the fade animation by toggling text visibility
          FloatingActionButton(
            onPressed: toggleVisibility,
            child: Icon(Icons.play_arrow),
          ),
          SizedBox(height: 16),
          // Button to toggle the app theme (light/dark)
          FloatingActionButton(
            onPressed: widget.toggleTheme,
            child: Icon(Icons.brightness_6),
          ),
        ],
      ),
    );
  }
}
