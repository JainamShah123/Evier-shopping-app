import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../database/database.dart';

class EvierSearch extends SearchDelegate<ProductsData?> {
  List<ProductsData?>? data;

  EvierSearch({required this.data});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
          context,
          null,
        );
      },
      icon: Icon(
        Icons.arrow_back_ios_new,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (data!.isEmpty) {
      return Text(AppLocalizations.of(context)!.nodata);
    }
    final result = data!.where(
        (element) => element!.productName!.toLowerCase().contains(query));
    return ListView(
      children: result
          .map((e) => ListTile(
                onTap: () {
                  if (e == null) {
                    close(context, null);
                  }
                  close(context, e!);
                },
                hoverColor: Colors.red,
                title: Text(
                  "${AppLocalizations.of(context)!.productNameHint}:  ${e!.productName}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    "${AppLocalizations.of(context)!.priceHint}:  ₹${e.price}"),
                leading: Image.network(
                  e.imageUrl!,
                  fit: BoxFit.contain,
                  cacheHeight: 200,
                  cacheWidth: 200,
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (data!.isEmpty) {
      return Text("No Data");
    }

    final result = data!.where(
        (element) => element!.productName!.toLowerCase().contains(query));
    return ListView(
      children: result
          .map((e) => ListTile(
                onTap: () {
                  close(context, e!);
                },
                hoverColor: Colors.red,
                title: Text(
                  "${AppLocalizations.of(context)!.productNameHint}:  ${e!.productName}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    "${AppLocalizations.of(context)!.priceHint}:  ₹${e.price}"),
                leading: Image.network(
                  e.imageUrl!,
                  fit: BoxFit.contain,
                  cacheHeight: 200,
                  cacheWidth: 200,
                ),
              ))
          .toList(),
    );
  }
}
