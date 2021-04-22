import 'package:evier/database/cart.dart';
import 'package:evier/database/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<List<Cart?>?>(context);
    if (cart == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (cart.isEmpty)
      return Center(
        child: Text("No products in cart"),
      );

    return ListView.builder(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      itemCount: cart.length,
      itemBuilder: (ctx, index) {
        String indexid = cart[index]!.id.toString();
        return Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: FaIcon(
              FontAwesomeIcons.trashAlt,
              color: Colors.white,
            ),
          ),
          onDismissed: (DismissDirection direction) async {
            await DatabaseServices().removeCart(indexid);
          },
          confirmDismiss: (direcction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.confirm),
                  content:
                      Text(AppLocalizations.of(context)!.deleteItemWarning),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(AppLocalizations.of(context)!.delete),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                  ],
                );
              },
            );
          },
          key: Key(indexid),
          child: CartList(
            title: cart[index]?.productName,
            url: cart[index]?.imageUrl,
            price: cart[index]?.price.toString(),
            description: cart[index]?.description,
            id: cart[index]?.id,
            company: cart[index]?.company,
            category: cart[index]?.category,
            seller: cart[index]?.seller,
          ),
        );
      },
    );
  }
}

class CartList extends StatelessWidget {
  final String? title, url, price, description, id, category, seller, company;

  const CartList(
      {Key? key,
      this.title,
      this.url,
      this.price,
      this.description,
      this.id,
      this.category,
      this.company,
      this.seller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Product Name:  $title",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text("Product price:  $price"),
      children: [
        Image.network(url!),
        Text(company!),
      ],
    );
  }
}
