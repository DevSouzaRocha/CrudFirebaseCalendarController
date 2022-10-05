import 'package:flutter/material.dart';
import 'package:obras_app/Production/models/user.dart';
import 'package:obras_app/Production/provider/users.dart';
import 'package:obras_app/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user, {Key? key}) : super(key: key);

  Color color() {
    if (user.Estatus == 'suprimentos') {
      return const Color.fromARGB(255, 250, 90, 90);
    } else if (user.Estatus == 'fabricacao') {
      return const Color.fromARGB(255, 255, 157, 100);
    } else if (user.Estatus == 'instalacao') {
      return const Color.fromARGB(255, 255, 243, 139);
    } else if (user.Estatus == 'finalizado') {
      return const Color.fromARGB(255, 121, 224, 124);
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: const Color.fromARGB(255, 48, 70, 82),
      elevation: 5,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Color.fromARGB(255, 48, 70, 82),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: const Color.fromARGB(255, 162, 178, 187),
      child: ListTile(
        leading: SizedBox(
          width: 170,
          child: Card(
            color: color(),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.list_alt),
                  color: const Color.fromARGB(255, 48, 70, 82),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Alteração Status de Obra'),
                        content: const Text('Confirmar?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Sim'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                          TextButton(
                            child: const Text('Não'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                        ],
                      ),
                    ).then((confimed) {
                      if (confimed) {
                        user.Estatus = Status.suprimentos.toShortString();
                        Provider.of<Users>(context, listen: false)
                            .updateClient(user);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.factory_outlined),
                  color: const Color.fromARGB(255, 48, 70, 82),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Alteração Status de Obra'),
                        content: const Text('Confirmar?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Sim'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                          TextButton(
                            child: const Text('Não'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                        ],
                      ),
                    ).then((confimed) {
                      if (confimed) {
                        user.Estatus = Status.fabricacao.toShortString();
                        Provider.of<Users>(context, listen: false)
                            .updateClient(user);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.construction_outlined),
                  color: const Color.fromARGB(255, 48, 70, 82),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Alteração Status de Obra'),
                        content: const Text('Confirmar?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Sim'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                          TextButton(
                            child: const Text('Não'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                        ],
                      ),
                    ).then((confimed) {
                      if (confimed) {
                        user.Estatus = Status.instalacao.toShortString();
                        Provider.of<Users>(context, listen: false)
                            .updateClient(user);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.inventory_rounded),
                  color: const Color.fromARGB(255, 48, 70, 82),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Alteração Status de Obra'),
                        content: const Text('Confirmar?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Sim'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                          TextButton(
                            child: const Text('Não'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                        ],
                      ),
                    ).then((confimed) {
                      if (confimed) {
                        user.Estatus = Status.finalizado.toShortString();
                        Provider.of<Users>(context, listen: false)
                            .updateClient(user);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ID: ${user.Id_Obra}',
              style: const TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            Text(
              'Cliente: ${user.Cliente}',
              style: const TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Previsão Produção: ${user.Previsao_Producao}',
              style: const TextStyle(fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Previsão Instalação: ${user.Previsao_Instalacao}',
                style: const TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 120,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.image),
                color: const Color.fromARGB(255, 48, 70, 82),
                onPressed: () {
                  redirectUrl(user.imagem);
                },
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                color: const Color.fromARGB(255, 48, 70, 82),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.user_form,
                    arguments: user,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: const Color.fromARGB(255, 48, 70, 82),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Excluir Usuário'),
                      content: const Text('Tem certeza?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Não'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                          child: const Text('Sim'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    ),
                  ).then((confimed) {
                    if (confimed) {
                      Provider.of<Users>(context, listen: false)
                          .removeProduct(user);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  redirectUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
