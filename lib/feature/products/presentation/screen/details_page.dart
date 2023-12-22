import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/core/constants/assets.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/global_widget/dialogs/order_dialog.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/core/utils/utils.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_products_model.dart';
import 'package:test_flutter/feature/products/presentation/blocs/details_cubit/details_cubit.dart';
import 'package:test_flutter/feature/products/presentation/widgets/home_page_widgets/product_list_item.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) => DetailsCubit(),
      child: Builder(builder: (context) {
        return LoaderOverlay(
          overlayColor: Colors.grey.withOpacity(0.4),
          useDefaultLoading: false,
          overlayWidget: Center(
            child: SpinKitSpinningLines(
              color: theme.white,
              size: 50.0,
            ),
          ),
          child: BlocListener<DetailsCubit, DetailsState>(
            listener: (context, state) {
              if (state is RateProductLoading) {
                AppSettings().navigatorKey.currentContext?.loaderOverlay.show();
              } else if (state is RateProductLoaded) {
                AppSettings().navigatorKey.currentContext?.loaderOverlay.hide();
                Utils.showCustomToast("rate Added Successfully");
              }
            },
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: theme.reserveDarkScaffold,
                onPressed: () {
                  Utils.showCustomDialog(
                    ctx: context,
                    heightDialog: 30.h,
                    iconWidget: SvgPicture.asset(
                      Assets.order,
                      height: 20.h,
                    ),
                    distanceBetweenTopScreenAndIcons: 16.h,
                    bodyWidget: OrderDialogBody(
                      productId: product.id ?? -1,
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                backgroundColor: theme.newColorForAppBar,
                elevation: 0.0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.close_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  "Product Details",
                  style: StylesText.newTextStyleForAppBar
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              backgroundColor: theme.darkThemeForScafold,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(imageUrl: product.image ?? ""),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title ?? "",
                            style: StylesText.newDefaultTextStyle.copyWith(
                              color: theme.black,
                              fontSize: 19,
                            ),
                          ),
                          BlocBuilder<DetailsCubit, DetailsState>(
                            buildWhen: (previous, current) {
                              if (current is DetailsUpdateCommentLoaded &&
                                  product.id == current.productId) {
                                return true;
                              }
                              return false;
                            },
                            builder: (context, state) {
                              return ProductCommentWidget(
                                product: product,
                              );
                            },
                          ),
                          if (product.description?.isNotEmpty ?? false)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                product.description ?? "",
                                style: StylesText.newDefaultTextStyle.copyWith(
                                  color: theme.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            "Since ${product.createdAt ?? ""}",
                            style: StylesText.defaultTextStyle.copyWith(
                              color: theme.greyWeak,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
