import 'package:evier/database/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecentOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<List<Orders?>?>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.recentOrders),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: orders!.length,
          itemBuilder: (context, index) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: orders[index]!.cart.length,
                itemBuilder: (context, ind) {
                  return ListTile(
                    title: Text(orders[index]!.cart[ind]["name"]),
                    subtitle: Text(orders[index]!.cart[ind]["price"]),
                  );
                });
          }),
    );
  }
}
