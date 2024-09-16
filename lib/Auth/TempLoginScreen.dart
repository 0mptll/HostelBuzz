import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostelbuzz/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ProfileScreen.dart';
import "ProfileCompletionScreen.dart";


class TempLoginScreen extends StatefulWidget {
  const TempLoginScreen({super.key});

  @override
  State<TempLoginScreen> createState() => _TempLoginScreenState();
}

class _TempLoginScreenState extends State<TempLoginScreen> {
  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        final user = data.session?.user;

        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ),
          );

        }
        else {
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    await dotenv.load(fileName: '.env');
    // const webClientId = '973057830739-934bpknn9dke0jh0gcivo9g90speggfr.apps.googleusercontent.com';
    var webClientId =  dotenv.get('GOOGLE_WEB_CLIENT_ID') ;
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
}


