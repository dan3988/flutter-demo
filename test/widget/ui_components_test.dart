import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_demo/api/client.dart';
import 'package:flutter_demo/app/author_tile.dart';
import 'package:flutter_demo/app/item_tile.dart';
import 'package:flutter_demo/app/list_widget.dart';
import 'package:flutter_demo/l10n/text.dart';

void main() {
  group('UI Components Widget Tests', () {
    testWidgets('ItemTile displays title, subtitle, and responds to tap', (
      WidgetTester tester,
    ) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ItemTile(
              title: const Text('Tile Title'),
              subtitle: const Text('Tile Subtitle'),
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Tile Title'), findsOneWidget);
      expect(find.text('Tile Subtitle'), findsOneWidget);

      await tester.tap(find.byType(ItemTile));
      expect(tapped, isTrue);
    });

    testWidgets('AuthorTile displays author information', (
      WidgetTester tester,
    ) async {
      final user = User(
        id: 1,
        name: 'Jane Doe',
        username: 'janedoe',
        email: 'jane@example.com',
        phone: '123-456-7890',
        website: 'example.com',
        address: Address(
          street: '123 Main St',
          suite: 'Apt 1',
          city: 'Metropolis',
          zipcode: '12345',
          geo: Geo(lat: '0', lng: '0'),
        ),
        company: Company(
          name: 'Acme Corp',
          catchPhrase: 'Innovating tomorrow',
          bs: 'synergize leverage',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: AuthorTile(author: user),
          ),
        ),
      );

      expect(find.text('By Jane Doe (janedoe)'), findsOneWidget);
    });

    testWidgets('ListWidget renders items correctly', (
      WidgetTester tester,
    ) async {
      final items = ['Apple', 'Banana', 'Cherry'];

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ListWidget<String>(
              items: items,
              itemBuilder: (context, item) => Text(item),
            ),
          ),
        ),
      );

      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsOneWidget);
    });
  });
}
