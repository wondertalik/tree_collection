part of tree.collection;

class OrderedTree<K, V> {
  OrderedTree({required K key, required this.traversal, V? data})
      : _root = Node<K, V>(key: key, data: data),
        _keys = <K>{key};

  OrderedTree.fromNode(Node<K, V> node, {required this.traversal})
      : _keys = <K>{} {
    setRoot(node);
  }

  Node<K, V>? _root;
  final Set<K> _keys;
  Traversal<K, V> traversal;

  Node<K, V>? get root => _root;
  Set<K> get keys => _keys;

  void setRoot(Node<K, V> node) {
    _root = node;
    _fillKeys();
  }

  void setTraversal(Traversal<K, V> traversal) {
    this.traversal = traversal;
  }

  void add({
    required K toKey,
    required K key,
    V? data,
    Comparator<Node<K, V>>? comparator,
  }) {
    if (_root == null) throw OrderedTreeError.noRootNode();

    if (_keys.contains(key)) throw OrderedTreeError.keyAlreadyExists<K>(key);

    final parent = find(toKey);
    if (parent == null) throw OrderedTreeError.noElement();

    final child = Node<K, V>(key: key, data: data);
    parent.children.add(child);
    if (comparator != null) parent.children.sort(comparator);
    _keys.add(key);
  }

  bool removeByKey(K key) {
    if (_root == null) throw OrderedTreeError.noRootNode();

    final parentNode = findParent(key);
    if (parentNode != null) {
      parentNode.children.removeWhere((element) => element.key == key);
      _keys.remove(key);
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

  void traverseFromNode({
    required K key,
    required TraversalCall<K, V> callback,
    Traversal<K, V>? traversal,
  }) {
    if (_root == null) throw OrderedTreeError.noRootNode();

    final startNode = find(key);
    if (startNode == null) throw OrderedTreeError.noElement();

    final finalTraversal = traversal ?? this.traversal;
    finalTraversal.traverse(startNode, callback: callback);
  }

  void _fillKeys() {
    traversal.traverse(_root!, callback: (node) {
      _keys.add(node.key);
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
