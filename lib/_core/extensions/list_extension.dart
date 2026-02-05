import 'package:flutter/material.dart';

extension IterableEx<T> on Iterable<T> {
  List<T> takeFirst([int listLength = 10]) {
    final itemCount = length;
    final takeCount = itemCount > listLength ? listLength : itemCount;
    return take(takeCount).toList();
  }

  T getRandom() {
    final list = toList();
    list.shuffle();
    return list.first;
  }

  List<T> getRandomList(int listLength) {
    final list = toList();
    list.shuffle();
    return list.takeFirst(listLength).toList();
  }
}

extension ListEx<T> on List<T?> {
  List<T> removeNull() {
    return where((e) => e != null).map((e) => e!).toList();
  }
}

extension ListNotifierX<T> on ValueNotifier<List<T>> {
  /// Add a single item.
  void addValue(T item) {
    value = [...value, item];
  }

  /// Add multiple items.
  void addAllValues(Iterable<T> items) {
    value = [...value, ...items];
  }

  /// Insert item at a specific index.
  void insertValue(int index, T item) {
    final list = [...value];
    list.insert(index, item);
    value = list;
  }

  /// Remove first occurrence of item.
  void removeValue(T item) {
    final list = [...value];
    list.remove(item);
    value = list;
  }

  void removeWhereValue(bool Function(T item) test) {
    final list = [...value];
    list.removeWhere(test);
    value = list;
  }

  /// Remove item at index.
  void removeAtValue(int index) {
    final list = [...value];
    list.removeAt(index);
    value = list;
  }

  /// Clear all items.
  void clearValues() {
    value = [];
  }

  /// Replace item at index with a modified version.
  void updateAt(int index, T Function(T old) builder) {
    final list = [...value];
    list[index] = builder(list[index]);
    value = list;
  }

  /// Replace the entire list with a new mapped list.
  void mapValues(T Function(T old) mapper) {
    value = value.map(mapper).toList();
  }

  /// Toggle an item (add if not exists, remove if exists).
  void toggleValue(T item) {
    final list = [...value];

    if (list.contains(item)) {
      list.remove(item);
    } else {
      list.add(item);
    }
    value = list;
  }

  /// Sort using custom comparator.
  void sortValues(int Function(T a, T b) compare) {
    final list = [...value]..sort(compare);
    value = list;
  }

  /// Add item only if it doesn't already exist.
  void addIfNotExists(T item) {
    if (!value.contains(item)) {
      addValue(item);
    }
  }

  /// Replace entire list safely.
  void setValues(List<T> items) {
    value = [...items];
  }
}
