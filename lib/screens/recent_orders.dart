import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../colors.dart';
import '../database/database.dart' show Orders;

class RecentOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<List<Orders?>?>(context);
    if (orders == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: shrineBrown600,
          ),
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
              hoverColor: Colors.red,
              title: Text(
                "Product Name:  ${orders![index]!.cart[ind]["name"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                  "Product price:  ₹${orders![index]!.cart[ind]["price"]}"),
              leading: Image.network(
                orders![index]!.cart[ind]["url"],
                fit: BoxFit.contain,
                cacheHeight: 200,
                cacheWidth: 200,
              ),
            );
          },
        );
      },
    );
  }
}
