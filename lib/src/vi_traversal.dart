part of vi.collection;

typedef TraversalCall<K, V> = bool Function(ViNode<K, V> node);

abstract class ViTraversal<K, V> {
  traverse(ViNode<K, V> startNode, {required TraversalCall<K, V> callback});
}

class ViTraversalBfs<K, V> extends ViTraversal<K, V> {
  @override
  traverse(ViNode<K, V> startNode, {required TraversalCall<K, V> callback}) {
    var queue = ListQueue<ViNode<K, V>>();
    queue.add(startNode);
    do {
      var currentNode = queue.removeFirst();
      for (final child in currentNode.children) {
        queue.add(child);
      }
      final result = callback(currentNode);
      if (!result) break;
    } while (queue.isNotEmpty);
  }
}
