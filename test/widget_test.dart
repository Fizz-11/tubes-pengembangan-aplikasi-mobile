// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:aplikasiku/core/app_state.dart';
import 'package:aplikasiku/core/models.dart';
import 'package:aplikasiku/main.dart';

void main() {
  testWidgets('app starts and shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const GymkuApp(),
      ),
    );

    expect(find.text('GYMKU'), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('forgot password button explains reset availability', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const GymkuApp(),
      ),
    );

    await tester.tap(find.text('Lupa Password?'));
    await tester.pumpAndSettle();

    expect(find.text('Reset password'), findsOneWidget);
    expect(find.text('Mengerti'), findsOneWidget);
  });

  test('freeze and unfreeze only change membership after admin approval', () {
    final app = AppState();
    expect(app.login('Naufal Badu', 'Gymku123'), isNull);
    final member = app.currentUser!;

    expect(app.requestFreezeMembership(today(), 7, 'Bepergian'), isNull);
    final freezeRequest = app.pendingFreezeRequest!;
    expect(freezeRequest.type, FreezeRequestType.freeze);
    expect(app.membership!.currentFreeze, isNull);
    expect(
      app.decideFreezeRequest(freezeRequest.id, true),
      'Hanya admin yang dapat memproses permintaan',
    );

    app.logout();
    expect(app.login('admin', 'admin123'), isNull);
    expect(app.decideFreezeRequest(freezeRequest.id, true), isNull);
    expect(app.statusOf(member), MemberStatus.frozen);

    app.logout();
    expect(app.login('Naufal Badu', 'Gymku123'), isNull);
    expect(app.requestUnfreezeMembership(), isNull);
    final unfreezeRequest = app.pendingFreezeRequest!;
    expect(unfreezeRequest.type, FreezeRequestType.unfreeze);
    expect(app.membership!.isFrozen, isTrue);

    app.logout();
    expect(app.login('admin', 'admin123'), isNull);
    expect(app.decideFreezeRequest(unfreezeRequest.id, true), isNull);

    app.logout();
    expect(app.login('Naufal Badu', 'Gymku123'), isNull);
    expect(app.membership!.currentFreeze, isNull);

    expect(app.requestFreezeMembership(today(), 7, 'Urusan pribadi'), isNull);
    final rejectedRequest = app.pendingFreezeRequest!;
    app.logout();
    expect(app.login('admin', 'admin123'), isNull);
    expect(app.decideFreezeRequest(rejectedRequest.id, false), isNull);

    app.logout();
    expect(app.login('Naufal Badu', 'Gymku123'), isNull);
    expect(app.membership!.currentFreeze, isNull);
    expect(rejectedRequest.status, 'Ditolak');
  });
}
