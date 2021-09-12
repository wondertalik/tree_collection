part of vi.collection;

typedef TraversalCall<K, V> = bool Function(ViNode<K, V> node);

abstract class ViTraversal<K, V> {
  ViTraversal({this.direction = TraversalDirection.leftToRight});

  final TraversalDirection direction;

  traverse(ViNode<K, V> startNode, {required TraversalCall<K, V> callback});
}

enum TraversalDirection { leftToRight, rightToLeft }

class ViTraversalBfs<K, V> extends ViTraversal<K, V> {
  ViTraversalBfs({
    TraversalDirection direction = TraversalDirection.leftToRight,
  }) : super(direction: direction);

  @override
  traverse(ViNode<K, V> startNode, {required TraversalCall<K, V> callback}) {
    var queue = ListQueue<ViNode<K, V>>();
    queue.add(startNode);
    do {
      var currentNode = queue.removeFirst();

      final nodeChildren = direction == TraversalDirection.leftToRight
          ? currentNode.children.reversed
          : currentNode.children;
      for (final child in nodeChildren) {
        queue.add(child);
      }
      final result = callback(currentNode);
      if (!result) break;
    } while (queue.isNotEmpty);
  }
}

class ViTraversalDfsIterativePreOrder<K, V> extends ViTraversal<K, V> {
  ViTraversalDfsIterativePreOrder({
    TraversalDirection direction = TraversalDirection.leftToRight,
  }) : super(direction: direction);

  @override
  traverse(ViNode<K, V> startNode, {required TraversalCall<K, V> callback}) {
    var stack = <ViNode<K, V>>[];
    stack.add(startNode);
    do {
      var currentNode = stack.removeLast();
      final result = callback(currentNode);
      if (!result) break;

      final nodeChildren = direction == TraversalDirection.leftToRight
          ? currentNode.children.reversed
          : currentNode.children;
      for (final child in nodeChildren) {
        stack.add(child);
      }
    } while (stack.isNotEmpty);
  }
}
