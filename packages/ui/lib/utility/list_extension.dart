extension ListExtension<T> on List<T> {
  Iterable<V> mapIndexed<V>(V Function(T item, int index) toElement) sync* {
    for (var i = 0; i < length; i++) {
      yield toElement(elementAt(i), i);
    }
  }
}
