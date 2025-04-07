import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e__commerce/Features/auth/data/models/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
       await getUserData();
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginError(e.message));
    } catch (e) {
      log(e.toString());
      emit(LoginError(e.toString()));
    }
  }

  Future<void> SignUp(
      {required String UserName,
      required String email,
      required String password}) async {
    emit(SignUpLoading());
    try {
      await client.auth.signUp(password: password, email: email);
      await addUserData(name: UserName, email: email);
       await getUserData();
      emit(SignUpSuccess());
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SignUpError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> LogOut() async {
    emit(LogOutLoading());
    try {
      await client.auth.signOut();
      emit(LogOutSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(LogOutError(e.message));
    } catch (e) {
      log(e.toString());
      emit(LogOutError(e.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(PasswordResetLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(PasswordResetSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(PasswordResetError());
    } catch (e) {
      log(e.toString());
      emit(PasswordResetError());
    }
  }

   Future<void> addUserData(
      {required String name, required String email}) async {
    emit(UserDataAddedLoading());
    try {
      await client.from('users').upsert({
        "user_id": client.auth.currentUser!.id,
        "user_name": name,
        "email": email,
      });
      emit(UserDataAddedSuccess());
    } catch (e) {
      log(e.toString());
      emit(UserDataAddedError());
    }
  }


  UserDataModel? userDataModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      final List<Map<String, dynamic>> data = await client
          .from('users')
          .select()
          .eq("user_id", client.auth.currentUser!.id);
      userDataModel = UserDataModel(
          email: data[0]["email"],
          name: data[0]["user_name"],
          userId: data[0]["user_id"]);
      emit(GetUserDataSuccess());
      print(data);
    } catch (e) {
      log(e.toString());
      emit(GetUserDataError());
    }
  }

   GoogleSignInAccount? googleUser;
  Future<AuthResponse> googleSignIn() async {
    emit(GoogleSignInLoading());
    const webClientId =
        '157842539187-a8cs2c641dr0ou29jhbtvjil6cpvkl7c.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      // clientId: iosClientId,
      serverClientId: webClientId,
    );
    googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return AuthResponse();
    }
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      emit(GoogleSignInError());
      return AuthResponse();
    }

    AuthResponse response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    await addUserData(name: googleUser!.displayName!, email: googleUser!.email);
    await getUserData();

    emit(GoogleSignInSuccess());
    return response;
  }
}
