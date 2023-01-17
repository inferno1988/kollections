extension ObjectExtensions<T> on T {
  T also(void Function(T it) block) {
    block(this);
    return this;
  }

  T? takeIf(bool Function(T it) block) {
    return block(this) ? this : null;
  }
  
  R? tryCast<R>() {
    if (this is R) {
      return this as R;
    }
    
    return null;
  }
  
  R let<R>(R Function(T it) block) {
    return block(this);
  }

  R run<R>(R Function() block) {
    return block();
  }
}
