import 'dart:async';

import 'package:danvery/src/core/services/router/router_service.dart';
import 'package:danvery/src/features/auth/domain/use_cases/send_sign_up_code_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../design_system/orb/components/components.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/models/sign_up_info_model.dart';
import '../../../domain/use_cases/verify_student_use_case.dart';
import 'agree_privacy_policy_view_model.dart';

final signUpViewModelProvider =
    AsyncNotifierProvider.autoDispose<SignUpViewModel, SignUpInfoModel>(
  () => SignUpViewModel(),
);

class SignUpViewModel extends AutoDisposeAsyncNotifier<SignUpInfoModel> {
  KeepAliveLink? _link;

  late final VerifyStudentUseCase _verifyStudentUseCase;
  late final SendSignUpCodeUseCase _sendSmsCodeUseCase;

  @override
  FutureOr<SignUpInfoModel> build() {
    // TODO: implement build
    final authRepository = ref.watch(authRepositoryImplProvider);
    _verifyStudentUseCase = VerifyStudentUseCase(
      authRepository: authRepository,
    );
    _sendSmsCodeUseCase = SendSignUpCodeUseCase(
      authRepository: authRepository,
    );
    return future;
  }

  Future<void> verifyStudent(
    GlobalKey<FormState> formKey, {
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _link = ref.keepAlive();

    final agreePolicy = ref.read(agreePrivacyPolicyViewModelProvider);

    if (!agreePolicy) {
      OrbSnackBar.show(
        type: OrbSnackBarType.warning,
        message: '개인정보 이용약관에 동의가 필요해요',
      );
      return;
    }

    state = await _verifyStudentUseCase(
      params: VerifyStudentParams(
        dkuStudentId: dkuStudentId,
        dkuPassword: dkuPassword,
      ),
    );

    if (state.hasValue) {
      await ref
          .read(routerServiceProvider)
          .replace(const VerifyPhoneNumberRoute());
    }

    _link?.close();
  }

  Future<void> sendSMS(
    GlobalKey<FormState> formKey, {
    required String phoneNumber,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if(!state.hasValue){
      return;
    }

    await _sendSmsCodeUseCase(
      params: SendSignUpCodeParams(
        signUpToken: state.requireValue.signUpToken,
        phoneNumber: phoneNumber,
      ),
    );
  }

  void pushToAgreePolicyScreen() {
    ref.read(routerServiceProvider).push(const AgreePolicyRoute());
  }
}
