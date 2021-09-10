part of vi.collection;

class ViNode<K, V> {
  ViNode({required this.key, this.data}) : children = [];

  final K key;
  V? data;
  List<ViNode<K, V>> children;
}
