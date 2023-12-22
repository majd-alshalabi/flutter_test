import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_flutter/core/constants/enums.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/global_widget/shimmer_widgets.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/account/presentation/siginin_page/screen/siginin_page.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/domain/use_cases/get_products_use_case.dart';
import 'package:test_flutter/feature/products/presentation/blocs/home_bloc/home_cubit.dart';
import 'package:test_flutter/feature/products/presentation/widgets/home_page_widgets/home_drawer.dart';
import 'package:test_flutter/feature/products/presentation/widgets/home_page_widgets/home_empty_list_widget.dart';
import 'package:test_flutter/feature/products/presentation/widgets/home_page_widgets/home_search_feild.dart';
import 'package:test_flutter/feature/products/presentation/widgets/home_page_widgets/product_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return LoaderOverlay(
      overlayColor: Colors.grey.withOpacity(0.4),
      useDefaultLoading: false,
      overlayWidget: Center(
        child: SpinKitSpinningLines(
          color: theme.white,
          size: 50.0,
        ),
      ),
      child: BlocProvider(
        create: (context) => HomeCubit()..getProducts(),
        child: Builder(builder: (context) {
          return BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is LogOutLoading) {
                context.loaderOverlay.show();
              } else if (state is LogOutLoaded) {
                context.loaderOverlay.hide();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInPage(),
                  ),
                  (route) => false,
                );
              } else if (state is LogOutError) {
                context.loaderOverlay.hide();
              }
            },
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  "home",
                  style: StylesText.newTextStyleForAppBar
                      .copyWith(color: Colors.white),
                ),
                backgroundColor: theme.newColorForAppBar,
              ),
              drawer: const HomeDrawer(),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: RefreshIndicator(
                  color: theme.primary,
                  onRefresh: () async {
                    final result = await GetProductsUseCase().call(NoParams());
                    result.fold(
                      (l) => context.read<HomeCubit>().updateList([]),
                      (r) => context.read<HomeCubit>().updateList(r.data ?? []),
                    );
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: const HomeSearchField(),
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        buildWhen: (previous, current) {
                          if (current is GetProductsLoading) {
                            return true;
                          } else if (current is GetProductsLoaded) {
                            return true;
                          } else if (current is GetProductsError) {
                            return true;
                          }
                          return false;
                        },
                        bloc: context.read<HomeCubit>(),
                        builder: (context, state) {
                          if (state is GetProductsLoading) {
                            return const HomeLoadingWidget();
                          } else if (context
                              .read<HomeCubit>()
                              .products
                              .isEmpty) {
                            return EmptyListWidget(
                              onTap: () {
                                context.read<HomeCubit>().getProducts();
                              },
                            );
                          } else {
                            return ScrollablePositionedList.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              minCacheExtent: 99999999,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return BlocBuilder<HomeCubit, HomeState>(
                                  buildWhen: (previous, current) {
                                    if (current is UpdateCommentCountLoaded) {
                                      return true;
                                    }
                                    return false;
                                  },
                                  builder: (context, state) {
                                    return ProductsListItem(
                                      fromWhere: FromWhereForProductItem.home,
                                      product: context
                                          .read<HomeCubit>()
                                          .products[index],
                                    );
                                  },
                                );
                              },
                              itemCount:
                                  context.read<HomeCubit>().products.length,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
