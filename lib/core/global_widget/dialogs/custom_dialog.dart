import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class CustomDialog extends StatelessWidget {
  //  secound text will be display in dialog (text icon image ..)
  final Widget bodyWidget;

  //  icon will display above dialog
  final Widget? iconWidget;
  final double? heightDialog;
  final double? distanceBetweenTopScreenAndIcons;

  const CustomDialog({
    super.key,
    required this.bodyWidget,
    this.heightDialog,
    this.iconWidget,
    this.distanceBetweenTopScreenAndIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 80.w,
            height: heightDialog ?? 40.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color:
                  context.read<ThemeCubit>().globalAppTheme.darkThemeForScafold,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: iconWidget != null ? 5.h : 2.h,
                ),
                SizedBox(width: 100.w, child: bodyWidget),
              ],
            ),
          ),
        ),
        Positioned(
          left: 22.w,
          top: distanceBetweenTopScreenAndIcons ?? 0.0,
          child: iconWidget == null
              ? const SizedBox.shrink()
              : SizedBox(
                  width: 50.w,
                  child: iconWidget,
                ),
        ),
      ],
    );
  }
}
