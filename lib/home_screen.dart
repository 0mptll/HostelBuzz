import 'package:flutter/material.dart';
import 'custom_drawer.dart';
import 'qr_code_scanner_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];
    final fullName = user?.userMetadata?['full_name'] ?? 'User'; // Default name if not available

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            const SizedBox(width: 8), // Space for the drawer icon
            Image.asset(
              'assets/DDU_2.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Welcome to DDU Hostel',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Profile Picture Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Centered Profile Picture
                  CircleAvatar(
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl)
                        : null,
                    child: profileImageUrl == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                    radius: 50, // Adjust the radius as needed
                  ),
                  const SizedBox(height: 8),
                  // Display User's Name
                  Text(
                    fullName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Main Content Section
            Center(
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/foodVote');
                    },
                    child: const Text('Vote on Food'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/reviews');
                    },
                    child: const Text('Rate and Review Food'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/maintenance');
                    },
                    child: const Text('Maintenance Requests'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QRCodeScannerScreen()),
                      );
                    },
                    child: const Text('Scan QR Code'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
