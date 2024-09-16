import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostelbuzz/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ProfileScreen.dart';
import "ProfileCompletionScreen.dart";


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        var user = data.session?.user;

        print("from user login" + user.toString());

        if (user != null) {
          final response = await supabase
              .from('profile')
              .select()
              .eq('id', user.id)
              .maybeSingle();


          print("response:" + response.toString());
          if (response != null) {
            print("response id: ${response['id']}");

          } else {
            print("No record found");
          }

          // Handle the case where no profile is found or multiple rows are returned
          if (response== null || response['id'] == null) {
            // No profile found, redirect to profile completion
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen() ,
              ),
            );
          }
          else {
            final profile = response;

            if (profile['id'] == null || profile['full_name'] == null) {
              // Profile exists but is incomplete, redirect to profile completion
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProfileCompletionScreen(user: user),
                ),
              );
            }
            else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            }
          }
        }
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    const webClientId = '973057830739-934bpknn9dke0jh0gcivo9g90speggfr.apps.googleusercontent.com';
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      throw 'Google sign-in failed: Access token or ID token is missing';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Center(child: Text('Login - HostelBuzz'),),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _googleSignIn,
          child: const Text('Continue with Google'),
        ),
      ),
    );
  }
}

extension on PostgrestMap {
  get error => null;

  get data => null;

  get id => null;
}


