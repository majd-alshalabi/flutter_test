import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter/core/global_widget/dialogs/custom_dialog.dart';

class Utils {
  static void showCustomDialog({
    required BuildContext ctx,
    required Widget bodyWidget,
    Widget? iconWidget,
    double? heightDialog,
    double? distanceBetweenTopScreenAndIcons,
    Function()? onThen,
  }) {
    showDialog(
      context: ctx,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: CustomDialog(
            bodyWidget: bodyWidget,
            heightDialog: heightDialog,
            iconWidget: iconWidget,
            distanceBetweenTopScreenAndIcons: distanceBetweenTopScreenAndIcons,
          ),
        );
      },
    ).then((value) {
      if (onThen != null) {
        onThen();
      }
    });
  }

  static void showCustomToast(String message) {
    Fluttertoast.showToast(
      fontSize: 9,
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static String dateToUtcFormatted(DateTime date) {
    try {
      return "${DateFormat.yMMMd().format(date)} ${DateFormat.jm().format(date)}";
    } catch (e) {
      return "";
    }
  }
}
