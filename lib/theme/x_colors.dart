import 'package:flutter/material.dart';

@immutable
class XColors extends ThemeExtension<XColors> {
  const XColors({
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
  });

  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? success;
  final Color? onSuccess;
  final Color? successContainer;
  final Color? onSuccessContainer;

  @override
  XColors copyWith({
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
  }) {
    return XColors(
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
    );
  }

  @override
  XColors lerp(ThemeExtension<XColors>? other, double t) {
    if (other is! XColors) return this;
    return XColors(
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t),
      success: Color.lerp(success, other.success, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
    );
  }

  static XColors get light => const XColors(
    warning: Color(0xFFF4B400),
    onWarning: Color(0xFFFFFFFF),
    warningContainer: Color(0xFFFFF4D6),
    onWarningContainer: Color(0xFF4C3400),
    success: Color(0xFF2FA36B),
    onSuccess: Color(0xFFFFFFFF),
    successContainer: Color(0xFFDFF6EA),
    onSuccessContainer: Color(0xFF00391F),
  );

  static XColors get dark => const XColors(
    warning: Color(0xFFFFCC00),
    onWarning: Color(0xFF432C00),
    warningContainer: Color(0xFF614000),
    onWarningContainer: Color(0xFFFFE085),
    success: Color(0xFF7ED9A1),
    onSuccess: Color(0xFF00391F),
    successContainer: Color(0xFF00522B),
    onSuccessContainer: Color(0xFFB9F6CC),
  );
}
