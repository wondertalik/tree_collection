import 'package:test/test.dart';
import 'package:tree_collection/tree_collection.dart';

void main() {
  late Node<int, dynamic> tRootNode;

  setUp(() {
    tRootNode = Node(key: 8)
      ..children.addAll([
        Node(key: 3)
          ..children.addAll([
            Node(key: 1),
            Node(key: 6)
              ..children.add(Node(key: 4))
              ..children.add(Node(key: 7))
          ]),
        Node(key: 10)
          ..children.add(
            Node(key: 14)..children.add(Node(key: 13)),
          )
      ]);
  });

  group('TraversalBfs', () {
    test('Check order traversal Left to Right', () async {
      // arrange
      final tree = OrderedTree.fromNode(tRootNode,
          traversal: TraversalBfs<int, dynamic>());

      // act
      final result = tree.traverseFromNodeByKey(tree.root!.key);

      // assert
      expect(
        result.map((x) => x.key).toList(),
        [8, 10, 3, 14, 6, 1, 13, 7, 4],
      );
    });

    test('Check order traversal Right to Left', () async {
      // arrange
      final tree = OrderedTree.fromNode(tRootNode,
          traversal: TraversalBfs<int, dynamic>(
            direction: TraversalDirection.rightToLeft,
          ));

      // act
      final result = tree.traverseFromNodeByKey(tree.root!.key);

      // assert
      expect(
        result.map((x) => x.key).toList(),
        [8, 3, 10, 1, 6, 14, 4, 7, 13],
      );
    });
  });

  group('TraversalDfsIterativePreOrder', () {
    test('Check order traversal Left to Right', () async {
      // arrange
      final tree = OrderedTree.fromNode(tRootNode,
          traversal: TraversalDfsIterativePreOrder<int, dynamic>());

      // act
      final result = tree.traverseFromNodeByKey(tree.root!.key);

      // assert
      expect(result.map((x) => x.key).toList(), [8, 3, 1, 6, 4, 7, 10, 14, 13]);
    });

    test('Check order traversal Right to Left', () async {
      // arrange
      final tree = OrderedTree.fromNode(tRootNode,
          traversal: TraversalDfsIterativePreOrder<int, dynamic>(
            direction: TraversalDirection.rightToLeft,
          ));

      // act
      final result = tree.traverseFromNodeByKey(tree.root!.key);

      // assert
      expect(result.map((x) => x.key).toList(), [8, 10, 14, 13, 3, 6, 7, 4, 1]);
    });
  });

  group('TraversalDfsIterativePostOrder', () {
    test('Check order traversal Left to Right', () async {
      // arrange
      final tree = OrderedTree.fromNode(tRootNode,
          traversal: TraversalDfsIterativePostOrder<int, dynamic>());

      // act
      final result = tree.traverseFromNodeByKey(tree.root!.key);

      // assert
      expect(result.map((x) => x.key).toList(), [1, 4, 7, 6, 3, 13, 14, 10, 8]);
    });

    test('Check order traversal Right to Left', () async {
      // arrange
      final tree = OrderedTree.fromNode(tRootNode,
          traversal: TraversalDfsIterativePostOrder<int, dynamic>(
            direction: TraversalDirection.rightToLeft,
          ));

      // act
      final result = tree.traverseFromNodeByKey(tree.root!.key);

      // assert
      expect(result.map((x) => x.key).toList(), [13, 14, 10, 7, 4, 6, 1, 3, 8]);
    });
  });
}
