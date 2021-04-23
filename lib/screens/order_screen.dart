import 'package:evier/database/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order"),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: cartItems!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: null,
              );
            },
          ),
          // Text(countItemPrice().toString()),
        ],
      ),
    );
  }
}
