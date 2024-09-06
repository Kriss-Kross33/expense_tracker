import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/common/blocs/expense_cubit/expense_cubit.dart';
import 'package:expense_track/src/common/common.dart';
import 'package:expense_track/src/core/core.dart';
import 'package:expense_track/src/features/dashboard/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => ExpenseApiCubit(
            expenseApiRepository: context.read<ExpenseApiRepository>(),
          ),
        ),
        BlocProvider(create: (context) => CategoryCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            // builder: FToastBuilder(),
            theme: state.themeMode == AppThemeMode.darkMode
                ? AppTheme.dark
                : AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode == AppThemeMode.darkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
          );
        },
      ),
    );
  }
}
