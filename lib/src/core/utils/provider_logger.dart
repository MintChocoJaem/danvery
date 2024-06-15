import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/app_exception.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    debugPrint(
        'Provider > ${provider.runtimeType} was initialized with $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    debugPrint('Provider > ${provider.runtimeType} was disposed');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint(
        'Provider > ${provider.runtimeType} updated from $previousValue to $newValue');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (error is! AppException) {
      debugPrint(
          'Provider > ${provider.runtimeType} threw $error at $stackTrace');
    }
  }
}
