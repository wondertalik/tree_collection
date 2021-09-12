part of tree.collection;

class OrderedTree<K, V> {
  OrderedTree({required K key, required this.traversal, V? data})
      : _root = Node<K, V>(key: key, data: data),
        keys = <K>{key};

  OrderedTree.fromNode(Node<K, V> node, {required this.traversal})
      : keys = <K>{} {
    setRoot(node);
  }

  Node<K, V>? _root;
  Set<K> keys;
  Traversal<K, V> traversal;

  Node<K, V>? get root => _root;

  void setRoot(Node<K, V> node) {
    _root = node;
    _fillKeys();
  }

  void setTraversal(Traversal<K, V> traversal) {
    this.traversal = traversal;
  }

  void add({required K toKey, required K key, V? data}) {
    if (_root == null) throw OrderedTreeError.noRootNode();

    if (keys.contains(key)) throw OrderedTreeError.keyAlreadyExists<K>(key);

    final parent = find(toKey);
    if (parent == null) throw OrderedTreeError.noElement();

    final child = Node<K, V>(key: key, data: data);
    parent.children.add(child);
    keys.add(key);
  }

  bool removeByKey(K key) {
    if (_root == null) throw OrderedTreeError.noRootNode();

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

  Node<K, V>? find(K key) {
    if (_root == null) throw OrderedTreeError.noRootNode();

    Node<K, V>? element;
    traversal.traverse(_root!, callback: (node) {
      if (node.key == key) {
        element = node;
        return false;
      }
      return true;
    });
    return element;
  }

  Node<K, V>? findParent(K key) {
    if (_root == null) throw OrderedTreeError.noRootNode();

    Node<K, V>? parent;
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

  Iterable<Node<K, V>> traverseFromNodeByKey(K startKey) {
    if (_root == null) throw OrderedTreeError.noRootNode();

    final startNode = find(startKey);
    if (startNode == null) throw OrderedTreeError.noElement();

    final items = <Node<K, V>>[];
    traversal.traverse(startNode, callback: (node) {
      items.add(node);
      print(node.key);
      return true;
    });

    return items;
  }

  void _fillKeys() {
    traversal.traverse(_root!, callback: (node) {
      keys.add(node.key);
      return true;
    });
  }
}

abstract class OrderedTreeError {
  static StateError noElement() => StateError("No element");
  static StateError noRootNode() => StateError("Root node is null");
  static StateError keyAlreadyExists<E>(E key) =>
      StateError("Key '$key' already exists");
}
