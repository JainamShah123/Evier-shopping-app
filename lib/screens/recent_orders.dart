import 'package:evier/database/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<List<Orders?>?>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your recent orders"),
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
      // body: Text(orders![0]!.cart[0]["company"]),
    );
  }
}
