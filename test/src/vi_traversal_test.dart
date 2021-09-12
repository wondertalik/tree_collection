import 'package:test/test.dart';
import 'package:vi_collection/vi_collection.dart';

void main() {
  late ViNode<int, dynamic> tRootNode;

  setUp(() {
    tRootNode = ViNode(key: 8)
      ..children.addAll([
        ViNode(key: 3)
          ..children.addAll([
            ViNode(key: 1),
            ViNode(key: 6)
              ..children.add(ViNode(key: 4))
              ..children.add(ViNode(key: 7))
          ]),
        ViNode(key: 10)
          ..children.add(
            ViNode(key: 14)..children.add(ViNode(key: 13)),
          )
      ]);
  });

  group('ViTraversalBfs', () {
    test('Check order traversal Left to Right', () async {
      // arrange
      final tree = ViOrderedTree.fromNode(tRootNode,
          traversal: ViTraversalBfs<int, dynamic>());

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
      final tree = ViOrderedTree.fromNode(tRootNode,
          traversal: ViTraversalBfs<int, dynamic>(
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

  group('ViTraversalDfsIterativePreOrder', () {
    test('Check order traversal Left to Right', () async {
      // arrange
      final tree = ViOrderedTree.fromNode(tRootNode,
          traversal: ViTraversalDfsIterativePreOrder<int, dynamic>());

      // act
      final result = tree.traverseFromNodeByKey(tree.root!.key);

      // assert
      expect(result.map((x) => x.key).toList(), [8, 3, 1, 6, 4, 7, 10, 14, 13]);
    });

    test('Check order traversal Right to Left', () async {
      // arrange
      final tree = ViOrderedTree.fromNode(tRootNode,
          traversal: ViTraversalDfsIterativePreOrder<int, dynamic>(
            direction: TraversalDirection.rightToLeft,
          ));

      // act
      final result = tree.traverseFromNodeByKey(tree.root!.key);

      // assert
      expect(result.map((x) => x.key).toList(), [8, 10, 14, 13, 3, 6, 7, 4, 1]);
    });
  });
}
