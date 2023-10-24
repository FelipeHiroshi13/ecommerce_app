import 'package:ecommerce_app/src/features/authentication/domain/repos/i_auth_repository.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/app_user.dart';

class FakeRepository implements IAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
      _authState.value = AppUser(
        uid: email.split('').reversed.join(),
        email: email,
      );
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String passsword) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
  }

  void dispose() => _authState.close();

  void _createNewUser(String email) {
    _authState.value = AppUser(
      uid: email.split('').reversed.join(),
      email: email,
    );
  }
}

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final authRepository = FakeRepository();

  ref.onDispose(() => authRepository.dispose());

  return authRepository;
});

final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
