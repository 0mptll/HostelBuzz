import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import 'ProfileScreen.dart';

class ProfileCompletionScreen extends StatefulWidget {
  final User user;

  const ProfileCompletionScreen({required this.user, Key? key}) : super(key: key);

  @override
  _ProfileCompletionScreenState createState() => _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends State<ProfileCompletionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _mobileNoController = TextEditingController();
  final _uniqueKeyController = TextEditingController();

  Future<void> _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      final updates = {
        'id': widget.user.id,
        'full_name': _fullNameController.text,
        'mobile': _mobileNoController.text,
        // 'birth_date': _birthDateController.text,
        // 'unique_key': _uniqueKeyController.text,
      };


      final response = await supabase.from('profile').upsert(updates).eq('id', widget.user.id);

      print( "from profile edit response" + widget.user.id + "\n" + response.toString());

      if (response != null && response.error == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      } else if (response == null) {
        // Handle the case where the response itself is null
        print('Error: No response received from Supabase.');
      } else {
        // Handle the error if the response contains an error
        print('Error saving profile: ${response.error!.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile to Continue'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mobileNoController,
                decoration: InputDecoration(labelText: 'Mobile No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _uniqueKeyController,
                decoration: InputDecoration(labelText: 'Unique Key for Hostel'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your hostel\'s unique key';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitProfile,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
