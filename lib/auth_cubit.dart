import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final String name;
  final String email;
  final String? errorMessage;
  final bool isAuthenticated;

  AuthState({
    this.name = "",
    this.email = "",
    this.errorMessage,
    this.isAuthenticated = false,
  });
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  final List<Map<String, String>> _fixedAccounts = [
    {'email': 'klynh@gmail.com', 'pass': '123456', 'name': 'Klynh'},
    {'email': 'Imshuvo97@gmail.com', 'pass': '123456', 'name': 'Afsar Hossen'},
  ];

  void login(String inputEmail, String inputPassword) {
    final account = _fixedAccounts.firstWhere(
      (acc) => acc['email'] == inputEmail && acc['pass'] == inputPassword,
      orElse: () => {},
    );

    if (account.isNotEmpty) {
      emit(
        AuthState(
          email: account['email']!,
          name: account['name']!,
          isAuthenticated: true,
          errorMessage: null,
        ),
      );
    } else {
      emit(
        AuthState(
          name: state.name,
          email: state.email,
          isAuthenticated: false,
          errorMessage: "Email hoặc mật khẩu không chính xác!",
        ),
      );
    }
  }

  void logout() {
    emit(AuthState());
  }
}
