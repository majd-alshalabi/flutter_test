import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/global_widget/global_widget.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/core/utils/utils.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/presentation/blocs/product_event_bloc/product_event_cubit.dart';

class RateDialogBody extends StatefulWidget {
  const RateDialogBody({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<RateDialogBody> createState() => _RateDialogBodyState();
}

class _RateDialogBodyState extends State<RateDialogBody> {
  double rate = 0;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) => ProductEventCubit(),
      child: Builder(builder: (context) {
        return BlocListener<ProductEventCubit, ProductEventState>(
          listener: (context, state) {
            if (state is RateProductLoaded) {
              Utils.showCustomToast("rate added successfully");
            } else if (state is RateProductError) {
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
                    "rate this product",
                    style: StylesText.newDefaultTextStyle
                        .copyWith(color: theme.text),
                  ),
                ),
                Center(
                  child: PannableRatingBar(
                    rate: rate,
                    items: List.generate(
                      5,
                      (index) => RatingWidget(
                        selectedColor: Colors.yellowAccent,
                        unSelectedColor: theme.greyWeak,
                        child: Icon(
                          Icons.star,
                          size: 48,
                          color: theme.greyWeak,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      rate = value;
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: BlocBuilder<ProductEventCubit, ProductEventState>(
                    buildWhen: (previous, current) {
                      if (current is RateProductLoaded) {
                        return true;
                      } else if (current is RateProductLoading) {
                        return true;
                      } else if (current is RateProductError) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      if (state is RateProductLoading) {
                        return CircularProgressIndicator(
                          color: theme.secondary,
                        );
                      }
                      return CustomButton(
                        text: "submit",
                        height: 40,
                        onPress: () {
                          context.read<ProductEventCubit>().rateProduct(
                              productId: widget.productId, rate: rate);
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
