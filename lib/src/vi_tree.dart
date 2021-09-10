part of vi.collection;

class ViOrderedTree<K, V> {
  ViOrderedTree({required K key, required this.traversal, V? data})
      : root = ViNode<K, V>(key: key, data: data),
        keys = <K>{key};

  ViOrderedTree.fromNode(ViNode<K, V> node, {required this.traversal})
      : root = node,
        keys = <K>{} {
    traversal.traverse(root, callback: (node) {
      keys.add(node.key);
      return true;
    });
  }

  final ViNode<K, V> root;
  Set<K> keys;
  ViTraversal<K, V> traversal;

  bool add({required K toKey, required K key, V? data}) {
    if (keys.contains(key)) return false;

    final parent = find(toKey);
    if (parent != null) {
      final child = ViNode<K, V>(key: key, data: data);
      parent.children.add(child);
      keys.add(key);
      return true;
    }
    return false;
  }

  bool remove(K key) {
    final parentNode = findParent(key);
    if (parentNode != null) {
      parentNode.children.removeWhere((element) => element.key == key);
      keys.remove(key);
      return true;
    }
    return false;
  }

  ViNode<K, V>? find(K key) {
    ViNode<K, V>? element;
    traversal.traverse(root, callback: (node) {
      if (node.key == key) {
        element = node;
        return false;
      }
      return true;
    });
    return element;
  }

  ViNode<K, V>? findParent(K key) {
    ViNode<K, V>? parent;
    traversal.traverse(root, callback: (node) {
      final index = node.children.indexWhere((element) => element.key == key);
      if (index != -1) {
        parent = node;
        return false;
      }
      return true;
    });
    return parent;
  }
}
