part of tree.collection;

class Node<K, V> {
  Node({required this.key, this.data}) : children = [];

  final K key;
  V? data;
  final List<Node<K, V>> children;

  bool get hasChildren => children.isNotEmpty;
}
