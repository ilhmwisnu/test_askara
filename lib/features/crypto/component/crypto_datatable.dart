import 'package:flutter/material.dart';

import '../../../models/crypto.dart';

class CryptoDataTable extends StatelessWidget {
  const CryptoDataTable({
    super.key,
    this.onTap,
    required this.cryptoData,
  });

  final void Function(Crypto)? onTap;
  final List<Crypto> cryptoData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Code")),
          DataColumn(label: Text("Last")),
          DataColumn(label: Text("Chg")),
          DataColumn(label: Text("Chg%")),
        ],
        rows: cryptoData.map(
          (crypto) {
            return DataRow(cells: [
              DataCell(
                Text(
                  crypto.s!,
                  style: TextStyle(
                      color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                ),
                onTap: onTap != null
                    ? () {
                        onTap!(crypto);
                      }
                    : null,
              ),
              DataCell(Text(crypto.p!)),
              DataCell(Text(crypto.dd!)),
              DataCell(Text("${crypto.dc}%")),
            ]);
          },
        ).toList(),
      ),
    );
  }
}
