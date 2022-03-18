extension StringX on String {
  String toSentenceCase() {
    return isEmpty ? '' : this[0].toUpperCase() + substring(1);
  }
}
