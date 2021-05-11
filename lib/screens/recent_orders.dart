import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../database/database.dart' show Orders;

class RecentOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<List<Orders?>?>(context);
    if (orders == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.recentOrders),
      ),
      body: orders.isEmpty
          ? Center(
              child: FaIcon(
                FontAwesomeIcons.trash,
                size: 100,
              ),
            )
          : OrderItems(orders: orders),
    );
  }
}

class OrderItems extends StatelessWidget {
  const OrderItems({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final List<Orders?>? orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orders!.length,
      itemBuilder: (context, index) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: orders![index]!.cart.length,
          itemBuilder: (context, ind) {
            return ListTile(
              title: Text(orders![index]!.cart[ind]["name"]),
              subtitle: Text(orders![index]!.cart[ind]["price"]),
            );
          },
        );
      },
    );
  }
}
