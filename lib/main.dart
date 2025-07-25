import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Screens
import 'login/launch_screen.dart';
import 'login/create_new_account_screen.dart';
import 'login/add_email_screen.dart';
import 'login/verify_otp_screen.dart';
import 'login/create_password_screen.dart';
import 'login/account_created_screen.dart';
import 'login/login_via_continue_email_screen.dart';
import 'login/login_via_email_password_screen.dart';
import 'login/reset_password_screen.dart';
import 'login/password_reset_confirmation_screen.dart';
import 'home_screen.dart';

void main() {
  // Wraping the app
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LaunchScreen(),
        '/createAccount': (context) => const CreateNewAccountScreen(),
        '/addEmail': (context) => const AddEmailScreen(),
        '/verifyOtp': (context) => const VerifyOtpScreen(),
        '/createPassword': (context) => const CreatePasswordScreen(),
        '/accountCreated': (context) => const AccountCreatedScreen(),
        '/loginViaContinueEmail': (context) => const LoginViaContinueEmailScreen(),
        '/loginViaEmailPassword': (context) => const LoginviaEmailPasswordScreen(),
        '/resetPassword': (context) => const ResetPasswordScreen(),
        '/resetSuccessful': (context) => const PasswordResetConfirmationScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
