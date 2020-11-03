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

  Map<K, V> filter(bool Function(MapEntry<K, V>) predicate) {
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
}
