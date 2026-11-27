# gole_number_system_fonts

The **GoleStandard** fonts for Flutter. They draw the symbols of the Gole Number System, which is base 100: one symbol for each value from 0 to 99, so every symbol stands for a pair of decimal digits.

> **Licence:** this package is not open source. The fonts are licensed by eSetu Solutions Pvt Ltd under the [Gole Number System Community Licence v1.0](LICENSE). Free to use with attribution; conditions apply. See [Licence](#licence).

This package holds only the two font files and a few constants. To turn a number into the text the font needs, use [`gole_core`](https://pub.dev/packages/gole_core); for ready-made widgets, use [`flutter_gole`](https://pub.dev/packages/flutter_gole).

## Install

```sh
flutter pub add gole_number_system_fonts
```

The fonts are declared in this package's `pubspec.yaml`; you do not add them to your own.

## Use

```dart
import 'package:flutter/widgets.dart';
import 'package:gole_number_system_fonts/gole_number_system_fonts.dart';

const Text(
  '0123', // two symbols: 01 and 23
  style: TextStyle(fontFamily: goleFontFamily, package: goleFontPackage),
);
```

Always pass `package: goleFontPackage`. Without it Flutter looks for the family in your own app and falls back to the default font.

## The two builds

| | Ligature | PUA |
| --- | --- | --- |
| Family | `goleFontFamily` (`GoleStandard`) | `goleFontFamilyPua` (`GoleStandardPUA`) |
| Text you write | Decimal digits, an even number of them: `'0123'` | One private-use character per pair: U+E441 + n |
| How a pair becomes a symbol | The font's ligatures join each pair of digits | Each character is a symbol already |
| Copy, search, screen readers | Keep working, because the text is still digits | See private-use characters; give a `Semantics` label |
| Letter spacing | Must not be applied; it stops the pairs joining | Works |

Use the Ligature build unless you need letter spacing or a text engine without ligature support.

```dart
// PUA build: the symbols for 01 and 23
Text(
  String.fromCharCodes([golePuaFirstCodePoint + 1, golePuaFirstCodePoint + 23]),
  style: const TextStyle(fontFamily: goleFontFamilyPua, package: goleFontPackage),
);
```

### Writing rules

The fonts contain only the digits 0 to 9 and the Gole symbols. Prepare the text before you show it:

| Rule | Example |
| --- | --- |
| A whole part with an odd number of digits gets a `0` on the left | `123` → `0123` |
| A fraction with an odd number of digits gets a `0` on the right | `12.5` → `12.50` |
| Apply the Gole font to the digits only; signs, the decimal point, units and letters keep your app's font | `-04.50 °C` |

`gole_core` and `flutter_gole` do this for you.

## Constants

| Constant | Value | Use |
| --- | --- | --- |
| `goleFontPackage` | `'gole_number_system_fonts'` | `TextStyle(package: ...)` |
| `goleFontFamily` | `'GoleStandard'` | Ligature build |
| `goleFontFamilyPua` | `'GoleStandardPUA'` | PUA build |
| `golePuaFirstCodePoint` | `0xE441` | The symbol for 00 in the PUA build |
| `golePuaLastCodePoint` | `0xE4A4` | The symbol for 99 in the PUA build |

## Example

The [example](example) app shows all 100 symbols in a grid, in either build.

## Licence

The fonts, the Gole Number System and the related patent rights are licensed by eSetu Solutions Pvt Ltd under the **Gole Number System Community Licence v1.0**. The full text is in [LICENSE](LICENSE) and at <https://www.esetu.in/gole-number-system/licence>. In short:

- **Non-commercial use** (personal, teaching, research, evaluation) is free.
- **Commercial use** is free while your organisation's annual turnover is below ₹10 crore. At or above that, and for government and public-sector use, you need a written commercial licence from eSetu first.
- **Attribution:** credit Gole numbers as `Gole Number System™ by eSetu Solutions Pvt. Ltd. – https://esetu.in`.
- **No changes:** you may redistribute the fonts only unmodified, with the licence.
- The licence includes a limited patent licence (Indian Patent Application No. 202441034973) and no trademark licence.

This summary does not replace the licence. For a commercial licence, write to [legal@esetu.in](mailto:legal@esetu.in).

Gole Number System and eSetu are trademarks of eSetu Solutions Pvt Ltd.
