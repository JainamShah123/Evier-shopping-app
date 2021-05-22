import 'package:evier/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import '../database/database_services.dart';
import '../screens/product_screen.dart';

class Products extends StatefulWidget {
  final ProductsData productData;
  final UserData? userData;

  const Products({
    required this.productData,
    required this.userData,
  });

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late DatabaseServices? databaseServices;
  void setCart(BuildContext ctx) async {
    bool cartIsSet = await databaseServices!.cartIsSet(widget.productData.id!);

    if (!cartIsSet) {
      await databaseServices!.setCart(
        company: widget.productData.company!,
        category: widget.productData.category!,
        id: widget.productData.id!,
        price: widget.productData.price!,
        productName: widget.productData.productName!,
        seller: widget.productData.seller!,
        description: widget.productData.description!,
        imageUrl: widget.productData.imageUrl!,
      );
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Already added in cart"),
        ),
      );
    }
  }

  void setFav(BuildContext ctx) async {
    bool favIsSet = await databaseServices!.favIsSet(widget.productData.id!);
    if (!favIsSet) {
      await databaseServices!.setFavourite(
        company: widget.productData.company!,
        category: widget.productData.category!,
        id: widget.productData.id!,
        price: widget.productData.price!,
        productName: widget.productData.productName!,
        seller: widget.productData.seller!,
        description: widget.productData.description ?? "",
        imageUrl: widget.productData.imageUrl!,
      );
      setState(() {
        favIsSet = true;
      });
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Already added in favourites"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    databaseServices = Provider.of<DatabaseServices?>(context);
    UserData? userData = Provider.of<UserData?>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductScreen(
              userData: userData,
              productsData: widget.productData,
            ),
          ),
        );
      },
      child: Card(
        borderOnForeground: true,
        elevation: 0,
        color: shrineBackgroundWhite,
        shadowColor: Colors.transparent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                margin: EdgeInsets.only(top: 2),
                height: 150,
                width: 150,
                child: Image.network(
                  widget.productData.imageUrl!,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: shrineBrown600,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "${widget.productData.productName!}".toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "₹${widget.productData.price!}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
