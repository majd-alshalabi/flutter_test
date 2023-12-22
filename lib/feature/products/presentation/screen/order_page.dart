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
import 'package:test_flutter/core/utils/utils.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/domain/use_cases/get_orders_use_case.dart';
import 'package:test_flutter/feature/products/presentation/blocs/order_cubit/orders_cubit.dart';
import 'package:test_flutter/feature/products/presentation/widgets/home_page_widgets/home_empty_list_widget.dart';
import 'package:test_flutter/feature/products/presentation/widgets/home_page_widgets/product_list_item.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

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
        create: (context) => OrdersCubit()..getOrder(),
        child: Builder(builder: (context) {
          return BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is DeleteOrderError) {
                context.loaderOverlay.hide();
                Utils.showCustomToast(state.error);
              } else if (state is DeleteOrderLoading) {
                context.loaderOverlay.show();
              } else if (state is DeleteOrderLoaded) {
                context.loaderOverlay.hide();
                Utils.showCustomToast("delete order done");
              }
            },
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  "orders",
                  style: StylesText.newTextStyleForAppBar
                      .copyWith(color: Colors.white),
                ),
                backgroundColor: theme.newColorForAppBar,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: RefreshIndicator(
                  color: theme.primary,
                  onRefresh: () async {
                    final result = await GetOrdersUseCase().call(NoParams());
                    result.fold(
                      (l) => context.read<OrdersCubit>().updateList([]),
                      (r) =>
                          context.read<OrdersCubit>().updateList(r.data ?? []),
                    );
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      BlocBuilder<OrdersCubit, OrdersState>(
                        buildWhen: (previous, current) {
                          if (current is GetAllOrderLoading) {
                            return true;
                          } else if (current is GetAllOrderLoaded) {
                            return true;
                          } else if (current is GetAllOrderError) {
                            return true;
                          } else if (current is DeleteOrderLoaded) {
                            return true;
                          }
                          return false;
                        },
                        bloc: context.read<OrdersCubit>(),
                        builder: (context, state) {
                          if (state is GetAllOrderLoading) {
                            return const HomeLoadingWidget();
                          } else if (context
                              .read<OrdersCubit>()
                              .orders
                              .isEmpty) {
                            return EmptyListWidget(
                              onTap: () {
                                context.read<OrdersCubit>().getOrder();
                              },
                            );
                          } else {
                            return ScrollablePositionedList.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              minCacheExtent: 99999999,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                if (context
                                        .read<OrdersCubit>()
                                        .orders[index]
                                        .product !=
                                    null) {
                                  return ProductsListItem(
                                    fromWhere: FromWhereForProductItem.order,
                                    product: context
                                        .read<OrdersCubit>()
                                        .orders[index]
                                        .product!,
                                    order: context
                                        .read<OrdersCubit>()
                                        .orders[index],
                                  );
                                }
                                return const Offstage();
                              },
                              itemCount:
                                  context.read<OrdersCubit>().orders.length,
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
