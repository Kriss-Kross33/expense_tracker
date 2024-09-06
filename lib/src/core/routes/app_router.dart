import 'package:expense_track/src/core/constants/route_consts.dart';
import 'package:expense_track/src/features/features.dart';
import 'package:expense_track/src/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      //* Splash
      GoRoute(
        path: RouteConsts.splashRoute,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SplashScreen(),
          );
        },
      ),
      //* Login
      GoRoute(
        path: RouteConsts.loginRoute,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteConsts.signupRoute,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SignupScreen(),
          );
        },
      ),
      //* Home
      GoRoute(
        path: RouteConsts.homeRoute,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HomePage(),
          );
        },
      ),
    ],
  );
}
