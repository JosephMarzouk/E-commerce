import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e__commerce/Features/auth/data/models/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:e__commerce/core/demo_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  SupabaseClient client = Supabase.instance.client;

  void seedDemoGuest() {
    userDataModel = kDemoGuest;
    emit(GetUserDataSuccess());
  }
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await client.auth.signInWithPassword(
        password: password,
        email: email.trim(),
      );
      await _loadOrCreateUserProfile();
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginError(e.message));
    } catch (e) {
      log(e.toString());
      emit(LoginError(
        'Could not load your profile. If you created this account in Supabase, '
        'make sure a row exists in the users table or try signing up from the app.',
      ));
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
    if (kDemoMode) return;
    emit(LogOutLoading());
    try {
      await client.auth.signOut();
      userDataModel = null;
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

  Future<void> _loadOrCreateUserProfile() async {
    final authUser = client.auth.currentUser;
    if (authUser == null) {
      throw const AuthException('Not signed in');
    }

    var data = await client
        .from('users')
        .select()
        .eq('user_id', authUser.id);

    if (data.isEmpty) {
      final name = authUser.userMetadata?['user_name'] as String? ??
          authUser.userMetadata?['name'] as String? ??
          authUser.email?.split('@').first ??
          'User';
      final email = authUser.email ?? '';
      await client.from('users').upsert({
        'user_id': authUser.id,
        'user_name': name,
        'email': email,
      });
      data = await client
          .from('users')
          .select()
          .eq('user_id', authUser.id);
    }

    if (data.isEmpty) {
      throw Exception('users table row missing');
    }

    userDataModel = UserDataModel(
      email: data[0]['email'] as String,
      name: data[0]['user_name'] as String,
      userId: data[0]['user_id'] as String,
    );
  }

  Future<void> restoreSession() async {
    if (client.auth.currentUser == null) {
      userDataModel = null;
      emit(AuthInitial());
      return;
    }
    emit(GetUserDataLoading());
    try {
      await _loadOrCreateUserProfile();
      emit(GetUserDataSuccess());
    } catch (e) {
      log(e.toString());
      await client.auth.signOut();
      userDataModel = null;
      emit(AuthInitial());
    }
  }

  Future<void> getUserData() async {
    if (client.auth.currentUser == null) {
      userDataModel = null;
      emit(AuthInitial());
      return;
    }
    emit(GetUserDataLoading());
    try {
      await _loadOrCreateUserProfile();
      emit(GetUserDataSuccess());
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
