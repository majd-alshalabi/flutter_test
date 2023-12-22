import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test_flutter/core/constants/enums.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/account/presentation/siginin_page/screen/siginin_page.dart';
import 'package:test_flutter/feature/account/presentation/splash_screen/bloc/splash_screen_bloc/splash_screen_cubit.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/presentation/screen/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) => SplashScreenCubit()..initState(),
      child: Builder(builder: (context) {
        return BlocListener<SplashScreenCubit, SplashScreenState>(
          listener: (context, state) {
            if (state is SplashScreenLoaded) {
              if (state.toWhere == ToWhereShouldINavigateFromSplash.home) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false,
                );
              } else if (state.toWhere ==
                  ToWhereShouldINavigateFromSplash.signInPage) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInPage(),
                  ),
                  (route) => false,
                );
              }
            } else if (state is SplashScreenError) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInPage(),
                ),
                (route) => false,
              );
            }
          },
          child: Scaffold(
            backgroundColor: theme.newColorForAppBar,
            // body: Center(
            //   // child: Image(
            //   //   width: 40.w,
            //   //   image: const AssetImage("assets/images/intro_app.png"),
            //   // ),
            // ),
          ),
        );
      }),
    );
  }
}
