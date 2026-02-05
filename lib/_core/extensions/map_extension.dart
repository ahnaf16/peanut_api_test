import 'package:flutter/material.dart';
import 'package:post_wagens/_core/utility/parser.dart';

extension MapEx<K, V> on Map<K, V> {
  Map<String, V> toStringKey() => map((k, v) => MapEntry('$k', v));

  int parseInt(K key, [int fallBack = 0]) {
    final it = this[key];
    return Parser.toInt(it) ?? fallBack;
  }

  double parseDouble(String key, {double fallBack = 0.0}) {
    final it = this[key];
    return Parser.toDouble(it) ?? fallBack;
  }

  num parseNum(String key, {num fallBack = 0, bool fixed = true}) {
    final it = this[key];
    return Parser.toNum(it, fixed) ?? fallBack;
  }

  bool parseBool<T>(String key, [bool onNull = false]) {
    final it = this[key];
    return Parser.toBool(it) ?? onNull;
  }

  DateTime parseDate(String key) => DateTime.parse(this[key]?.toString() ?? '');
  DateTime? tryParseDate(String key) => Parser.tryDate(this[key]);
}

extension RemoveNull<K, V> on Map<K, V?> {
  Map<K, V> removeNull() {
    final result = {...this}..removeWhere((_, v) => v == null);
    return result.map((key, value) => MapEntry(key, value as V));
  }

  Map<K, V> removeNullAndEmpty() {
    final it = removeNull();
    final result = it
      ..removeWhere(
        (k, v) => switch (v) {
          _ when v is String && v.isEmpty => true,
          _ when v is List && v.isEmpty => true,
          _ when v is Map && v.isEmpty => true,
          _ => false,
        },
      );
    return result.map((key, value) => MapEntry(key, value));
  }
}

extension MapNotifierX<K, V> on ValueNotifier<Map<K, V>> {
  /// Set or replace a key-value pair.
  void setValue(K key, V value) {
    this.value = {...this.value, key: value};
  }

  /// Add all key-value pairs from another map.
  void addAllValues(Map<K, V> other) {
    value = {...value, ...other};
  }

  /// Remove value by key.
  void removeValue(K key) {
    final map = {...value};
    map.remove(key);
    value = map;
  }

  /// Update value at key using a builder function.
  void updateValue(K key, V Function(V? old) builder) {
    final map = {...value};
    map[key] = builder(map[key]);
    value = map;
  }

  /// Remove all.
  void clearValues() {
    value = {};
  }

  /// Toggle a key — remove if exists, set if not exists with given value.
  void toggleValue(K key, V defaultValue) {
    final map = {...value};
    if (map.containsKey(key)) {
      map.remove(key);
    } else {
      map[key] = defaultValue;
    }
    value = map;
  }

  /// Replace the entire map.
  void setValues(Map<K, V> newMap) {
    value = {...newMap};
  }

  /// Map over values and replace the entire map.
  void mapValues(V Function(K key, V value) mapper) {
    final newMap = <K, V>{};
    value.forEach((k, v) {
      newMap[k] = mapper(k, v);
    });
    value = newMap;
  }

  /// Update only if key exists.
  void updateIfExists(K key, V Function(V old) builder) {
    if (value.containsKey(key)) {
      updateValue(key, (old) => builder(old as V));
    }
  }

  /// Put value only if key is not already set.
  void setIfAbsent(K key, V value) {
    if (!this.value.containsKey(key)) {
      setValue(key, value);
    }
  }

  /// Remove all keys that match a condition.
  void removeWhere(bool Function(K key, V value) test) {
    final map = {...value}..removeWhere(test);
    value = map;
  }

  /// Merge with another map using a custom conflict resolver.
  void mergeWith(Map<K, V> other, V Function(K key, V a, V b) conflict) {
    final map = {...value};
    other.forEach((k, v) {
      if (map.containsKey(k)) {
        map[k] = conflict(k, map[k] as V, v);
      } else {
        map[k] = v;
      }
    });
    value = map;
  }
}
