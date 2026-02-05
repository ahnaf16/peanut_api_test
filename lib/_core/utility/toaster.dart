// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:peanut_api_test/_core/logging/cat.dart';
// import 'package:peanut_api_test/_core/utility/failure.dart';
// import 'package:recase/recase.dart';
// import 'package:toastification/toastification.dart';

// extension ToastificationItemEx on ToastificationItem {
//   T andReturn<T>(T value) => value;
// }

// class Toaster {
//   const Toaster._();

//   static const Duration _animationDuration = kThemeAnimationDuration;
//   static Duration autoCloseDuration = const Duration(seconds: 4) + _animationDuration;

//   static ToastificationStyle? style = ToastificationStyle.flat;

//   static AlignmentGeometry alignment = Alignment.topLeft;

//   static GlobalKey<NavigatorState>? navigator;

//   static ToastificationItem showSuccess(String? msg, [Function()? onTap]) {
//     return _show(msg, type: ToastificationType.success, onTap: onTap);
//   }

//   static ToastificationItem showInfo(String? info, [Function()? onTap]) {
//     return _show(info, onTap: onTap, type: ToastificationType.info);
//   }

//   static ToastificationItem showError(Object error, [String? body, Function()? onTap]) {
//     var msg = error.toString();
//     String? body;
//     Object? err;
//     StackTrace? st;

//     if (error is Failure) {
//       msg = error.msg;
//       err = error.error;
//       st = error.stackTrace;
//     }

//     if (!kReleaseMode) {
//       onTap = () => catErr(msg, err, st ?? StackTrace.current);
//     }

//     return _show(msg, type: ToastificationType.error, body: body, onTap: onTap);
//   }

//   static ToastificationItem _show(
//     String? msg, {
//     required ToastificationType type,
//     String? body,
//     Duration? duration,
//     Function()? onTap,
//   }) {
//     remove();

//     return toastification.show(
//       type: type,
//       style: style,
//       title: Text(msg ?? type.name.titleCase, maxLines: body == null ? 2 : 1),
//       description: body == null ? null : Text(body, maxLines: 3),
//       alignment: alignment,
//       autoCloseDuration: duration ?? autoCloseDuration,
//       animationDuration: _animationDuration,
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: highModeShadow,
//       closeOnClick: false,
//       showProgressBar: false,
//       callbacks: ToastificationCallbacks(onTap: (value) => onTap?.call()),
//     );
//   }

//   static void remove() {
//     toastification.dismissAll();
//   }
// }
