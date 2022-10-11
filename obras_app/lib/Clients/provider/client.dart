import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:obras_app/Clients/models/client.dart';

class Clients with ChangeNotifier {
  final List<Client> items = [];
  final _baseurl = '';

  List<Client> get all {
    return [...items];
  }

  int get count {
    return items.length;
  }

  Future<void> loadClients() async {
    final response = await http.get(Uri.parse('$_baseurl.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> dataclients = jsonDecode(response.body);
    items.clear();
    dataclients.forEach(
      (Clientid, ClientData) {
        items.add(
          Client(
            id: Clientid,
            name: ClientData['name'],
            Ide: ClientData['Ide'],
            Data_Entrada: ClientData['Data_Entrada'],
            Data_Entrega: ClientData['Data_Entrega'],
            valor: ClientData['valor'],
            Estatus: ClientData['Estatus'],
            imagem: ClientData['imagem'],
            Coments: ClientData['Coments'],
            Coments2: ClientData['Coments2'],
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> saveClient(Map<String, Object> dataclients) async {
    bool hasId = (dataclients['id'] != null && dataclients['id'] != "");
    final client = Client(
      id: hasId
          ? dataclients['id'] as String
          : Random().nextDouble().toString(),
      name: dataclients['name'] as String,
      Ide: dataclients['Ide'] as String,
      Data_Entrada: dataclients['Data_Entrada'] as String,
      Data_Entrega: dataclients['Data_Entrega'] as String,
      valor: dataclients['valor'] as String,
      Estatus: dataclients['Estatus'] as String,
      imagem: dataclients['imagem'] as String,
      Coments: dataclients['Coments'] as String,
      Coments2: dataclients['Coments2'] as String,
    );
    if (hasId) {
      return updateClient(client);
    } else {
      return addClient(client);
    }
  }

  Client byIndex(int i) {
    return items.elementAt(i);
  }

  Future<void> addClient(Client client) async {
    final response = await http.post(
      Uri.parse('$_baseurl.json'),
      body: jsonEncode(
        {
          "name": client.name,
          "Ide": client.Ide,
          "Data_Entrada": client.Data_Entrada,
          "valor": client.valor,
          "Data_Entrega": client.Data_Entrega,
          "Estatus": client.Estatus,
          "imagem": client.imagem,
          "Coments": client.Coments,
          "Coments2": client.Coments2,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    items.add(Client(
      id: id,
      name: client.name,
      Ide: client.Ide,
      Data_Entrada: client.Data_Entrada,
      valor: client.valor,
      Data_Entrega: client.Data_Entrega,
      Estatus: client.Estatus,
      imagem: client.imagem,
      Coments: client.Coments,
      Coments2: client.Coments2,
    ));
    notifyListeners();
  }

  Future<void> updateClient(Client client) async {
    int index = items.indexWhere((p) => p.id == client.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseurl/${client.id}.json'),
        body: jsonEncode(
          {
            "name": client.name,
            "Ide": client.Ide,
            "Data_Entrada": client.Data_Entrada,
            "valor": client.valor,
            "Data_Entrega": client.Data_Entrega,
            "Estatus": client.Estatus,
            "imagem": client.imagem,
            "Coments": client.Coments,
            "Coments2": client.Coments2,
          },
        ),
      );
      items[index] = client;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> removeProduct(Client client) async {
    int index = items.indexWhere((p) => p.id == client.id);

    if (index >= 0) {
      final client = items[index];
      items.remove(client);
      notifyListeners();
      final response = await http.delete(
        Uri.parse('$_baseurl/${client.id}.json'),
      );
      if (response.statusCode >= 400) {
        items.insert(index, client);
        notifyListeners();
      }
    }
  }
}
