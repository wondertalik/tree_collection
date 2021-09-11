part of vi.collection;

class ViNode<K, V> {
  ViNode({required this.key, this.data}) : children = [];

  final K key;
  V? data;
  final List<ViNode<K, V>> children;

  bool get hasChildren => children.isNotEmpty;
}
