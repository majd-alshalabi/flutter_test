import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/presentation/screen/searsh_page.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchPage(),
          ),
        );
      },
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.greyWeak, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Search",
                  style: StylesText.newDefaultTextStyle
                      .copyWith(color: theme.greyWeak, fontSize: 18),
                ),
                const Spacer(),
                Icon(
                  Icons.search,
                  color: theme.greyWeak,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
