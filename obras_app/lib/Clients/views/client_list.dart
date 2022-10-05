import 'package:obras_app/Clients/models/client.dart';
import 'package:flutter/material.dart';
import 'package:obras_app/Clients/componentes/client_tile.dart';
import 'package:obras_app/Clients/provider/client.dart';
import 'package:obras_app/app_routes.dart';
import 'package:provider/provider.dart';

class ClientList extends StatefulWidget {
  const ClientList({Key? key}) : super(key: key);

  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  bool isSearch = false;
  List<Client> searchedUsers = [];

  @override
  void initState() {
    super.initState();
    Provider.of<Clients>(
      context,
      listen: false,
    ).loadClients();
  }

  @override
  Widget build(BuildContext context) {
    final Clients users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Produção Externa',
          style: TextStyle(fontStyle: FontStyle.normal, fontSize: 25.0),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 48, 70, 82),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_outlined),
            onPressed: () {
              Client user = Client(
                id: '',
                name: '',
                Ide: '',
                valor: '',
                Data_Entrada: '',
                Data_Entrega: '',
                Estatus: 'suprimentos',
                imagem: '',
                Coments: '',
                Coments2: '',
              );
              Navigator.of(context)
                  .pushNamed(AppRoutes.client_form, arguments: user);
            },
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 194, 194, 194),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            color: const Color.fromARGB(255, 194, 194, 194),
            child: ListView.builder(
              itemCount: (isSearch ? searchedUsers.length : users.count) + 1,
              itemBuilder: (ctx, i) => i == 0
                  ? _searchBar(users)
                  : ClientTile(isSearch
                      ? searchedUsers.elementAt(i - 1)
                      : users.byIndex(i - 1)),
            ),
          ),
        ),
      ),
    );
  }

  _searchBar(Clients clients) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 48, 70, 82),
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          color: const Color.fromARGB(255, 233, 232, 232),
          child: TextField(
              decoration: const InputDecoration(
                  hintText: 'Busca por ID, Nome ou Status',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  prefixIcon: Icon(Icons.search)),
              onChanged: (text) {
                setState(() {
                  text = text.toLowerCase();
                  isSearch = text.isNotEmpty;
                  searchedUsers = clients.all.where((user) {
                    var userid = user.Ide.toLowerCase();
                    var userstatus = user.Estatus.toLowerCase();
                    var username = user.name.toLowerCase();
                    return userstatus.contains(text) ||
                        userid.contains(text) ||
                        username.contains(text);
                  }).toList();
                });
              }),
        ));
  }
}
