import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sad_screen.dart';
import 'restaurant_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with SingleTickerProviderStateMixin {
  final _random = math.Random();
  Offset _noButtonPosition = const Offset(0, 0);
  bool _noPositioned = false;
  late AnimationController _heartController;
  late Animation<double> _heartAnim;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _heartAnim = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _fleeNoButton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const btnW = 110.0;
    const btnH = 50.0;
    final maxX = size.width - btnW;
    final maxY = size.height - btnH - 100;

    setState(() {
      _noPositioned = true;
      _noButtonPosition = Offset(
        _random.nextDouble() * maxX,
        _random.nextDouble() * maxY + 80,
      );
    });
  }

  void _onYes() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => const RestaurantScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _onNo() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => const SadScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Widget _buildNoButton(BuildContext context) {
    return MouseRegion(
      onHover: (_) => _fleeNoButton(context),
      child: GestureDetector(
        onTap: _onNo,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Text(
            'Нет',
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: Stack(
        children: [
          // Decorative background hearts
          ...List.generate(8, (i) {
            final positions = [
              const Offset(30, 60),
              const Offset(280, 40),
              const Offset(60, 200),
              const Offset(300, 160),
              const Offset(20, 350),
              const Offset(310, 320),
              const Offset(100, 450),
              const Offset(240, 480),
            ];
            final opacities = [0.1, 0.08, 0.12, 0.07, 0.09, 0.11, 0.08, 0.1];
            final pos = i < positions.length
                ? positions[i]
                : Offset(
                    _random.nextDouble() * size.width,
                    _random.nextDouble() * size.height,
                  );
            return Positioned(
              left: pos.dx,
              top: pos.dy,
              child: Opacity(
                opacity: opacities[i % opacities.length],
                child: Text(
                  '❤️',
                  style: TextStyle(fontSize: 40 + (i * 8).toDouble()),
                ),
              ),
            );
          }),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _heartAnim,
                    child: const Text('💌', style: TextStyle(fontSize: 72)),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Дарина,',
                    style: GoogleFonts.dancingScript(
                      fontSize: 36,
                      color: const Color(0xFFE91E8C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Пойдёшь со мной\nна свидание? 💌',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dancingScript(
                      fontSize: 30,
                      color: const Color(0xFFAD1457),
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Yes button
                  GestureDetector(
                    onTap: _onYes,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE91E8C), Color(0xFFF06292)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE91E8C).withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        'Да 💕',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "No" button — only shown here when NOT yet positioned
                  if (!_noPositioned) _buildNoButton(context),
                ],
              ),
            ),
          ),

          // Fleeing "No" button in Positioned overlay
          if (_noPositioned)
            Positioned(
              left: _noButtonPosition.dx,
              top: _noButtonPosition.dy,
              child: _buildNoButton(context),
            ),
        ],
      ),
    );
  }
}
