import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/core/constants/app_constant.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/global_widget/global_widget.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/core/utils/utils.dart';
import 'package:test_flutter/feature/account/data/models/remote/login_model.dart';
import 'package:test_flutter/feature/account/presentation/register_page/screen/register_page.dart';
import 'package:test_flutter/feature/account/presentation/siginin_page/blocs/siginin_cubit.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/presentation/screen/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Builder(builder: (context) {
        return LoaderOverlay(
          overlayColor: Colors.grey.withOpacity(0.4),
          useDefaultLoading: false,
          overlayWidget: Center(
            child: SpinKitSpinningLines(
              color: theme.reserveDarkScaffold,
              size: 50.0,
            ),
          ),
          child: BlocListener(
              bloc: context.read<SignInCubit>(),
              listener: (context, state) {
                switch (state.runtimeType) {
                  case LoginLoading:
                    context.loaderOverlay.show();
                    break;
                  case LoginLoaded:
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false,
                    );
                    context.loaderOverlay.hide();
                    break;
                  case LoginError:
                    state as LoginError;
                    Utils.showCustomToast(state.error);
                    context.loaderOverlay.hide();
                    break;
                }
              },
              child: Scaffold(
                backgroundColor: const Color(0xff2A2D3E),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Container(
                      constraints: BoxConstraints(minHeight: 95.h),
                      alignment: Alignment.center,
                      child: Form(
                        key: formKey,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .7,
                          decoration: BoxDecoration(
                            color: theme.newColorForAppBar,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign In",
                                  style: StylesText.newDefaultTextStyle
                                      .copyWith(
                                          color: Colors.white, fontSize: 23),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                CustomTextField(
                                    textColor: Colors.white,
                                    type: TextInputType.text,
                                    prefix: const Icon(
                                      FontAwesomeIcons.person,
                                      size: 20,
                                    ),
                                    controllerName: emailController,
                                    label: "email",
                                    validate: (String val) {
                                      if (!AppConstant.emailRegex
                                          .hasMatch(val)) {
                                        return "enter valid email";
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                CustomTextField(
                                  textColor: Colors.white,
                                  type: TextInputType.visiblePassword,
                                  prefix: const Icon(
                                    FontAwesomeIcons.userSecret,
                                    size: 20,
                                  ),
                                  suffix: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: theme.greyWeak,
                                  ),
                                  controllerName: passwordController,
                                  label: "password",
                                  validate: (String val) {
                                    if (val.length < 8) {
                                      return "password length must be at least 8 character";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomButton(
                                  text: "Sign In",
                                  height: 60,
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<SignInCubit>()
                                          .login(LoginParamsModel(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ));
                                    }
                                  },
                                  borderColor: theme.greyWeak,
                                  textStyleForButton: StylesText
                                      .newDefaultTextStyle
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "if you dont have an account?",
                                        style: StylesText.newDefaultTextStyle
                                            .copyWith(color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "sign up",
                                          style: StylesText.newDefaultTextStyle
                                              .copyWith(color: theme.primary),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        );
      }),
    );
  }
}
