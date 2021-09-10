import 'dart:collection';

import 'vi_node.dart';

class ViTree<K, V> {
  ViTree({required K key, V? data})
      : root = ViNode(key: key, data: data),
        keys = <K>{key};

  ViTree.fromNode(ViNode<K, V> node)
      : root = node,
        keys = <K>{} {
    traverseBFS((node) {
      keys.add(node.key);
      return true;
    });
  }

  final ViNode<K, V> root;
  Set<K> keys;

  bool add({required K toKey, required K key, V? data}) {
    if (keys.contains(key)) return false;

    final parent = find(toKey);
    if (parent != null) {
      final child = ViNode(key: key, data: data);
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
    traverseBFS((node) {
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
    traverseBFS((node) {
      final index = node.children.indexWhere((element) => element.key == key);
      if (index != -1) {
        parent = node;
        return false;
      }
      return true;
    });
    return parent;
  }

  void traverseBFS(bool Function(ViNode<K, V> node) callback) {
    var queue = ListQueue<ViNode<K, V>>();
    queue.add(root);
    var currentNode = queue.removeFirst();
    do {
      for (final child in currentNode.children) {
        queue.add(child);
      }
      final result = callback(currentNode);
      if (result) {
        currentNode = queue.removeFirst();
      } else {
        break;
      }
    } while (queue.isNotEmpty);
  }
}
