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
import 'package:test_flutter/feature/account/data/models/remote/register_model.dart';
import 'package:test_flutter/feature/account/presentation/register_page/bloc/register_cubit.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/presentation/screen/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    nameController.dispose();
    cPasswordController.dispose();
    super.dispose();
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Builder(builder: (context) {
        return LoaderOverlay(
          overlayColor: Colors.grey.withOpacity(0.4),
          useDefaultLoading: false,
          overlayWidget: const Center(
            child: SpinKitSpinningLines(
              color: Colors.white,
              size: 50.0,
            ),
          ),
          child: BlocListener(
            bloc: context.read<RegisterCubit>(),
            listener: (context, state) {
              if (state is RegisterError) {
                context.loaderOverlay.hide();
                Utils.showCustomToast(state.message);
              } else if (state is RegisterLoading) {
                context.loaderOverlay.show();
              } else if (state is RegisterLoaded) {
                context.loaderOverlay.hide();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false,
                );
              }
            },
            child: Scaffold(
              backgroundColor: const Color(0xff2A2D3E),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(minHeight: 95.h),
                    alignment: Alignment.center,
                    child: Form(
                      key: formKey,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .6,
                        decoration: BoxDecoration(
                          color: theme.newColorForAppBar,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "sign up",
                                style: StylesText.newDefaultTextStyle.copyWith(
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
                                  controllerName: nameController,
                                  label: "name",
                                  validate: (String val) {
                                    if (val.length < 3) {
                                      return "name must be not Empty";
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 15.0,
                              ),
                              CustomTextField(
                                  textColor: Colors.white,
                                  type: TextInputType.emailAddress,
                                  prefix: const Icon(
                                    Icons.email_rounded,
                                    size: 20,
                                  ),
                                  controllerName: emailController,
                                  label: "email",
                                  validate: (String val) {
                                    if (!AppConstant.emailRegex.hasMatch(val)) {
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
                                controllerName: passwordController,
                                label: "password",
                                suffix: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: theme.black,
                                ),
                                validate: (String val) {
                                  if (val.length < 8) {
                                    return "password length must be at least 8 character";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                  textColor: Colors.white,
                                  type: TextInputType.visiblePassword,
                                  prefix: const Icon(
                                    FontAwesomeIcons.userSecret,
                                    size: 20,
                                  ),
                                  suffix: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: theme.black,
                                  ),
                                  controllerName: cPasswordController,
                                  label: "confirm password",
                                  validate: (String val) {
                                    if (val.length < 8) {
                                      return "confirm password must be of length 8 at least";
                                    }
                                    if (val != passwordController.text) {
                                      return "password confirmation must be equal to password";
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 20.0,
                              ),
                              CustomButton(
                                text: "sign up",
                                height: 60,
                                onPress: () async {
                                  if (formKey.currentState!.validate()) {
                                    context.read<RegisterCubit>().register(
                                          RegisterParamsModel(
                                            name: nameController.text,
                                            cPassword: cPasswordController.text,
                                            password: passwordController.text,
                                            email: emailController.text,
                                          ),
                                        );

                                    FocusScope.of(context).unfocus();
                                  }
                                },
                                borderColor: theme.greyWeak,
                                textStyleForButton:
                                    StylesText.newDefaultTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
