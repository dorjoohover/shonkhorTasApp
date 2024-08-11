import 'package:app/data/provider/dio.dart';
import 'package:app/shared/constants/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  var storage = GetStorage();

  // @override
  // void onChange(Change<AuthState> change) {
  //   super.onChange(change);
  //   print('AuthBloc - Change - $change');
  // }

  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   super.onTransition(transition);
  //   print('AuthBloc - Transition - $transition');
  // }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final phone = event.phone;
      final password = event.password;
      // Email validation using Regex

      if (password.length < 6) {
        return emit(
          AuthFailure('Password cannot be less than 6 characters!'),
        );
      }
      final data = {"phone": phone, "password": password};
      var client = DioClient();
      await client.dio.post("auth/login", data: data).then((value) {
        var data = value.data;
        if (data['success']) {
          emit(AuthSuccess(
            id: data["id"],
            success: data['success'],
            message: data['message'],
            status: data['status'],
          ));
          storage.write(StorageKeys.token.name, data['id']);
        } else {
          emit(AuthFailure(data['message'] ?? 'Алдаа гарлаа'));
        }
      }).catchError((error) {
        emit(AuthFailure(error.toString()));
      });
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        storage.remove(StorageKeys.token.name);
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
