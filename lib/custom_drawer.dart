import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header with Profile Picture
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            accountName: Text(user?.userMetadata?['full_name'] ?? 'Guest'),
            accountEmail: Text(user?.email ?? 'Not logged in'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: profileImageUrl != null
                  ? NetworkImage(profileImageUrl)
                  : const AssetImage('assets/default_avatar.png') as ImageProvider, // Placeholder image
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/home');
            },
          ),
          ListTile(
            title: const Text('Food Voting'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/foodVote');
            },
          ),
          ListTile(
            title: const Text('Rate and Review'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/reviews');
            },
          ),
          ListTile(
            title: const Text('Maintenance Requests'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/maintenance');
            },
          ),
          ListTile(
            title: const Text('Book Laundry'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/laundryBooking');
            },
          ),
          ListTile(
            title: const Text('Laundry Status'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/laundryStatus');
            },
          ),
          const Divider(), // Optional divider
          ListTile(
            title: const Text('Logout'),
            onTap: () async {
              await supabase.auth.signOut(); // Sign out from Supabase
              Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login screen
            },
          ),
        ],
      ),
    );
  }
}
