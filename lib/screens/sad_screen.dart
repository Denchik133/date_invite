import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SadScreen extends StatelessWidget {
  const SadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '😿',
                style: TextStyle(fontSize: 96),
              ),
              const SizedBox(height: 32),
              Text(
                'Почему ты не хочешь\nидти со мной\nна свидание?',
                textAlign: TextAlign.center,
                style: GoogleFonts.dancingScript(
                  fontSize: 28,
                  color: const Color(0xFFAD1457),
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '💔',
                style: const TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.pink.shade200),
                ),
                child: Text(
                  'Денис очень расстроен...',
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    color: Colors.pink.shade400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0xFFE91E8C)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Вернуться назад 🥺',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      color: const Color(0xFFE91E8C),
                      fontWeight: FontWeight.w600,
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
