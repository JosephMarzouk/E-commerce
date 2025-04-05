import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  SupabaseClient client = Supabase.instance.client;
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
       await client.auth.signInWithPassword(password: password, email: email);
      
      
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginError(e.message));
    } catch (e) {
      log(e.toString());
      emit(LoginError(e.toString()));
    }
  }

  Future<void> SignUp({required String UserName, required String email, required String password}) async {
    emit(SignUpLoading());
    try {
       await client.auth.signInWithPassword(password: password, email: email);
      
      
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SignUpError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SignUpError(e.toString()));
    }
  }
}
