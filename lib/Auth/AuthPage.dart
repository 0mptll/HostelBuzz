import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';


class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In/Sign Up')),
      body: Center(
        child: SupaEmailAuth(
          redirectTo: kIsWeb ? null : 'com.example.HostelBuzz://login-callback/',
          onSignInComplete: (response) async {
            if (response.error == null) {
              final user = Supabase.instance.client.auth.currentUser;
              if (user != null) {

                if (user.emailConfirmedAt != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please verify your email address.'),
                    ),
                  );
                }
              } else {
                print('User not authenticated');
              }
            } else {
              print('Sign-in error: ${response.error!.message}');
            }
          },
          onSignUpComplete: (response) async {
            if (response.error == null) {
              final user = Supabase.instance.client.auth.currentUser;
              if (user != null) {

                if (user.emailConfirmedAt != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please verify your email address.'),
                    ),
                  );
                }
              } else {
                print('User not authenticated');
              }
            } else {
              print('Sign-up error: ${response.error!.message}');
            }
          },
          metadataFields: [
            MetaDataField(
              prefixIcon: const Icon(Icons.person),
              label: 'Username',
              key: 'username',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension on AuthResponse {
  get error => null;
}

// class AuthPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign In/Sign Up')),
//       body: Center(
//         child : SupaMagicAuth(
//           redirectUrl: kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
//           onSuccess: (Session response) {},
//           onError: (error) {},
//         )
//
//       )
//     );
//   }
// }