import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../config/const/sensei_const.dart';
import '../../routing/app_router.dart';

void showSimpleToast(final String message) {
  toastification.show(
    style: ToastificationStyle.simple,
    title: Text(message),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    padding: const EdgeInsets.all(SenseiConst.padding),
    backgroundColor: AppRouter.theme.surface,
    foregroundColor: AppRouter.theme.onSurface,
    borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
    closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
    borderSide: BorderSide(
      strokeAlign: BorderSide.strokeAlignCenter,
      color: AppRouter.theme.outline.withAlpha(0x80),
    ),
    dragToClose: true,
    pauseOnHover: true,
  );
}

/// Shows a toast with the given [message] for a long duration at the bottom of
/// the screen with a red background and white text.
void showErrorToast(final String discription) {
  toastification.show(
    type: ToastificationType.error,
    style: ToastificationStyle.minimal,
    title: const Text('حدث خطأ'),
    description: Text(discription),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    padding: const EdgeInsets.all(SenseiConst.padding),
    backgroundColor: AppRouter.theme.surface,
    foregroundColor: AppRouter.theme.onSurface,
    borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
    closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
    borderSide: BorderSide(
      strokeAlign: BorderSide.strokeAlignCenter,
      color: AppRouter.theme.outline.withAlpha(0x80),
    ),
    dragToClose: true,
    pauseOnHover: true,
    showProgressBar: true,
  );
}

void showWarningToast(final String discription) {
  toastification.show(
    type: ToastificationType.warning,
    style: ToastificationStyle.minimal,
    title: const Text('تحذير'),
    description: Text(discription),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    padding: const EdgeInsets.all(SenseiConst.padding),
    backgroundColor: AppRouter.theme.surface,
    foregroundColor: AppRouter.theme.onSurface,
    borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
    closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
    borderSide: BorderSide(
      strokeAlign: BorderSide.strokeAlignCenter,
      color: AppRouter.theme.outline.withAlpha(0x80),
    ),
    dragToClose: true,
    pauseOnHover: true,
    showProgressBar: true,
  );
}

/// Shows a toast with the given [message] for a short duration at the bottom
/// of the screen with a green background and white text.

void showSuccessToast(final String message) {
  toastification.show(
    type: ToastificationType.success,
    style: ToastificationStyle.minimal,
    title: Text(message),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    backgroundColor: AppRouter.theme.surface,
    foregroundColor: AppRouter.theme.onSurface,
    borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
    closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
    borderSide: BorderSide(
      strokeAlign: BorderSide.strokeAlignCenter,
      color: AppRouter.theme.outline.withAlpha(0x80),
    ),
    dragToClose: true,
    pauseOnHover: true,
  );
}

void showInfoToast(final String message) {
  toastification.show(
    type: ToastificationType.info,
    style: ToastificationStyle.minimal,
    title: const Text('معلومات'),
    description: Text(message),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    backgroundColor: AppRouter.theme.surface,
    foregroundColor: AppRouter.theme.onSurface,
    borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
    closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
    borderSide: BorderSide(
      strokeAlign: BorderSide.strokeAlignCenter,
      color: AppRouter.theme.outline.withAlpha(0x80),
    ),
    dragToClose: true,
    pauseOnHover: true,
    showProgressBar: true,
  );
}
