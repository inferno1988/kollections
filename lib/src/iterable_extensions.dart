import 'package:kollections/kollections.dart';
import 'map_extensions.dart';

extension IterableExtensions<E> on Iterable<E> {
  List<List<E>> windowed(
    int size, {
    int step = 1,
    bool partialWindows = false,
  }) {
    _checkWindowSizeStep(size, step);
    final result = <List<E>>[];
    windowedIterator(this, size, step, partialWindows, false)
        .forEach((element) {
      result.add(element);
    });
    return result;
  }

  List<List<E>> chunked(int size) {
    return windowed(size, step: size, partialWindows: true);
  }

  void forEachIndexed(void Function(int index, E element) action) {
    var index = 0;
    for (final item in this) {
      action(index++, item);
    }
  }

  Map<K, List<E>> groupBy<K>(K Function(E element) keySelector) {
    return groupByTo(<K, List<E>>{}, keySelector);
  }

  M groupByTo<K, M extends Map<K, List<E>>>(
      M destination, K Function(E element) keySelector) {
    for (final element in this) {
      final selectedKey = keySelector(element);
      final list = destination.getOrPut(selectedKey, () => <E>[]);
      list.add(element);
    }
    return destination;
  }

  M associateWithTo<V, M extends Map<E, V>>(
      M destination, V Function(E key) valueSelector) {
    for (final element in this) {
      destination[element] = valueSelector(element);
    }
    return destination;
  }

  Map<E, V> associateWith<V>(V Function(E key) valueSelector) {
    return associateWithTo(<E, V>{}, valueSelector);
  }

  List<E> unmodifiable() {
    return List.unmodifiable(this);
  }
}

Iterable<List<T>> windowedIterator<T>(Iterable<T> iterator, int size, int step,
    bool partialWindows, bool reuseBuffer) sync* {
  if (iterator.isEmpty) yield [];
  final gap = step - size;
  if (gap >= 0) {
    var buffer = <T>[];
    var skip = 0;
    for (final e in iterator) {
      if (skip > 0) {
        skip -= 1;
        continue;
      }
      buffer.add(e);
      if (buffer.length == size) {
        yield (buffer);
        if (reuseBuffer) {
          buffer.clear();
        } else {
          buffer = <T>[];
        }
        skip = gap;
      }
    }
    if (buffer.isNotEmpty) {
      if (partialWindows || buffer.length == size) yield (buffer);
    }
  } else {
    final buffer = <T>[];
    for (final e in iterator) {
      buffer.add(e);
      if (buffer.length == size) {
        Iterable<T> result;
        if (reuseBuffer) {
          result = buffer;
        } else {
          result = List.of(buffer);
        }
        yield (result);
        buffer.removeRange(0, step);
      }
    }
    if (partialWindows) {
      while (buffer.length > step) {
        Iterable<T> result;
        if (reuseBuffer) {
          result = buffer;
        } else {
          result = List.of(buffer);
        }
        yield (result);
        buffer.removeRange(0, step);
      }
      if (buffer.isNotEmpty) yield (buffer);
    }
  }
}

void _checkWindowSizeStep(int size, int step) {
  requireWithMessage(size > 0 && step > 0, () {
    if (size != step) {
      return 'Both size $size and step $step must be greater than zero.';
    } else {
      return 'size $size must be greater than zero.';
    }
  });
}
