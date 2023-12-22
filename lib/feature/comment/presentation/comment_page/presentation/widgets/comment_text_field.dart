import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_flutter/core/constants/styles.dart';
import 'package:test_flutter/core/utils/themes.dart';
import 'package:test_flutter/feature/other_featuer/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

class ChatUITextField extends StatefulWidget {
  const ChatUITextField({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
    required this.onSend,
  }) : super(key: key);

  /// Provides focusNode for focusing text field.
  final FocusNode focusNode;

  /// Provides functions which handles text field.
  final TextEditingController textEditingController;

  final Function(String) onSend;

  @override
  State<ChatUITextField> createState() => _ChatUITextFieldState();
}

class _ChatUITextFieldState extends State<ChatUITextField> {
  final ValueNotifier<String> _inputText = ValueNotifier('');

  OutlineInputBorder get _outLineBorder => OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20),
      );
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read<ThemeCubit>().globalAppTheme;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.greyWeak,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: widget.focusNode,
              controller: widget.textEditingController,
              style: StylesText.newDefaultTextStyle.copyWith(
                color: theme.darkThemeForScafold,
                fontSize: 14,
              ),
              textCapitalization: TextCapitalization.sentences,
              cursorColor: theme.darkThemeForScafold,
              onChanged: (value) {
                _inputText.value = value;
              },
              decoration: InputDecoration(
                hintText: "enter comment",
                fillColor: Colors.transparent,
                filled: true,
                hintStyle: StylesText.newDefaultTextStyle.copyWith(
                  color: theme.darkThemeForScafold,
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                border: _outLineBorder,
                focusedBorder: _outLineBorder,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<String>(
              valueListenable: _inputText,
              builder: (_, inputTextValue, child) {
                if (inputTextValue.isEmpty) return const Offstage();

                return IconButton(
                  color: theme.darkThemeForScafold,
                  onPressed: () {
                    widget.onSend.call(widget.textEditingController.text);
                    _inputText.value = '';
                    widget.textEditingController.clear();
                    widget.focusNode.unfocus();
                  },
                  icon: const FaIcon(FontAwesomeIcons.circleArrowRight),
                );
              }),
        ],
      ),
    );
  }
}
