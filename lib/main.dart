import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/envelope_screen.dart';

void main() {
  runApp(const DateInviteApp());
}

class DateInviteApp extends StatelessWidget {
  const DateInviteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Приглашение на свидание',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E8C),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.latoTextTheme(),
        useMaterial3: true,
      ),
      home: const EnvelopeScreen(),
    );
  }
}
