import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/core/constants/assets.dart';
import 'package:test_flutter/core/constants/enums.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/global_widget/dialogs/rate_dialog.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/core/utils/utils.dart';
import 'package:test_flutter/feature/comment/presentation/comment_page/presentation/comment_page.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_orders_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_products_model.dart';
import 'package:test_flutter/feature/products/presentation/screen/details_page.dart';
import 'package:test_flutter/feature/products/presentation/widgets/order_page_widgets/delete_order_widget.dart';

class ProductsListItem extends StatelessWidget {
  const ProductsListItem({
    super.key,
    required this.product,
    this.order,
    required this.fromWhere,
  });
  final ProductsModel product;
  final OrderModel? order;
  final FromWhereForProductItem fromWhere;
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return InkWell(
      onTap: () {
        if (fromWhere == FromWhereForProductItem.home) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(product: product),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.darkAndWhiteForAppBar,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  ImagesSection(
                    theme: theme,
                    images:
                        (product.image != null ? [product.image ?? ""] : []),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      constraints: (product.image != null)
                          ? BoxConstraints(minHeight: 15.h)
                          : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            product.title ?? "",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: StylesText.newDefaultTextStyle.copyWith(
                                color: theme.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                height: 1),
                          ),
                          Text(
                            product.description ?? "",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: StylesText.newDefaultTextStyle.copyWith(
                              color: theme.greyWeak,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          if (fromWhere == FromWhereForProductItem.home)
                            ProductCommentWidget(
                              product: product,
                            )
                          else
                            ProductDeleteWidget(order: order),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCommentWidget extends StatelessWidget {
  const ProductCommentWidget({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductsModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          end: 10,
          bottom: 10,
          top: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CommentPage(productId: product.id ?? -1),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const FaIcon(FontAwesomeIcons.comments, size: 17),
                  const SizedBox(width: 10),
                  Text(
                    "${product.comments}",
                    style: StylesText.defaultTextStyle,
                  ),
                ],
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Utils.showCustomDialog(
                  ctx: context,
                  heightDialog: 30.h,
                  iconWidget: SvgPicture.asset(Assets.rate, height: 20.h),
                  distanceBetweenTopScreenAndIcons: 17.h,
                  bodyWidget: RateDialogBody(
                    productId: product.id ?? -1,
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.star,
                    size: 17,
                    color: Colors.yellow,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    (product.rate ?? 0.0).toStringAsFixed(1),
                    style: StylesText.defaultTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagesSection extends StatelessWidget {
  const ImagesSection({
    Key? key,
    required this.theme,
    required this.images,
  }) : super(key: key);
  final AppTheme theme;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const Offstage();
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 30.w,
        width: 30.w,
        child: CachedNetworkImage(
          imageUrl: images.first,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TestUserAvatar extends StatelessWidget {
  const TestUserAvatar({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    try {
      return CircleAvatar(
        radius: width / 2,
        backgroundColor: theme.greyWeak,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            Assets.userAvatarAsset,
            width: width,
            height: width,
            fit: BoxFit.fill,
          ),
        ),
      );
    } catch (e) {
      return CircleAvatar(
        radius: width / 2,
        backgroundColor: theme.greyWeak,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: const Image(
            image: AssetImage(Assets.userAvatarAsset),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }
}
