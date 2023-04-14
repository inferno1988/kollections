import 'dart:async';

extension MapExtensions<K, V> on Map<K, V> {
  V getOrPut(K key, V Function() defaultValue) {
    final value = this[key];
    if (value == null) {
      final answer = defaultValue();
      this[key] = answer;
      return answer;
    } else {
      return value;
    }
  }

  M filterTo<M extends Map<K, V>>(
      M destination, bool Function(MapEntry<K, V>) predicate) {
    for (final element in entries) {
      if (predicate(element)) {
        destination[element.key] = element.value;
      }
    }
    return destination;
  }

  Map<K, V> filter(bool Function(MapEntry<K, V> entry) predicate) {
    return filterTo(<K, V>{}, predicate);
  }

  M filterNotTo<M extends Map<K, V>>(
      M destination, bool Function(MapEntry<K, V>) predicate) {
    for (final element in entries) {
      if (!predicate(element)) {
        destination[element.key] = element.value;
      }
    }
    return destination;
  }

  Map<K, V> filterNot(bool Function(MapEntry<K, V>) predicate) {
    return filterNotTo(<K, V>{}, predicate);
  }

  Map<K, V> unmodifiable() {
    return Map.unmodifiable(this);
  }

  M intersectWithTo<V2, V3, M extends Map<K, V3>>(M destination,
      Map<K, V2> other, V3 Function(V first, V2 second) intersector) {
    final commonKeys = other.filter((entry) => containsKey(entry.key)).keys;

    for (final key in commonKeys) {
      destination[key] = intersector(this[key]!, other[key]!);
    }

    return destination;
  }

  Map<K, V3> intersectWith<V2, V3>(
      Map<K, V2> other, V3 Function(V first, V2 second) intersector) {
    return intersectWithTo(<K, V3>{}, other, intersector);
  }

  FutureOr<Map<K, V2>> asyncMap<V2>(
      FutureOr<MapEntry<K, V2>> Function(K key, V value) transform) async {
    var result = <K, V2>{};
    for (var key in keys) {
      var entry = await transform(key, this[key] as V);
      result[entry.key] = entry.value;
    }
    return result;
  }
}
