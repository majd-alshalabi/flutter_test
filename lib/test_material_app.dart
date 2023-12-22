import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/core/constants/app_constant.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';
import 'package:test_flutter/feature/account/presentation/splash_screen/screen/splash_screen.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class TestMaterialApp extends StatelessWidget {
  const TestMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return BlocProvider(
          create: (context) => ThemeCubit()..getCurrentTheme(),
          child: Builder(builder: (context) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                if (state is ThemeLoadedState) {
                  return MaterialApp(
                    navigatorKey: AppSettings().navigatorKey,
                    debugShowCheckedModeBanner: false,
                    title: AppConstant.appName,
                    theme: state.theme,
                    home: const SplashScreen(),
                  );
                }
                return const Offstage();
              },
            );
          }),
        );
      },
    );
  }
}
