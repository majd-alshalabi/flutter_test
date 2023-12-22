import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:test_flutter/core/constants/enums.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/global_widget/shimmer_widgets.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:test_flutter/feature/products/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:test_flutter/feature/products/presentation/widgets/home_page_widgets/product_list_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.read<ThemeCubit>().globalAppTheme;

    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: theme.darkThemeForScafold,
          appBar: AppBar(
            leadingWidth: 10.w,
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color:
                      theme.reserveDarkScaffold, // Set your desired color here
                ),
            backgroundColor: theme.darkAndWhiteForAppBar,
            title: TextField(
              onSubmitted: (value) {
                context.read<SearchBloc>().add(
                      NewSearchEvents(
                        name: value,
                      ),
                    );
              },
              controller: searchController,
              decoration: InputDecoration(
                fillColor: theme.darkAndWhiteForAppBar,
                hintText: "Search",
                hintStyle: StylesText.newTextStyleForAppBar.copyWith(
                  color: theme.greyWeak,
                  fontSize: 20,
                ),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: theme.reserveDarkScaffold,
                  ),
                  onPressed: () {
                    context.read<SearchBloc>().add(
                          NewSearchEvents(name: searchController.text),
                        );
                  },
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              BlocBuilder<SearchBloc, SearchState>(
                buildWhen: (previous, current) {
                  if (current is UpdateRateLoaded) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  return SfSlider(
                    min: 0.0,
                    max: 5.0,
                    value: context.read<SearchBloc>().rate ?? 0,
                    interval: 1,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: false,
                    minorTicksPerInterval: 1,
                    activeColor: theme.secondary,
                    onChanged: (dynamic value) {
                      context.read<SearchBloc>().add(UpdateRate(rate: value));
                    },
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                    left: 10.0,
                    top: 10,
                  ),
                  child: BlocBuilder<SearchBloc, SearchState>(
                    buildWhen: (previous, current) {
                      if (current is SearchLoaded) return true;
                      if (current is SearchLoading) return true;
                      if (current is SearchError) return true;
                      return false;
                    },
                    bloc: context.read<SearchBloc>(),
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const HomeLoadingWidget();
                      }
                      if (context.read<SearchBloc>().products.isEmpty) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "no data to show",
                              style: StylesText.newDefaultTextStyle
                                  .copyWith(color: theme.black),
                            ),
                          ],
                        ));
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return BlocBuilder<SearchBloc, SearchState>(
                            buildWhen: (previous, current) {
                              if (current is UpdateCommentCountInSearchLoaded &&
                                  current.productId ==
                                      context
                                          .read<SearchBloc>()
                                          .products[index]
                                          .id) {
                                return true;
                              }
                              return false;
                            },
                            builder: (context, state) {
                              return ProductsListItem(
                                product:
                                    context.read<SearchBloc>().products[index],
                                fromWhere: FromWhereForProductItem.search,
                              );
                            },
                          );
                        },
                        itemCount: context.read<SearchBloc>().products.length,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
