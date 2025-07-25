import 'package:flutter/material.dart';
import 'dart:async';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  bool isSuccess = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    final email = emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email.')),
        );
      }
      return;
    }

    setState(() {
      isLoading = true;
      isSuccess = false;
    });

    // Simulate sending link
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        isSuccess = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          '/resetSuccessful',
          arguments: email,
        );
      });
    });
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isSuccess) {
      return const Center(
        child: Icon(Icons.check_circle, color: Colors.green, size: 80),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 40),
        const Text(
          'We will email you a link to reset your password.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 30),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'example@example.com',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: _sendResetLink,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 31, 14, 143),
                  Color.fromARGB(255, 75, 4, 88),
                  Colors.pink,
                  Color.fromARGB(255, 255, 51, 0),
                  Color.fromARGB(255, 237, 112, 3),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 60),
        const Text(
          'By using Classroom, you agree to the\nTerms and Privacy Policy.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _buildContent(),
      ),
    );
  }
}
