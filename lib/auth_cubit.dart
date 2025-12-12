import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final String name;
  final String email;

  AuthState({this.name = "Khách", this.email = "Chưa đăng nhập"});
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());
  void login(String email, String password) {
    String displayName = email.contains('@') ? email.split('@')[0] : "User";
    emit(AuthState(email: email, name: displayName));
  }

  void logout() {
    emit(AuthState());
  }
}
