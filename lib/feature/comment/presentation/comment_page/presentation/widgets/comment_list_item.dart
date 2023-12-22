import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/comment/data/models/remote/comment_model.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({
    Key? key,
    required this.comment,
  }) : super(key: key);
  final CommentModel comment;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
              color: theme.reserveDarkScaffold,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              comment.content ?? "",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: theme.white,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
            child: Text(
              comment.createdAt ?? "",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: theme.greyWeak,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
