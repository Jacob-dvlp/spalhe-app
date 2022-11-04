import 'package:flutter/material.dart';
import 'package:spalhe/utils/routes.dart';

showDialogModal({
  required BuildContext context,
  required String title,
  required String description,
  required Function() onConfirm,
  String? cancelText,
  String? confirmText,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: OnRoute.back,
            child: Text(
              cancelText ?? 'Cancelar',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              OnRoute.back();
            },
            child: Text(
              confirmText ?? 'Confirmar',
              style: TextStyle(),
            ),
          ),
        ],
      );
    },
  );
}
