import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../database/database.dart' show Cart, DatabaseServices;

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<List<Cart?>?>(context);
    int countItemPrice() {
      int sum = 0;
      for (int i = 0; i < cartItems!.length; i++) {
        sum += int.parse(cartItems[i]!.price!);
      }
      return sum;
    }

    double countShipping() {
      double sum = 0;
      for (int i = 0; i < cartItems!.length; i++) {
        sum += (int.parse(cartItems[i]!.price!) / 10);
      }
      return sum.roundToDouble();
    }

    void submitOrder() async {
      var item = cartItems!;
      var totalPrice = countItemPrice().toDouble() + countShipping();
      await DatabaseServices().submitOrders(
        cart: item,
        amount: totalPrice.toString(),
      );
      for (int i = 0; i < cartItems.length; i++)
        await DatabaseServices().removeCart(cartItems[i]!.id!);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.order),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            OrdersList(cartItems: cartItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context)!.totalPrice}:"),
                Text(countItemPrice().toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context)!.totalShipping}:"),
                Text(countShipping().toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context)!.total}:"),
                Text((countItemPrice() + countShipping()).toString()),
              ],
            ),
            Text(AppLocalizations.of(context)!.paymod),
            ElevatedButton(
              onPressed: () => submitOrder(),
              child: Text(AppLocalizations.of(context)!.orderNow),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  const OrdersList({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  final List<Cart?>? cartItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cartItems!.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(cartItems![index]!.productName!),
          subtitle: Text(cartItems![index]!.price!),
          trailing: Image.network(
            cartItems![index]!.imageUrl!,
            fit: BoxFit.contain,
            cacheHeight: 56,
            cacheWidth: 56,
          ),
        );
      },
    );
  }
}
