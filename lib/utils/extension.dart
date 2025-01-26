
extension Capitalize on String {
  String capitalize() {
    if (isEmpty) return this; // Return the string as-is if empty
    return replaceFirst(this[0], this[0].toUpperCase());
  }
}
