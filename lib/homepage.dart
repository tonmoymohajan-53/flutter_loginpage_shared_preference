import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? savedEmail;
  String? savedPassword;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedEmail = prefs.getString('email') ?? '';
      savedPassword = prefs.getString('password') ?? '';
    });
  }

  Future<void> _saveCredentials() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Show Snackbar if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both Email and Password'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      _loadSavedCredentials();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      appBar: AppBar(
          title: Center(
            child: Text("Log In Page!",style:GoogleFonts.abel(
                color: Colors.black
            ),),
          ),
          backgroundColor: Colors.yellowAccent
      ),
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Lottie.asset("assets/images/animation.json",width: 200,height: 200),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,

                decoration: const InputDecoration(
                  labelText: ' Enter Email',
                  border: OutlineInputBorder(),

                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: ' Enter Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveCredentials();
                },
                child:  Text("Save",style:GoogleFonts.abel(
                    color: Colors.black,
                  backgroundColor: Colors.blue
                ),),

              ),
             const SizedBox(height: 5),
               Text("Output",style:GoogleFonts.abel(
                  color: Colors.black,
                  backgroundColor: Colors.orange
              ),),
              const SizedBox(height: 20),

              if (savedEmail != null && savedPassword != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Saved Email: $savedEmail'),
                    Text('Saved Password: $savedPassword'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
