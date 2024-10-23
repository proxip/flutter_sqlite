import 'package:quan_ly_benh_nhan_sqlite/data/DatabaseHelper.dart'; // Import your DatabaseHelper class
import 'package:quan_ly_benh_nhan_sqlite/models/User.dart'; // Import your User class
import 'package:quan_ly_benh_nhan_sqlite/screens/home_screen.dart'; // Import your HomeScreen or any screen you want to navigate to after successful login
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quan_ly_benh_nhan_sqlite/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Handle login here
                  String username = usernameController.text;
                  String password = passwordController.text;

                  // Check if username and password are valid
                  if (username.isNotEmpty && password.isNotEmpty) {
                    User? loggedInUser = await loginUser(username, password);

                    if (loggedInUser != null) {
                      // Login successful, navigate to the next screen
                      navigateToHomeScreen();
                    } else {
                      // Login failed, show error message
                      showErrorDialog("Invalid username or password");
                    }
                  } else {
                    showErrorDialog("Please enter both username and password");
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: navigateToSignUpScreen,
                child: Text("Sign up here"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<User?> loginUser(String username, String password) async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    return await dbHelper.loginUser(username, password);
  }

  void navigateToHomeScreen() {
    // Navigate to the screen after successful login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void navigateToSignUpScreen() {
    // Navigate to the sign-up screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  void showErrorDialog(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'), // Added OK button text
            ),
          ],
        );
      },
    );
  }
}
