import 'package:flutter/material.dart';

class LoginviaEmailPasswordScreen extends StatefulWidget {
  const LoginviaEmailPasswordScreen({super.key});

  @override
  State<LoginviaEmailPasswordScreen> createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginviaEmailPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _loginFailed = false;

  final String correctEmail = "sarah.jansen@gmail.com";
  final String correctPassword = "12345678";

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text;

      if (email == correctEmail && password == correctPassword) {
        setState(() {
          _loginFailed = false;
        });

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _loginFailed = true;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log into account"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@example',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Enter valid password';
                  }
                  return null;
                },
              ),

              if (_loginFailed)
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Oops! Email or password incorrect. Try another one.",
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // Login Button with Gradient
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 31, 14, 143),Color.fromARGB(255, 75, 4, 88), Colors.pink, Color.fromARGB(255, 255, 51, 0),Color.fromARGB(255, 237, 112, 3)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Forgot password
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/resetPassword');
                },
                child: const Text('Forgot password?'),
              ),

              const Spacer(),

              const Text(
                'By using Classroom, you agree to the\nTerms and Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
