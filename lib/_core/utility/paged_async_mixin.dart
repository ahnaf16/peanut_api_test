import 'package:post_wagens/models/base/paged_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin PagedAsyncMixin<T> on $AsyncNotifier<PagedItem<T>> {
  /// Must be implemented by the controller
  FutureOr<PagedItem<T>> fetchPage({int page = 1});

  /// Reload first page
  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return fetchPage();
    });
  }

  /// Returns true if no more data is available
  Future<bool> loadMore() async {
    final current = await future;
    final meta = current.meta;

    if (meta.page >= meta.totalPage) return true;

    final next = await fetchPage(page: meta.page + 1);
    final newData = current.addWithPrevious(next);

    state = AsyncData(newData);
    return next.meta.page >= next.meta.totalPage;
  }
}
