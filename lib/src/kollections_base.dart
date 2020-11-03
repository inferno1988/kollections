void require(bool value) {
  requireWithMessage(value, () => 'Failed requirement.');
}

void requireWithMessage(bool value, dynamic Function() lazyMessage) {
  if (!value) {
    final message = lazyMessage();
    throw ArgumentError(message.toString());
  }
}
