import 'package:flutter/material.dart';
import 'package:obras_app/Clients/models/client.dart';
import 'package:obras_app/Clients/provider/client.dart';
import 'package:obras_app/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientTile extends StatelessWidget {
  final Client client;

  const ClientTile(this.client);

  Color color() {
    if (client.Estatus == 'suprimentos') {
      return const Color.fromARGB(255, 250, 90, 90);
    } else if (client.Estatus == 'fabricacao') {
      return const Color.fromARGB(255, 255, 157, 100);
    } else if (client.Estatus == 'entrega') {
      return const Color.fromARGB(255, 255, 243, 139);
    } else if (client.Estatus == 'finalizado') {
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
                          client.Estatus = Status.suprimentos.toShortString();
                          Provider.of<Clients>(context, listen: false)
                              .updateClient(client);
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
                          client.Estatus = Status.fabricacao.toShortString();
                          Provider.of<Clients>(context, listen: false)
                              .updateClient(client);
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.local_shipping_outlined),
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
                          client.Estatus = Status.entrega.toShortString();
                          Provider.of<Clients>(context, listen: false)
                              .updateClient(client);
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
                                  onPressed: () =>
                                      Navigator.of(context).pop(true)),
                              TextButton(
                                child: const Text('Não'),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                            ],
                          ),
                        ).then((confimed) {
                          if (confimed) {
                            client.Estatus = Status.finalizado.toShortString();
                            Provider.of<Clients>(context, listen: false)
                                .updateClient(client);
                          }
                        });
                      }),
                ],
              ),
            ),
          ),
          title: Column(
            children: [
              Text(
                'ID: ${client.Ide}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(
                'Nome: ${client.name}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),
              )
            ],
          ),
          subtitle: Text(
            'Previsão Entrega: ${client.Data_Entrega}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15.0),
          ),
          trailing: SizedBox(
            width: 120,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.image),
                  color: const Color.fromARGB(255, 48, 70, 82),
                  onPressed: () {
                    redirectUrl(client.imagem);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.menu),
                  color: const Color.fromARGB(255, 48, 70, 82),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.client_form, arguments: client);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: const Color.fromARGB(255, 48, 70, 82),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Excluir Obra'),
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
                        Provider.of<Clients>(context, listen: false)
                            .removeProduct(client);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }

  redirectUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
