import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/ui/pages/ar_page/ar_page.dart';
import 'package:sound_classify_app/ui/pages/recording_page/recording_page.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => buildTransitionPage(
          child: const RecordingPage(), //一番最初のページ
        ),
        routes: <RouteBase>[
          GoRoute(
            path: 'home/ar',
            pageBuilder: (context, state) => buildTransitionPage(
              child: const ArPage(),
            ),
          ),
        ],
      ),
    ],
  ),
);

CustomTransitionPage<T> buildTransitionPage<T>({
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    transitionDuration: const Duration(milliseconds: 0),
  );
}
