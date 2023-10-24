import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/repos/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({
    required this.repository,
  }) : super(const AsyncValue.data(null));

  final IAuthRepository repository;

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.signOut());
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AccountScreenController(repository: repository);
});
