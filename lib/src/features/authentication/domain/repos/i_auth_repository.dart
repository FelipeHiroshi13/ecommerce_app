import '../app_user.dart';

abstract class IAuthRepository {
  Stream<AppUser?> authStateChanges();

  AppUser? get currentUser;

  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserWithEmailAndPassword(String email, String passsword);

  Future<void> signOut();
}
