import 'package:obras_app/Production/models/user.dart';
import 'package:flutter/material.dart';
import 'package:obras_app/Production/componentes/user_tile.dart';
import 'package:obras_app/Production/provider/users.dart';
import 'package:obras_app/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  bool isSearch = false;
  List<User> searchedUsers = [];

  @override
  void initState() {
    super.initState();
    Provider.of<Users>(
      context,
      listen: false,
    ).loadClients();
  }

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Produção Interna',
          style: TextStyle(fontStyle: FontStyle.normal, fontSize: 25.0),
        ),
        backgroundColor: const Color.fromARGB(255, 48, 70, 82),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              User user = User(
                id: '',
                Id_Obra: '',
                Cliente: '',
                telefone: '',
                Data_Entrada: '',
                Endereco: '',
                Previsao_Producao: '',
                Previsao_Instalacao: '',
                valor: '',
                imagem: '',
                Coments: '',
                Coments2: '',
                Estatus: 'suprimentos',
              );
              Navigator.of(context)
                  .pushNamed(AppRoutes.user_form, arguments: user);
            },
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 194, 194, 194),
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            color: const Color.fromARGB(255, 194, 194, 194),
            child: ListView.builder(
              itemCount: (isSearch ? searchedUsers.length : users.count) + 1,
              itemBuilder: (ctx, i) => i == 0
                  ? _searchBar(users)
                  : UserTile(isSearch
                      ? searchedUsers.elementAt(i - 1)
                      : users.byIndex(i - 1)),
            ),
          ),
        ),
      ),
    );
  }

  _searchBar(Users users) {
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
                  hintText: 'Busca por ID, Cliente ou Status',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  prefixIcon: Icon(Icons.search)),
              onChanged: (text) {
                setState(() {
                  text = text.toLowerCase();
                  isSearch = text.isNotEmpty;
                  searchedUsers = users.all.where((user) {
                    var userid = user.Id_Obra.toLowerCase();
                    var userstatus = user.Estatus.toLowerCase();
                    var username = user.Cliente.toLowerCase();
                    return userstatus.contains(text) ||
                        userid.contains(text) ||
                        username.contains(text);
                  }).toList();
                });
              }),
        ));
  }
}
