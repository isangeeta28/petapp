import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF76C7C0), Color(0xFFF5B7B1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Text
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Pet Adoption',
                      textStyle: const TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: const Duration(milliseconds: 150),
                    ),
                  ],
                  //totalRepeatCount: 1,
                ),
                const SizedBox(height: 20),
                // Subtitle
                AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText(
                      'Find your furry friend!',
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                    FadeAnimatedText(
                      'Adopt, Don’t Shop!',
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                    FadeAnimatedText(
                      'Bring Love Home!',
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                  onFinished: () {
                    // Navigate to HomeScreen after animation
                    context.pushReplacement('/home');
                  },
                  totalRepeatCount: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
