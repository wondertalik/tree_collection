import 'package:flutter_test/flutter_test.dart';
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

  group('OrderedTree', () {
    group('find elements in tree', () {
      test('should return node with key 7', () {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.find(7);

        // assert
        expect(result, isNotNull);
      });

      test('should return null', () {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.find(15);

        // assert
        expect(result, isNull);
      });

      group('find parent in tree', () {
        test('parent of 14 is 10', () async {
          // arrange
          final tree = ViOrderedTree.fromNode(tRootNode,
              traversal: ViTraversalBfs<int, dynamic>());

          // act
          final result = tree.findParent(14);

          // assert
          expect(result, isNotNull);
          expect(result!.key, 10);
        });

        test('parent of 13 is 14', () async {
          // arrange
          final tree = ViOrderedTree.fromNode(tRootNode,
              traversal: ViTraversalBfs<int, dynamic>());

          // act
          final result = tree.findParent(13);

          // assert
          expect(result, isNotNull);
          expect(result!.key, 14);
        });

        test('parent not found', () async {
          // arrange
          final tree = ViOrderedTree.fromNode(tRootNode,
              traversal: ViTraversalBfs<int, dynamic>());

          // act
          final result = tree.findParent(20);

          // assert
          expect(result, isNull);
        });
      });
    });

    group('add elements to tree', () {
      test('Add element to tree was success', () async {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.add(toKey: 1, key: 20);

        // assert
        expect(result, true);
      });

      test('Error. No parent to add element to tree', () async {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.add(toKey: 5, key: 20);

        // assert
        expect(result, false);
      });

      test('Error. Key already exist cant add new element', () async {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.add(toKey: 1, key: 3);

        // assert
        expect(result, false);
      });
    });
  });
}
