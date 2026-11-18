import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  bool _signed = false;
  late AnimationController _signController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _signController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _signController, curve: Curves.elasticOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _signController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _signController.dispose();
    super.dispose();
  }

  void _onSignatureTap() {
    if (_signed) return;
    setState(() => _signed = true);
    _signController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text('🍷', style: TextStyle(fontSize: 56)),
                    const SizedBox(height: 12),
                    Text(
                      'Столик забронирован!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                        fontSize: 32,
                        color: const Color(0xFFE91E8C),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0F5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.pink.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('📅',
                              style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            'Пятница, 20 ноября в 19:00',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: const Color(0xFFAD1457),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Signature section
              Text(
                'Прошу твою подпись:',
                style: GoogleFonts.lato(
                  fontSize: 17,
                  color: Colors.pink.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: _onSignatureTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 220,
                  height: 110,
                  decoration: BoxDecoration(
                    color: _signed
                        ? Colors.pink.shade50
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _signed
                          ? const Color(0xFFE91E8C)
                          : Colors.pink.shade200,
                      width: _signed ? 2 : 1.5,
                      style: BorderStyle.solid,
                    ),
                    boxShadow: _signed
                        ? [
                            BoxShadow(
                              color: const Color(0xFFE91E8C)
                                  .withOpacity(0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: _signed
                        ? AnimatedBuilder(
                            animation: _signController,
                            builder: (context, child) {
                              return FadeTransition(
                                opacity: _fadeAnim,
                                child: ScaleTransition(
                                  scale: _scaleAnim,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        '❤️',
                                        style: TextStyle(fontSize: 48),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Подписано с любовью',
                                        style: GoogleFonts.dancingScript(
                                          fontSize: 13,
                                          color: const Color(0xFFE91E8C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                color: Colors.pink.shade200,
                                size: 28,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Нажми, чтобы подписать',
                                style: GoogleFonts.lato(
                                  fontSize: 13,
                                  color: Colors.pink.shade300,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                '— Денис',
                style: GoogleFonts.dancingScript(
                  fontSize: 22,
                  color: const Color(0xFFAD1457),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              // Celebration
              AnimatedOpacity(
                opacity: _signed ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('🎉', style: TextStyle(fontSize: 28)),
                        SizedBox(width: 8),
                        Text('💕', style: TextStyle(fontSize: 28)),
                        SizedBox(width: 8),
                        Text('🎉', style: TextStyle(fontSize: 28)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'До встречи в пятницу! 🌹',
                      style: GoogleFonts.dancingScript(
                        fontSize: 24,
                        color: const Color(0xFFE91E8C),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'С любовью, Денис ❤️',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.pink.shade400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
