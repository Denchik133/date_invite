import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'question_screen.dart';

class EnvelopeScreen extends StatefulWidget {
  const EnvelopeScreen({super.key});

  @override
  State<EnvelopeScreen> createState() => _EnvelopeScreenState();
}

class _EnvelopeScreenState extends State<EnvelopeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flapAnimation;
  late Animation<double> _letterAnimation;
  bool _tapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _flapAnimation = Tween<double>(begin: 0, end: -math.pi / 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _letterAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_tapped) return;
    setState(() => _tapped = true);
    _controller.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, animation, __) => const QuestionScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'У тебя есть письмо 💌',
              style: GoogleFonts.dancingScript(
                fontSize: 28,
                color: const Color(0xFFE91E8C),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Нажми на конверт, чтобы открыть',
              style: GoogleFonts.lato(
                fontSize: 15,
                color: Colors.pink.shade300,
              ),
            ),
            const SizedBox(height: 48),
            GestureDetector(
              onTap: _onTap,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return SizedBox(
                    width: 240,
                    height: 200,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Letter peeking out
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 60,
                          child: Transform.translate(
                            offset: Offset(0, -_letterAnimation.value * 40),
                            child: Opacity(
                              opacity: _letterAnimation.value,
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.pink.withValues(alpha: 0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, -2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '💕',
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Envelope body
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB6C1),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pink.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Envelope bottom triangle
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: CustomPaint(
                            size: const Size(240, 150),
                            painter: _EnvelopeBottomPainter(),
                          ),
                        ),

                        // Left flap
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: CustomPaint(
                            size: const Size(130, 150),
                            painter: _EnvelopeLeftPainter(),
                          ),
                        ),

                        // Right flap
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CustomPaint(
                            size: const Size(130, 150),
                            painter: _EnvelopeRightPainter(),
                          ),
                        ),

                        // Top flap (animates open)
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Transform(
                            alignment: Alignment.topCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(_flapAnimation.value),
                            child: CustomPaint(
                              size: const Size(240, 100),
                              painter: _EnvelopeFlapPainter(),
                            ),
                          ),
                        ),

                        // Heart seal
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 60,
                          child: Opacity(
                            opacity: (1 - _controller.value * 2).clamp(0, 1),
                            child: const Center(
                              child: Text('❤️', style: TextStyle(fontSize: 28)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            AnimatedOpacity(
              opacity: _tapped ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E8C).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFFE91E8C).withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '✨ Нажми, чтобы открыть ✨',
                  style: GoogleFonts.lato(
                    color: const Color(0xFFE91E8C),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnvelopeBottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFF48FB1);
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height * 0.6)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EnvelopeLeftPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFF06292);
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height * 0.5)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EnvelopeRightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFEC407A);
    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, size.height * 0.5)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EnvelopeFlapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFE91E8C);
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
