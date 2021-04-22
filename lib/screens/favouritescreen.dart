import 'package:evier/database/database_services.dart';
import 'package:evier/database/favourites.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favourites = Provider.of<List<Favourites?>?>(context);
    if (favourites == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (favourites.isEmpty)
      return Center(
        child: Text("No products in favourite"),
      );

    return ListView.builder(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      itemCount: favourites.length,
      itemBuilder: (ctx, index) {
        String indexid = favourites[index]!.id.toString();
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
            await DatabaseServices().removeFavorite(indexid);
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
          child: FavouritesList(
            title: favourites[index]?.productName,
            url: favourites[index]?.imageUrl,
            price: favourites[index]?.price.toString(),
            description: favourites[index]?.description,
            id: favourites[index]?.id,
            company: favourites[index]?.company,
            category: favourites[index]?.category,
            seller: favourites[index]?.seller,
          ),
        );
      },
    );
  }
}

class FavouritesList extends StatelessWidget {
  final String? title, url, price, description, id, category, seller, company;

  const FavouritesList(
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
