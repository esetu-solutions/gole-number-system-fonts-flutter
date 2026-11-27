import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gole_number_system_fonts/gole_number_system_fonts.dart';

void main() {
  final pubspec = File('pubspec.yaml').readAsStringSync();

  test('the constants match pubspec.yaml', () {
    expect(pubspec, contains('name: $goleFontPackage\n'));
    expect(pubspec, contains('family: $goleFontFamily\n'));
    expect(pubspec, contains('family: $goleFontFamilyPua\n'));
  });

  test('the PUA range holds 100 symbols', () {
    expect(golePuaFirstCodePoint, 0xE441);
    expect(golePuaLastCodePoint - golePuaFirstCodePoint + 1, 100);
  });

  test('both declared font files exist and are TrueType fonts', () {
    final assets = RegExp(r'asset: (\S+)').allMatches(pubspec).map((m) => m[1]!).toList();
    expect(assets, ['fonts/GoleStandard.ttf', 'fonts/GoleStandard_PUA.ttf']);
    for (final asset in assets) {
      final bytes = File(asset).readAsBytesSync();
      expect(bytes.sublist(0, 4), [0, 1, 0, 0], reason: asset);
    }
  });

  testWidgets('a pair of digits takes the width of one symbol', (tester) async {
    Future<void> load(String family, String file) async {
      final loader = FontLoader(family)
        ..addFont(Future.value(ByteData.sublistView(File(file).readAsBytesSync())));
      await loader.load();
    }

    await load(goleFontFamily, 'fonts/GoleStandard.ttf');
    await load(goleFontFamilyPua, 'fonts/GoleStandard_PUA.ttf');

    double width(String text, String family) {
      final painter = TextPainter(
        text: TextSpan(text: text, style: TextStyle(fontFamily: family, fontSize: 40)),
        textDirection: TextDirection.ltr,
      )..layout();
      return painter.width;
    }

    final ligature = width('0123', goleFontFamily);
    final pua = width(String.fromCharCodes([golePuaFirstCodePoint + 1, golePuaFirstCodePoint + 23]), goleFontFamilyPua);
    expect(ligature, greaterThan(0));
    // Two symbols in each build: the Ligature build joined the four digits into two glyphs.
    expect(ligature, closeTo(pua, 0.5));
  });
}
