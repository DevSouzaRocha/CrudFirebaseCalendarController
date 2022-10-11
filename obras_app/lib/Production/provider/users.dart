import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:obras_app/Production/models/user.dart';

class Users with ChangeNotifier {
  final List<User> items = [];

  final _baseurl = '';

  List<User> get all {
    return [...items];
  }

  int get count {
    return items.length;
  }

  Future<void> loadClients() async {
    final response = await http.get(Uri.parse('$_baseurl.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> dataObras = jsonDecode(response.body);
    items.clear();
    dataObras.forEach(
      (Clientid, ClientData) {
        items.add(User(
            id: Clientid,
            Id_Obra: ClientData['Id_Obra'],
            Cliente: ClientData['Cliente'],
            telefone: ClientData['telefone'],
            Endereco: ClientData['Endereco'],
            Data_Entrada: ClientData['Data_Entrada'],
            Previsao_Producao: ClientData['Previsao_Producao'],
            Previsao_Instalacao: ClientData['Previsao_Instalacao'],
            valor: ClientData['valor'],
            imagem: ClientData['imagem'],
            Coments: ClientData['Coments'],
            Coments2: ClientData['Coments2'],
            Estatus: ClientData['Estatus']));
      },
    );
    notifyListeners();
  }

  Future<void> saveClient(Map<String, Object> dataObras) async {
    bool hasId = (dataObras['id'] != null && dataObras['id'] != "");
    final user = User(
      id: hasId ? dataObras['id'] as String : Random().nextDouble().toString(),
      Id_Obra: dataObras['Id_Obra'] as String,
      Cliente: dataObras['Cliente'] as String,
      telefone: dataObras['telefone'] as String,
      Endereco: dataObras['Endereco'] as String,
      Data_Entrada: dataObras['Data_Entrada'] as String,
      Previsao_Producao: dataObras['Previsao_Producao'] as String,
      Previsao_Instalacao: dataObras['Previsao_Instalacao'] as String,
      valor: dataObras['valor'] as String,
      imagem: dataObras['imagem'] as String,
      Coments: dataObras['Coments'] as String,
      Coments2: dataObras['Coments2'] as String,
      Estatus: dataObras['Estatus'] as String,
    );
    if (hasId) {
      return updateClient(user);
    } else {
      return addClient(user);
    }
  }

  User byIndex(int i) {
    return items.elementAt(i);
  }

  Future<void> addClient(User user) async {
    final response = await http.post(
      Uri.parse('$_baseurl.json'),
      body: jsonEncode(
        {
          "Id_Obra": user.Id_Obra,
          "Cliente": user.Cliente,
          "telefone": user.telefone,
          "Endereco": user.Endereco,
          "Previsao_Producao": user.Previsao_Producao,
          "Data_Entrada": user.Data_Entrada,
          "Previsao_Instalacao": user.Previsao_Instalacao,
          "valor": user.valor,
          "imagem": user.imagem,
          "Coments": user.Coments,
          "Coments2": user.Coments2,
          "Estatus": user.Estatus,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    items.add(
      User(
        id: id,
        Id_Obra: user.Id_Obra,
        Cliente: user.Cliente,
        telefone: user.telefone,
        Endereco: user.Endereco,
        Previsao_Producao: user.Previsao_Producao,
        Previsao_Instalacao: user.Previsao_Instalacao,
        Data_Entrada: user.Data_Entrada,
        valor: user.valor,
        imagem: user.imagem,
        Coments: user.Coments,
        Coments2: user.Coments2,
        Estatus: user.Estatus,
      ),
    );
    notifyListeners();
  }

  Future<void> updateClient(User user) async {
    int index = items.indexWhere((p) => p.id == user.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseurl/${user.id}.json'),
        body: jsonEncode(
          {
            "Id_Obra": user.Id_Obra,
            "Cliente": user.Cliente,
            "telefone": user.telefone,
            "Endereco": user.Endereco,
            "Previsao_Producao": user.Previsao_Producao,
            "Previsao_Instalacao": user.Previsao_Instalacao,
            "Data_Entrada": user.Data_Entrada,
            "valor": user.valor,
            "imagem": user.imagem,
            "Coments": user.Coments,
            "Coments2": user.Coments2,
            "Estatus": user.Estatus
          },
        ),
      );

      items[index] = user;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> removeProduct(User user) async {
    int index = items.indexWhere((p) => p.id == user.id);

    if (index >= 0) {
      final client = items[index];
      items.remove(client);
      notifyListeners();
      final response = await http.delete(
        Uri.parse('$_baseurl/${client.id}.json'),
      );
      if (response.statusCode >= 400) {
        items.insert(index, user);
        notifyListeners();
      }
    }
  }
}
