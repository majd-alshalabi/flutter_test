import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return Container(
      height: 60.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "no data to show",
            style: StylesText.newDefaultTextStyle.copyWith(color: theme.black),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              "try again",
              style:
                  StylesText.newDefaultTextStyle.copyWith(color: theme.primary),
            ),
          )
        ],
      ),
    );
  }
}
