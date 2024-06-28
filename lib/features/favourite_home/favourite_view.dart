import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/controllers/format_controller.dart';
import 'package:wherehome/common/controllers/http_controller.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/providers/user_provider.dart';
import 'package:wherehome/common/widgets/dialog_error.dart';
import 'package:wherehome/features/home_details/homedetails_view.dart';

import '../../data/repositories/home_repo.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key, required this.favoriteHomes});

  final List<Home> favoriteHomes;

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  Future<void> removeFromFavourites(Home chosen, HttpController api) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.homeOwner != null) {
      await api.sendDeleteRequest(
          'homeowner/${userProvider.homeOwner!.id}',
          {'Authorization': 'Bearer ${userProvider.apiToken}'},
          chosen.toJson(), (success) {
        setState(() {
          widget.favoriteHomes.remove(chosen);
        });
      }, (failure) {
        showErrorDialog(context, failure.body);
      });
    }
  }

  void loadHomeDetails(Home selectedHome) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeItemView(homeDetails: selectedHome)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final api = HttpControllerInherited.of(context).api;
    return Scaffold(
      appBar: AppBar(
        title: const Text('favorites').tr(),
      ),
      body: ListView.builder(
        itemCount: widget.favoriteHomes.length,
        itemBuilder: (context, index) {
          final home = widget.favoriteHomes[index];
          return ListTile(
            leading: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  '${api.baseUrl}/${home.imagePath[0]}',
                  fit: BoxFit.fill,
                )),
            title: Text(
              home.address,
              style: const TextStyle(fontSize: 12),
            ),
            subtitle: Text(
              '${formatDoublePriceWithSpaces(home.price)} ${tr('currency')} for ${home.type}',
            ),
            onTap: () {
              loadHomeDetails(home);
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete_forever_rounded),
              onPressed: () async {
                await removeFromFavourites(home, api);
              },
            ),
          );
        },
      ),
    );
  }
}
