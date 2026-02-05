import 'dart:math';

import 'package:peanut_api_test/main.export.dart';

class PagedItem<T> {
  const PagedItem({required this.items, this.meta = const MetaData()});

  const PagedItem.empty() : items = const [], meta = const MetaData();

  final List<T> items;
  final MetaData meta;

  factory PagedItem.fromMap(Map<String, dynamic> map, T Function(Map<String, dynamic>) parse, [String? itemsKey]) {
    final List<T> items = [];
    final data = map[itemsKey ?? 'items'];

    if (data case final List list) {
      for (final e in list) {
        if (e is Map) items.add(parse(e.toStringKey()));
      }
    }

    return PagedItem(items: items, meta: MetaData.tryParse(map['meta']) ?? const MetaData());
  }

  PagedItem<T> addWithPrevious(PagedItem<T> newData) {
    final list = items.toList();
    list.addAll(newData.items);
    return PagedItem(items: list, meta: newData.meta);
  }

  PagedItem<T> addItems(T item) {
    final list = items.toList();
    list.insert(0, item);
    return PagedItem(items: list, meta: meta);
  }

  PagedItem<E> map<E>(E Function(T e) toElement) => PagedItem(items: items.map(toElement).toList(), meta: meta);

  T operator [](int index) => items[index];
  int get length => items.length;

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  Map<String, dynamic> toMap(ToMapT<T> mapT, [String? itemsKey]) {
    return <String, dynamic>{itemsKey ?? 'data': items.map(mapT).toList(), 'metaData': meta.toMap()};
  }
}

class MetaData {
  const MetaData({this.page = 1, this.limit = 10, this.total = 0, this.totalPage = 1});

  final int page;
  final int limit;
  final int total;
  final int totalPage;

  factory MetaData.fromMap(Map<String, dynamic> map) => MetaData(
    page: map.parseInt('page'),
    limit: map.parseInt('limit'),
    total: Parser.toInt(map['total']) ?? Parser.toInt(map['totalDocuments']) ?? 0,
    totalPage: Parser.toInt(map['totalPage']) ?? Parser.toInt(map['totalPages']) ?? 0,
  );

  Map<String, dynamic> toMap() => {'page': page, 'limit': limit, 'total': total, 'totalPage': totalPage};

  static MetaData? tryParse(dynamic value) {
    try {
      if (value case final MetaData v) return v;
      if (value case final Map map) return MetaData.fromMap(map.toStringKey());
      return null;
    } catch (_) {
      return null;
    }
  }
}
