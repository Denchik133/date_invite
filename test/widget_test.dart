import 'package:flutter_test/flutter_test.dart';
import 'package:date_invite/main.dart';

void main() {
  testWidgets('App starts smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DateInviteApp());
    expect(find.byType(DateInviteApp), findsOneWidget);
  });
}
