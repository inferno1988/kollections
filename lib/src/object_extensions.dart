extension ObjectExtensions<T> on T {
  T also(void Function(T it) block) {
    block(this);
    return this;
  }
}

extension ObjectExtensionsWithResult<R, T> on T {
  R let(R Function(T it) block) {
    return block(this);
  }

  R run(R Function() block) {
    return block();
  }
}
