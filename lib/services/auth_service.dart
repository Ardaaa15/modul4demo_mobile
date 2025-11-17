import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // REGISTER
  static Future<AuthResponse> register(String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // LOGIN
  static Future<AuthResponse> login(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // LOGOUT
  static Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // GET CURRENT USER
  static User? get currentUser => _supabase.auth.currentUser;
}
