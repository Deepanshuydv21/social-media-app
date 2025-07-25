import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddEmailState {
  final String email;
  final DateTime? dob;

  AddEmailState({this.email = '', this.dob});

  String get dobFormatted =>
      dob != null ? DateFormat('yyyy-MM-dd').format(dob!) : '';
}

class AddEmailNotifier extends StateNotifier<AddEmailState> {
  AddEmailNotifier() : super(AddEmailState());

  void setEmail(String value) {
    state = AddEmailState(email: value, dob: state.dob);
  }

  void setDOB(DateTime date) {
    state = AddEmailState(email: state.email, dob: date);
  }

  bool get isValid {
    final emailValid = state.email.trim().isNotEmpty;
    final dobValid = state.dob != null;
    final age = calculateAge(state.dob);
    return emailValid && dobValid && age >= 18;
  }

  int calculateAge(DateTime? dob) {
    if (dob == null) return 0;
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }
}

final addEmailProvider =
    StateNotifierProvider<AddEmailNotifier, AddEmailState>(
        (ref) => AddEmailNotifier());
