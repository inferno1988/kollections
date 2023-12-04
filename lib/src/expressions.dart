T? when<T>(List<T Function()> cases, {T? orElse}) {
  try {
    return cases.map((e) => e()).firstWhere((element) => element != null);
  } catch (e) {
    return orElse;
  }
}
