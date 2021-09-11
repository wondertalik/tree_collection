part of vi.collection;

class ViOrderedTree<K, V> {
  ViOrderedTree({required K key, required this.traversal, V? data})
      : _root = ViNode<K, V>(key: key, data: data),
        keys = <K>{key};

  ViOrderedTree.fromNode(ViNode<K, V> node, {required this.traversal})
      : keys = <K>{} {
    setRoot(node);
  }

  ViNode<K, V>? _root;
  Set<K> keys;
  ViTraversal<K, V> traversal;

  ViNode<K, V>? get root => _root;

  void setRoot(ViNode<K, V> node) {
    _root = node;
    _fillKeys();
  }

  void add({required K toKey, required K key, V? data}) {
    if (_root == null) throw ViOrderedTreeError.noRootNode();

    if (keys.contains(key)) throw ViOrderedTreeError.keyAlreadyExists<K>(key);

    final parent = find(toKey);
    if (parent == null) throw ViOrderedTreeError.noElement();

    final child = ViNode<K, V>(key: key, data: data);
    parent.children.add(child);
    keys.add(key);
  }

  bool removeByKey(K key) {
    if (_root == null) throw ViOrderedTreeError.noRootNode();

    final parentNode = findParent(key);
    if (parentNode != null) {
      parentNode.children.removeWhere((element) => element.key == key);
      keys.remove(key);
      return true;
    } else {
      final rootNode = find(key);
      if (rootNode != null) {
        _root = null;
        return true;
      }
    }
    return false;
  }

  ViNode<K, V>? find(K key) {
    if (_root == null) throw ViOrderedTreeError.noRootNode();

    ViNode<K, V>? element;
    traversal.traverse(_root!, callback: (node) {
      if (node.key == key) {
        element = node;
        return false;
      }
      return true;
    });
    return element;
  }

  ViNode<K, V>? findParent(K key) {
    if (_root == null) throw ViOrderedTreeError.noRootNode();

    ViNode<K, V>? parent;
    traversal.traverse(_root!, callback: (node) {
      final index = node.children.indexWhere((element) => element.key == key);
      if (index != -1) {
        parent = node;
        return false;
      }
      return true;
    });
    return parent;
  }

  Iterable<ViNode<K, V>> traverseFromNodeByKey(K startKey) {
    if (_root == null) throw ViOrderedTreeError.noRootNode();

    final items = <ViNode<K, V>>[];

    final startNode = find(startKey);

    if (startNode != null) {
      traversal.traverse(startNode, callback: (node) {
        items.add(node);
        return true;
      });
    }

    return items;
  }

  void _fillKeys() {
    traversal.traverse(_root!, callback: (node) {
      keys.add(node.key);
      return true;
    });
  }
}

abstract class ViOrderedTreeError {
  static StateError noElement() => StateError("No element");
  static StateError noRootNode() => StateError("Root node is null");
  static StateError keyAlreadyExists<E>(E key) =>
      StateError("Key '$key' already exists");
}
