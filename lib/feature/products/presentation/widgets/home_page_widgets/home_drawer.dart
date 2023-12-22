import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/presentation/blocs/home_bloc/home_cubit.dart';
import 'package:test_flutter/feature/products/presentation/screen/order_page.dart';
import 'package:test_flutter/feature/products/presentation/widgets/home_page_widgets/product_list_item.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;

    return Drawer(
      elevation: 0,
      width: 50.w,
      backgroundColor: theme.darkThemeForScafold,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 3.h, bottom: 1.h),
            color: theme.newColorForAppBar,
            child: ListTile(
              leading: TestUserAvatar(
                width: 7.w,
              ),
              title: Text(
                AppSettings().identity?.name ?? "Sign In",
                style: StylesText.newDefaultTextStyle.copyWith(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.firstOrder,
                color: theme.reserveDarkScaffold),
            title: Text(
              "orders",
              style: StylesText.newDefaultTextStyle
                  .copyWith(color: theme.reserveDarkScaffold),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.houseUser,
                color: theme.reserveDarkScaffold),
            title: Text(
              "logout",
              style: StylesText.newDefaultTextStyle
                  .copyWith(color: theme.reserveDarkScaffold),
            ),
            onTap: () {
              Navigator.pop(context);
              context.read<HomeCubit>().logOut();
            },
          ),
        ],
      ),
    );
  }
}
