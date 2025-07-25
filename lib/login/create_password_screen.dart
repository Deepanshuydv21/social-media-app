import 'package:flutter/material.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;

  // Password validation flags
  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasSymbol = false;

  void _checkPasswordStrength(String password) {
    setState(() {
      hasMinLength = password.length >= 8;
      hasNumber = RegExp(r'\d').hasMatch(password);
      hasSymbol = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    });
  }

  double _getStrengthPercent() {
    int passed = [hasMinLength, hasNumber, hasSymbol].where((c) => c).length;
    return passed / 3;
  }

  void _submit() {
    if (_formKey.currentState!.validate() &&
        hasMinLength &&
        hasNumber &&
        hasSymbol) {
      Navigator.pushNamed(context, '/accountCreated');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please meet all password criteria")),
      );
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Widget _buildCheck(String text, bool condition) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.radio_button_unchecked,
          color: condition ? Colors.green : Colors.grey,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create your password 3 / 3"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                onChanged: _checkPasswordStrength,
                decoration: InputDecoration(
                  labelText: 'Password',
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
              ),
              const SizedBox(height: 16),

              // Progress Bar
              LinearProgressIndicator(
                value: _getStrengthPercent(),
                color: Colors.green,
                backgroundColor: Colors.grey[300],
                minHeight: 4,
              ),
              const SizedBox(height: 16),

              // Checklist
              _buildCheck("8 characters minimum", hasMinLength),
              const SizedBox(height: 6),
              _buildCheck("a number", hasNumber),
              const SizedBox(height: 6),
              _buildCheck("one symbol minimum", hasSymbol),
              const SizedBox(height: 30),

              // Continue Button
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
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
                      "Continue",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
