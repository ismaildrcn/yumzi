import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:yumzi/enums/message_type.dart';

class MessageBox {
  MessageBox._();

  static void show(
    BuildContext context, {
    required String message,
    MessageType type = MessageType.info,
  }) {
    if (message.isEmpty) return;

    switch (type) {
      case MessageType.error:
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(message: message),
        );
        break;
      case MessageType.success:
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(message: message),
        );
        break;
      case MessageType.info:
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(message: message),
        );
        break;
    }
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, type: MessageType.error);
  }

  static void success(BuildContext context, String message) {
    show(context, message: message, type: MessageType.success);
  }

  static void info(BuildContext context, String message) {
    show(context, message: message, type: MessageType.info);
  }
}
