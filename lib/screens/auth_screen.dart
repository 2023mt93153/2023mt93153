import 'package:flutter/material.dart';
import 'package:quicktask/screens/task_list_screen.dart';
import 'package:quicktask/services/api_service.dart'; // Import the ApiService

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isSignUp = false; // Toggle between Sign-Up and Login

  Future<void> _submit() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter both email and password')));
      return;
    }

    try {
      if (isSignUp) {
        await ApiService.signUp(email, password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign-up successful!')));
        // Navigate to the login page after successful sign-up
        setState(() {
          isSignUp = false;
        });
      } else {
        await ApiService.logIn(email, password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful!')));
        Navigator.pushReplacementNamed(context, '/tasks');  // Navigate to Task List Screen
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isSignUp ? 'QuickTask - Sign Up' : 'QuickTask - Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text(isSignUp ? 'Sign Up' : 'Login'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignUp = !isSignUp; // Toggle between sign up and login
                });
              },
              child: Text(isSignUp ? 'Already have an account? Login' : 'Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
