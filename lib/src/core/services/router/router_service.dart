import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/board/presentation/screens/bear_eats_board_screen.dart';
import '../../../features/board/presentation/screens/coalition_board_screen.dart';
import '../../../features/board/presentation/screens/coalition_post_screen.dart';
import '../../../features/board/presentation/screens/eating_alone_board_screen.dart';
import '../../../features/board/presentation/screens/eating_alone_post_screen.dart';
import '../../../features/board/presentation/screens/notice_board_screen.dart';
import '../../../features/board/presentation/screens/notice_post_screen.dart';
import '../../../features/board/presentation/screens/petition_board_screen.dart';
import '../../../features/board/presentation/screens/petition_post_screen.dart';
import '../../../features/board/presentation/screens/search_board_screen.dart';
import '../../../features/board/presentation/screens/study_board_screen.dart';
import '../../../features/board/presentation/screens/trade_board_screen.dart';
import '../../../features/board/presentation/screens/with_dankook_screen.dart';
import '../../../features/board/presentation/screens/write_eating_alone_screen.dart';
import '../../../features/board/presentation/screens/write_petition_screen.dart';
import '../../../features/dash_board/presentation/screens/home_screen.dart';
import '../../../features/timetable/presentation/screens/add_schedule_screen.dart';
import '../../../features/timetable/presentation/screens/schedule_detail_screen.dart';
import '../../../features/timetable/presentation/screens/add_lecture_screen.dart';
import '../../../features/timetable/presentation/screens/timetable_screen.dart';
import '../../../features/user/presentation/view_models/login_view_model.dart';
import '../../../features/user/presentation/screens/find_user_id_screen.dart';
import '../../../features/user/presentation/screens/find_user_password_screen.dart';
import '../../../features/user/presentation/screens/login_screen.dart';
import '../../../features/board/presentation/screens/board_screen.dart';

import '../../../features/user/presentation/screens/profile_screen.dart';
import '../../../features/user/presentation/screens/refresh_verify_student_screen.dart';
import '../../../features/user/presentation/screens/sign_up_agree_policy_screen.dart';
import '../../../features/user/presentation/screens/sign_up_complete_screen.dart';
import '../../../features/user/presentation/screens/sign_up_screen.dart';
import '../../../features/user/presentation/screens/sign_up_verify_student_screen.dart';
import 'main_screen.dart';
import 'route_error_screen.dart';

enum AppRoute {
  noInternet,
  login,
  findUserId,
  findPassword,
  signUpVerifyStudent,
  signUpAgreePolicy,
  signUp,
  signUpComplete,
  refreshVerifyStudent,
  home,
  noticeBoard,
  coalitionBoard,
  petitionBoard,
  timetable,
  profile,
  noticePost,
  coalitionPost,
  petitionPost,
  writePetition,
  searchBoard,
  addLecture,
  addSchedule,
  scheduleDetail,
  withDankook,
  eatingAloneBoard,
  eatingAlonePost,
  writeEatingAlone,
  studyBoard,
  tradeBoard,
  bearEatsBoard,
}

