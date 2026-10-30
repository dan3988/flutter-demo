import 'dart:async';

import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:flutter_demo/api/client.dart';
import 'package:flutter_demo/app/list_widget.dart';
import 'package:flutter_demo/l10n/text.dart';

void main() {
  group('WebListWidget Tests', () {
    late PlaceholderApi mockApi;

    setUp(() {
      mockApi = PlaceholderApi(baseUrl: Uri.parse('https://example.com'));
    });

    tearDown(() {
      mockApi.dispose();
    });

    Widget createTestWidget({
      required ListGetter<String> retrieveData,
      required void Function(dynamic error, StackTrace stackTrace) onError,
      ItemFilter<String>? filter,
    }) {
      return Provider<PlaceholderApi>.value(
        value: mockApi,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: WebListWidget<String>(
              itemBuilder: (context, item) => Text(item),
              retrieveData: retrieveData,
              onError: onError,
              filter: filter,
            ),
          ),
        ),
      );
    }

    testWidgets('Shows CircularProgressIndicator while loading and renders items on success', (
      WidgetTester tester,
    ) async {
      final completer = Completer<Response<List<String>>>();

      await tester.pumpWidget(
        createTestWidget(
          retrieveData: (api, abort) => completer.future,
          onError: (_, __) {},
        ),
      );

      // Verify loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Resolve data
      completer.complete(
        Response<List<String>>(
          http.Response('', 200),
          ['Apple', 'Banana', 'Cherry'],
        ),
      );

      await tester.pumpAndSettle();

      // Verify items are displayed
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsOneWidget);
    });

    testWidgets('Filters items when search text is entered', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(
          retrieveData: (api, abort) async {
            return Response<List<String>>(
              http.Response('', 200),
              ['Apple', 'Banana', 'Apricot'],
            );
          },
          onError: (_, __) {},
          filter: (item, search) => item.toLowerCase().contains(search),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Apricot'), findsOneWidget);

      // Enter search text
      await tester.enterText(find.byType(TextField), 'ap');
      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Apricot'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
    });

    testWidgets('Shows error widget when retrieveData fails', (
      WidgetTester tester,
    ) async {
      dynamic caughtError;

      await tester.pumpWidget(
        createTestWidget(
          retrieveData: (api, abort) async {
            throw Exception('Network failure');
          },
          onError: (error, stackTrace) {
            caughtError = error;
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(caughtError, isNotNull);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
