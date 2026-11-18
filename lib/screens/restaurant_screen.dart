import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

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
              const Text('🥰', style: TextStyle(fontSize: 72)),
              const SizedBox(height: 28),
              Text(
                'Дарина,',
                style: GoogleFonts.dancingScript(
                  fontSize: 36,
                  color: const Color(0xFFE91E8C),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'я рад, что ты согласна! 🥰',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                        fontSize: 24,
                        color: const Color(0xFFAD1457),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFFFB6C1)),
                    const SizedBox(height: 20),
                    Text(
                      'Предлагаю посетить ресторан',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.pink.shade700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '«Гага»',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                        fontSize: 42,
                        color: const Color(0xFFE91E8C),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '🇬🇪 Восхитительная грузинская кухня',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: Colors.pink.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'где представлена восхитительная\nгрузинская кухня.\nДумаю, тебе понравится ✨',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.pink.shade700,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Decorative stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('✨', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text('🌹', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text('✨', style: TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 32),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) =>
                          const BookingScreen(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(
                            opacity: animation, child: child);
                      },
                      transitionDuration:
                          const Duration(milliseconds: 500),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48, vertical: 18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE91E8C), Color(0xFFF06292)],
                    ),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color(0xFFE91E8C).withOpacity(0.4),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    'Я согласна! 💕',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
