import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/global_widget/shimmer_widgets.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/comment/data/models/remote/comment_model.dart';
import 'package:test_flutter/feature/comment/domain/use_cases/get_comment_use_case.dart';
import 'package:test_flutter/feature/comment/presentation/comment_page/bloc/comment_cubit.dart';
import 'package:test_flutter/feature/comment/presentation/comment_page/presentation/widgets/comment_list_item.dart';
import 'package:test_flutter/feature/comment/presentation/comment_page/presentation/widgets/comment_text_field.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return BlocProvider(
      create: (context) => CommentCubit()..getComment(widget.productId),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: theme.darkThemeForScafold,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: theme.newColorForAppBar,
            elevation: 0,
            title: Text(
              "Comments",
              style: StylesText.newTextStyleForAppBar
                  .copyWith(color: Colors.white),
            ),
          ),
          body: BlocBuilder(
            buildWhen: (previous, current) {
              if (current is GetCommentError) return true;
              if (current is GetCommentLoading) return true;
              if (current is GetCommentLoaded) return true;
              if (current is AddCommentLoaded) return true;
              return false;
            },
            bloc: context.read<CommentCubit>(),
            builder: (context, state) {
              if (state is GetCommentLoading) {
                return const CommentLoadingWidget();
              }
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: context.read<CommentCubit>().comments.isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "no comment to show",
                                style: StylesText.defaultTextStyle,
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<CommentCubit>()
                                      .getComment(widget.productId);
                                },
                                child: Text(
                                  "try again",
                                  style: StylesText.newDefaultTextStyle
                                      .copyWith(color: theme.primary),
                                ),
                              )
                            ],
                          ))
                        : RefreshIndicator(
                            color: theme.primary,
                            onRefresh: () async {
                              final result = await GetCommentsUseCase().call(
                                GetCommentParamsModel(
                                  productId: widget.productId,
                                ),
                              );
                              result.fold(
                                (l) => context
                                    .read<CommentCubit>()
                                    .updateCommentList([]),
                                (r) => context
                                    .read<CommentCubit>()
                                    .updateCommentList(r.data ?? []),
                              );
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return CommentListItem(
                                  comment: context
                                      .read<CommentCubit>()
                                      .comments[index],
                                );
                              },
                              itemCount:
                                  context.read<CommentCubit>().comments.length,
                            ),
                          ),
                  ),
                  ChatUITextField(
                    focusNode: focusNode,
                    textEditingController: controller,
                    onSend: (commentText) {
                      context.read<CommentCubit>().addComment(
                            productId: widget.productId,
                            comment: commentText,
                          );
                    },
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
