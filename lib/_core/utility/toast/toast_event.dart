import 'package:flutter/material.dart';

enum ToastType { success, error, info }

class ToastEvent {
  final String title;
  final String? message;
  final String? actionText;
  final IconData? actionIcon;
  final VoidCallback? actionTap;
  final ToastType type;
  final Duration duration;

  const ToastEvent({
    required this.title,
    this.message,
    this.type = ToastType.info,
    this.duration = const Duration(seconds: 3),
    this.actionText,
    this.actionIcon,
    this.actionTap,
  });

  const ToastEvent.success({
    required this.title,
    this.message,
    this.actionText,
    this.actionIcon,
    this.actionTap,
    this.duration = const Duration(seconds: 3),
  }) : type = .success;

  const ToastEvent.error({
    required this.title,
    this.message,
    this.actionText,
    this.actionIcon,
    this.actionTap,
    this.duration = const Duration(seconds: 4),
  }) : type = .error;

  const ToastEvent.info({
    required this.title,
    this.message,
    this.actionText,
    this.actionIcon,
    this.actionTap,
    this.duration = const Duration(seconds: 3),
  }) : type = .info;
}
