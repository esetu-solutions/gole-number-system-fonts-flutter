import 'package:flutter/material.dart';
import 'package:gole_number_system_fonts/gole_number_system_fonts.dart';

void main() => runApp(const SymbolsApp());

/// Shows the 100 Gole symbols, in either font build.
class SymbolsApp extends StatelessWidget {
  const SymbolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gole symbols',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const SymbolsPage(),
    );
  }
}

class SymbolsPage extends StatefulWidget {
  const SymbolsPage({super.key});

  @override
  State<SymbolsPage> createState() => _SymbolsPageState();
}

class _SymbolsPageState extends State<SymbolsPage> {
  bool _pua = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gole symbols, 00 to 99'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Ligature')),
                ButtonSegment(value: true, label: Text('PUA')),
              ],
              selected: {_pua},
              onSelectionChanged: (selection) => setState(() => _pua = selection.first),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 84,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 100,
        itemBuilder: (context, n) => SymbolTile(value: n, pua: _pua),
      ),
    );
  }
}

/// One symbol with its decimal pair underneath.
class SymbolTile extends StatelessWidget {
  const SymbolTile({super.key, required this.value, required this.pua});

  final int value;
  final bool pua;

  @override
  Widget build(BuildContext context) {
    final digits = value.toString().padLeft(2, '0');
    // Ligature build: the two digits. PUA build: one private-use character.
    final text = pua ? String.fromCharCode(golePuaFirstCodePoint + value) : digits;
    return Semantics(
      label: digits,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExcludeSemantics(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: pua ? goleFontFamilyPua : goleFontFamily,
                  package: goleFontPackage,
                  fontSize: 32,
                ),
              ),
            ),
            ExcludeSemantics(child: Text(digits, style: Theme.of(context).textTheme.labelSmall)),
          ],
        ),
      ),
    );
  }
}
