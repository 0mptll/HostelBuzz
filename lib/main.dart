import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hostelbuzz/qr_code_scanner_screen.dart';
import 'package:hostelbuzz/review_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Auth/login.dart';
import 'Auth/profile_completion_screen.dart';
import 'food_vote_screen.dart';
import 'laundry_booking_screen.dart';
import 'laundry_status_screen.dart';
import 'maintenance_request_screen.dart';
import 'splash_screen.dart';
import 'home_screen.dart';
// Import other screens as necessary

void main() async {
  /// TODO: update Supabase credentials with your own
  await Supabase.initialize(
    url: 'https://vxfsyqyrgyszntwxeeqc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4ZnN5cXlyZ3lzem50d3hlZXFjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY5MzI2ODEsImV4cCI6MjA0MjUwODY4MX0.28-EdaM-KFasYIW0Yy7U1OjsYVRMZJSSNpI_CsfdpeE',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HostelBuzz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/profileCompletion': (context) => ProfileCompletionScreen(),
        '/foodVote': (context) => const FoodVoteScreen(),
        '/reviews': (context) => const ReviewScreen(),
        '/maintenance': (context) => const MaintenanceRequestScreen(),
        '/laundryBooking': (context) => const LaundryBookingScreen(), // Add route for LaundryBookingScreen
        '/laundryStatus': (context) => const LaundryStatusScreen(),
        // Add this to the routes map in main.dart
        '/qrScanner': (context) => QRCodeScannerScreen(),
        // Add other routes as necessary
      },
    );
  }
}
