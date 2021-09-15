part of tree.collection;

class Node<K, V> extends Equatable {
  Node({required this.key, this.data}) : children = [];

  final K key;
  final V? data;
  final List<Node<K, V>> children;

  bool get hasChildren => children.isNotEmpty;

  Node<K, V> copyWith({K? key, V? data, List<Node<K, V>>? children}) {
    final node = Node(key: key ?? this.key, data: data ?? this.data);
    if (children != null) {
      node.children.addAll(children);
    } else {
      node.children.addAll(this.children);
    }
    return node;
  }

  @override
  List<Object?> get props => [key, data, children];
}