final routerServiceProvider = Provider<RouterService>(
  (ref) {
    final GlobalKey<NavigatorState> rootNavigatorKey =
        GlobalKey<NavigatorState>();
    final loginNotifier = ValueNotifier(ref.read(loginViewModelProvider).value);
    ref.listen(
      loginViewModelProvider,
      (_, next) {
        loginNotifier.value = next.value;
      },
    );
    ref.onDispose(() {
      loginNotifier.dispose();
    });
    return RouterService(
      navigator: GoRouter(
        initialLocation: '/home',
        navigatorKey: rootNavigatorKey,
        debugLogDiagnostics: true,
        refreshListenable: loginNotifier,
        redirect: (context, state) async {
          final loginToken = ref.read(loginViewModelProvider).value;
          if (loginToken == null &&
              !(state.uri.path.contains('login') ||
                  state.uri.path.contains('sign_up'))) {
            return '/login';
          }
          return null;
        },
        errorBuilder: (context, state) {
          return const RouteErrorScreen();
        },
        routes: [
          GoRoute(
            path: '/login',
            name: AppRoute.login.name,
            builder: (context, state) {
              return const LoginScreen();
            },
            routes: [
              GoRoute(
                path: 'refresh/verify/student',
                name: AppRoute.refreshVerifyStudent.name,
                builder: (context, state) {
                  return const RefreshVerifyStudentScreen();
                },
              ),
              GoRoute(
                path: 'find/id',
                name: AppRoute.findUserId.name,
                builder: (context, state) {
                  return const FindUserIdScreen();
                },
              ),
              GoRoute(
                path: 'find/password',
                name: AppRoute.findPassword.name,
                builder: (context, state) {
                  return const FindUserPasswordScreen();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/sign_up',
            name: AppRoute.signUp.name,
            builder: (context, state) {
              return const SignUpScreen();
            },
            routes: [
              GoRoute(
                path: 'verify_student',
                name: AppRoute.signUpVerifyStudent.name,
                builder: (context, state) {
                  return const SignUpVerifyStudentScreen();
                },
              ),
              GoRoute(
                path: 'agree_policy',
                name: AppRoute.signUpAgreePolicy.name,
                builder: (context, state) {
                  return const SignUpAgreePolicyScreen();
                },
              ),
              GoRoute(
                path: 'complete',
                name: AppRoute.signUpComplete.name,
                builder: (context, state) {
                  return SignUpCompleteScreen(
                    userPassword: state.extra as String,
                  );
                },
              ),
            ],
          ),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return MainScreen(
                navigationShell: navigationShell,
              );
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/home',
                    name: AppRoute.home.name,
                    builder: (context, state) => const HomeScreen(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  StatefulShellRoute.indexedStack(
                    builder: (context, state, navigationShell) {
                      return BoardScreen(
                        navigationShell: navigationShell,
                      );
                    },
                    branches: [
                      StatefulShellBranch(
                        routes: [
                          GoRoute(
                            path: '/board/notice',
                            name: AppRoute.noticeBoard.name,
                            builder: (context, state) =>
                                const NoticeBoardScreen(),
                            routes: [
                              GoRoute(
                                path: 'post:id',
                                name: AppRoute.noticePost.name,
                                parentNavigatorKey: rootNavigatorKey,
                                builder: (context, state) {
                                  final id = state.pathParameters['id']!;
                                  return NoticePostScreen(
                                    id: int.parse(id),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        routes: [
                          GoRoute(
                            path: '/board/coalition',
                            name: AppRoute.coalitionBoard.name,
                            builder: (context, state) =>
                                const CoalitionBoardScreen(),
                            routes: [
                              GoRoute(
                                path: 'post:id',
                                name: AppRoute.coalitionPost.name,
                                parentNavigatorKey: rootNavigatorKey,
                                builder: (context, state) {
                                  final id = state.pathParameters['id']!;
                                  return CoalitionPostScreen(
                                    id: int.parse(id),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        routes: [
                          GoRoute(
                            path: '/board/petition',
                            name: AppRoute.petitionBoard.name,
                            builder: (context, state) =>
                                const PetitionBoardScreen(),
                            routes: [
                              GoRoute(
                                path: 'post:id',
                                name: AppRoute.petitionPost.name,
                                parentNavigatorKey: rootNavigatorKey,
                                builder: (context, state) {
                                  final id = state.pathParameters['id']!;
                                  return PetitionPostScreen(
                                    id: int.parse(id),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  StatefulShellRoute.indexedStack(
                    builder: (context, state, navigationShell) {
                      return WithDankookScreen(
                        navigationShell: navigationShell,
                      );
                    },
                    branches: [
                      StatefulShellBranch(
                        routes: [
                          GoRoute(
                            path: '/with_dankook/eating_alone',
                            name: AppRoute.eatingAloneBoard.name,
                            builder: (context, state) =>
                                const EatingAloneBoardScreen(),
                            routes: [
                              GoRoute(
                                path: 'post:id',
                                name: AppRoute.eatingAlonePost.name,
                                parentNavigatorKey: rootNavigatorKey,
                                builder: (context, state) {
                                  final id = state.pathParameters['id']!;
                                  return EatingAlonePostScreen(
                                    id: int.parse(id),
                                  );
                                },
                              ),
                              GoRoute(
                                path: 'write',
                                name: AppRoute.writeEatingAlone.name,
                                parentNavigatorKey: rootNavigatorKey,
                                builder: (context, state) {
                                  return const WriteEatingAloneScreen();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        routes: [
                          GoRoute(
                            path: '/with_dankook/study',
                            name: AppRoute.studyBoard.name,
                            builder: (context, state) =>
                                const StudyBoardScreen(),
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        routes: [
                          GoRoute(
                            path: '/with_dankook/trade',
                            name: AppRoute.tradeBoard.name,
                            builder: (context, state) =>
                                const TradeBoardScreen(),
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        routes: [
                          GoRoute(
                            path: '/with_dankook/bear_eats',
                            name: AppRoute.bearEatsBoard.name,
                            builder: (context, state) =>
                                const BearEatsBoardScreen(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/timetable',
                    name: AppRoute.timetable.name,
                    builder: (context, state) => const TimetableScreen(),
                    routes: [
                      GoRoute(
                        path: 'add/lecture',
                        name: AppRoute.addLecture.name,
                        builder: (context, state) {
                          return const AddLectureScreen();
                        },
                      ),
                      GoRoute(
                        path: 'add/schedule',
                        name: AppRoute.addSchedule.name,
                        builder: (context, state) {
                          return const AddScheduleScreen();
                        },
                      ),
                      GoRoute(
                        path: 'schedule/:id',
                        name: AppRoute.scheduleDetail.name,
                        builder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return ScheduleDetailScreen(
                            id: int.parse(id),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/profile',
                    name: AppRoute.profile.name,
                    builder: (context, state) {
                      return const ProfileScreen();
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/board/search',
            name: AppRoute.searchBoard.name,
            builder: (context, state) {
              return const SearchBoardScreen();
            },
          ),
          GoRoute(
            path: '/board/write',
            name: AppRoute.writePetition.name,
            builder: (context, state) {
              return const WritePetitionScreen();
            },
          ),
        ],
      ),
    );
  },
);

class RouterService {
  final GoRouter navigator;

  RouterService({
    required this.navigator,
  });

  Future<Object?> pushNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) async {
    await _hideKeyboard();
    return await navigator.pushNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  Future<Object?> pushReplacementNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) async {
    await _hideKeyboard();
    return await navigator.pushReplacementNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  Future<void> goNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) async {
    await _hideKeyboard();
    return navigator.goNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  Future<void> pop<T extends Object?>([T? result]) async {
    await _hideKeyboard();
    return navigator.pop(result);
  }

  Future<void> _hideKeyboard() async {
    final context = navigator.routerDelegate.navigatorKey.currentContext;
    if (context == null) return;

    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    if (keyboardVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 200), () {});
    }
  }
}
