import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_email_provider.dart';

class AddEmailScreen extends ConsumerWidget {
  const AddEmailScreen({super.key});

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      ref.read(addEmailProvider.notifier).setDOB(picked);
    }
  }

  void _submit(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(addEmailProvider.notifier);
    if (!notifier.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid email and DOB (18+ required)")),
      );
      return;
    }
    Navigator.pushNamed(context, '/verifyOtp');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addEmailProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add your email 1 / 3',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            const Text('Email', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              onChanged: (val) =>
                  ref.read(addEmailProvider.notifier).setEmail(val),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'sarah.jansen@gmail.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Date of Birth', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: state.dobFormatted),
              readOnly: true,
              onTap: () => _selectDate(context, ref),
              decoration: InputDecoration(
                hintText: 'YYYY-MM-DD',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 31, 14, 143),
                    Color.fromARGB(255, 75, 4, 88),
                    Colors.pink,
                    Color.fromARGB(255, 255, 51, 0),
                    Color.fromARGB(255, 237, 112, 3),
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () => _submit(context, ref),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create an account',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
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
    );
  }
}
