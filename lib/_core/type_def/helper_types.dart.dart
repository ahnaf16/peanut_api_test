import 'dart:async';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

typedef FromMapT<T> = T Function(QMap map);
typedef ToMapT<T> = Map Function(T data);

typedef QMap = Map<String, dynamic>;
typedef SMap = Map<String, String>;

typedef FormBuilderTextState = FormBuilderFieldState<FormBuilderField<String>, String>;

typedef FVoid = Future<void>;
typedef FCallback<T> = Future<T> Function();
typedef FVCallback<T> = Future<T> Function(T value);
typedef LIcon = LucideIcons;

