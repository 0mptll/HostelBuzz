import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import 'LoginScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          TextButton(
            onPressed: () async {
              await supabase.auth.signOut();
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
            child: const Text('Sign out'),
          )
        ],
      ),
      body: FutureBuilder(
        future: _fetchUserProfile(), // Fetch user profile data
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No profile data found.'));
          } else {
            final data = snapshot.data!;
            final profileImageUrl = data['avatar_url'] as String?;
            final fullName = data['full_name'] as String?;
            final hostelKey = data['hostel_key'] as String?;
            final phoneNumber = data['phone'] as String?;

            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (profileImageUrl != null)
                    ClipOval(
                      child: Image.network(
                        profileImageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    fullName ?? '',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Hostel Key: ${hostelKey ?? 'N/A'}',
                  ),
                  Text(
                    'Phone: ${phoneNumber ?? 'N/A'}',
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single() ;

    if (response?.error != null) {
      throw Exception('Error fetching profile data: ${response.error!.message}');
    }

    return response.data as Map<String, dynamic>;
  }
}
