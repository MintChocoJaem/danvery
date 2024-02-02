import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

final tokenProvider =
    AsyncNotifierProvider.autoDispose<TokenNotifier, TokenModel>(
  () => TokenNotifier(),
);

class TokenNotifier extends AutoDisposeAsyncNotifier<TokenModel> {
  late final AuthRepository _authRepository;

  @override
  FutureOr<TokenModel> build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return future;
  }

  Future<void> login({
    required String studentId,
    required String password,
  }) async {
    final link = ref.keepAlive();

    state = await AsyncValue.guard(
      () async => await _authRepository.login(
        studentId: studentId,
        password: password,
      ),
    );

    if (state.hasError) {
      link.close();
    }
  }
}
