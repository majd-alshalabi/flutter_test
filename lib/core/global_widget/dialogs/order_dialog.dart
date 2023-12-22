import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/global_widget/global_widget.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/core/utils/utils.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/presentation/blocs/product_event_bloc/product_event_cubit.dart';

class OrderDialogBody extends StatelessWidget {
  const OrderDialogBody({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) => ProductEventCubit(),
      child: Builder(builder: (context) {
        return BlocListener<ProductEventCubit, ProductEventState>(
          listener: (context, state) {
            if (state is OrderProductLoaded) {
              Utils.showCustomToast("order added successfully");
            } else if (state is OrderProductError) {
              Utils.showCustomToast(state.error);
            }
          },
          child: SizedBox(
            height: 20.h,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Text(
                    "order this product",
                    style: StylesText.newDefaultTextStyle
                        .copyWith(color: theme.text),
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: BlocBuilder<ProductEventCubit, ProductEventState>(
                    buildWhen: (previous, current) {
                      if (current is OrderProductLoading) {
                        return true;
                      } else if (current is OrderProductLoaded) {
                        return true;
                      } else if (current is OrderProductError) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      if (state is OrderProductLoading) {
                        return CircularProgressIndicator(
                          color: theme.secondary,
                        );
                      }
                      return CustomButton(
                        text: "submit",
                        height: 40,
                        onPress: () {
                          context.read<ProductEventCubit>().orderProduct(
                                productId: productId,
                              );
                        },
                        borderColor: theme.greyWeak,
                        textStyleForButton: StylesText.newDefaultTextStyle,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
