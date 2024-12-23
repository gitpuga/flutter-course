import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_3_5/main.dart';

void main() {
  testWidgets('Camera catalog page displays correctly',
      (WidgetTester tester) async {
    // Запускаем приложение
    await tester.pumpWidget(const CameraCatalogApp());

    // Ищем наличие текста "Camera Catalog"
    expect(find.text('Camera Catalog'), findsOneWidget);

    // Ищем наличие хотя бы одной карточки товара (ListTile)
    expect(find.byType(ListTile), findsWidgets);
  });
}
