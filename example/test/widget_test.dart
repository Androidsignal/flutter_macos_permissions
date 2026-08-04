import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_macos_permissions_example/main.dart';

void main() {
  testWidgets('renders a permission card for every supported permission', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Idle'), findsOneWidget);
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Microphone'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(find.text('Screen & system audio recording'), findsOneWidget);
    expect(find.text('Full Disk Access'), findsOneWidget);
    expect(find.text('Bluetooth'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Request Permission'), findsNWidgets(8));
    expect(find.text('Check Status'), findsNWidgets(8));
  });
}
