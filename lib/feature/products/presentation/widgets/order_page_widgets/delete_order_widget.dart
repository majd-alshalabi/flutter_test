import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_orders_model.dart';
import 'package:test_flutter/feature/products/presentation/blocs/order_cubit/orders_cubit.dart';

class ProductDeleteWidget extends StatelessWidget {
  const ProductDeleteWidget({
    Key? key,
    required this.order,
  }) : super(key: key);
  final OrderModel? order;
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        end: 10,
        bottom: 10,
        top: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              context.read<OrdersCubit>().deleteOrder(order?.id ?? -1);
            },
            child: const Icon(
              Icons.delete_rounded,
              color: Colors.red,
            ),
          ),
          Row(
            children: [
              Text(
                "status: ",
                style: StylesText.newTextStyleForAppBar
                    .copyWith(color: theme.black, fontSize: 10),
              ),
              Text(
                order?.status ?? "",
                style: StylesText.newTextStyleForAppBar
                    .copyWith(color: theme.error, fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}
