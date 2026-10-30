import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:axcend/ui/fading_edge_scroll_view.dart';

const rainbow = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.lime,
  Colors.green,
  Colors.teal,
  Colors.cyan,
  Colors.blue,
  Colors.purple,
  Colors.pink,
];

Color getColor(int index) => rainbow[index % rainbow.length];

void main() {
  testWidgets('FadingScrollOverlay standard', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, _) {
          return FadingEdgeScrollView(
            gradientColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i <= 1000; i++)
                  ColoredBox(
                    key: ValueKey(i),
                    color: getColor(i),
                    child: Text('Row $i', style: Theme.of(context).textTheme.labelMedium),
                  ),
              ],
            ),
          );
        },
      ),
    );

    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('standard-start.png'));
    await tester.scrollUntilVisible(find.byKey(const ValueKey(499)), 500, scrollable: find.byType(Scrollable));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('standard-mid.png'));
    await tester.scrollUntilVisible(find.byKey(const ValueKey(999)), 500, scrollable: find.byType(Scrollable));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('standard-end.png'));
  });

  testWidgets('FadingScrollOverlay builder', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, _) {
          return FadingEdgeScrollView.builder(
            gradientColor: Colors.white,
            builder: (context, controller) {
              return ListView.builder(
                controller: controller,
                itemCount: 1000,
                itemBuilder: (context, i) {
                  return ColoredBox(
                    key: ValueKey(i),
                    color: rainbow[i % rainbow.length],
                    child: Text('Row $i', style: Theme.of(context).textTheme.labelMedium),
                  );
                },
              );
            },
          );
        },
      ),
    );

    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('builder-start.png'));
    await tester.scrollUntilVisible(find.byKey(const ValueKey(499)), 500, scrollable: find.byType(Scrollable));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('builder-mid.png'));
    await tester.scrollUntilVisible(find.byKey(const ValueKey(999)), 500, scrollable: find.byType(Scrollable));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('builder-end.png'));
  });

  testWidgets('FadingScrollOverlay vertical', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, _) {
          return FadingEdgeScrollView.builder(
            gradientColor: Colors.white,
            scrollDirection: Axis.horizontal,
            builder: (context, controller) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: controller,
                itemCount: 1000,
                itemBuilder: (context, i) {
                  return Container(
                    key: ValueKey(i),
                    color: rainbow[i % rainbow.length],
                    width: 50,
                  );
                },
              );
            },
          );
        },
      ),
    );

    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('vertical-start.png'));
    await tester.scrollUntilVisible(find.byKey(const ValueKey(499)), 500, scrollable: find.byType(Scrollable));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('vertical-mid.png'));
    await tester.scrollUntilVisible(find.byKey(const ValueKey(999)), 500, scrollable: find.byType(Scrollable));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('vertical-end.png'));
  });

  testWidgets('FadingScrollOverlay padded', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, _) {
          return FadingEdgeScrollView(
            gradientColor: Colors.white,
            padding: const EdgeInsets.all(20),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i <= 1000; i++)
                  ColoredBox(
                    key: ValueKey(i),
                    color: rainbow[i % rainbow.length],
                    child: Text('Row $i', style: Theme.of(context).textTheme.labelMedium),
                  ),
              ],
            ),
          );
        },
      ),
    );

    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('padded-start.png'));
    await tester.scrollUntilVisible(find.byKey(const ValueKey(499)), 500, scrollable: find.byType(Scrollable));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('padded-mid.png'));
    await tester.scrollUntilVisible(find.byKey(const ValueKey(999)), 500, scrollable: find.byType(Scrollable));
    await tester.pump();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('padded-end.png'));
  });
}
