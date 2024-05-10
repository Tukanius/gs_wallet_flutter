import 'package:flutter/material.dart';
import 'package:green_score/main.dart';
import 'package:green_score/services/dialog.dart';

import 'components/error_dialog.dart';
import 'components/notification_dialog.dart';
import 'components/success_dialog.dart';

class DialogManager extends StatefulWidget {
  final Widget? child;
  const DialogManager({super.key, this.child});
  @override
  DialogManagerState createState() => DialogManagerState();
}

class DialogManagerState extends State<DialogManager> {
  DialogService? dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    dialogService!.registerGetContextListener(getContext);
    dialogService!.registerSuccessDialogListener(
        SuccessDialog(context: context, dialogService: dialogService).show);
    dialogService!.registerErrorDialogListener(
        ErrorDialog(context: context, dialogService: dialogService).show);
    dialogService!.registerNotification(
        NotificationDialog(context: context, dialogService: dialogService)
            .show);
  }

  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
