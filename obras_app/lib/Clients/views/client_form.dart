import 'package:flutter/material.dart';
import 'package:obras_app/Clients/models/client.dart';
import 'package:obras_app/Clients/provider/client.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({Key? key}) : super(key: key);

  @override
  _ClientFormState createState() => _ClientFormState();
}

var maskFormatter = MaskTextInputFormatter(
    mask: '####.',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var maskFormatter2 = MaskTextInputFormatter(
    mask: '##/##/####.',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

class _ClientFormState extends State<ClientForm> {
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<Clients>(
      context,
      listen: false,
    ).loadClients();
  }

  final Map<String, String> _formData = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final user = ModalRoute.of(context)?.settings.arguments;

      if (user != null) {
        final client = user as Client;
        _formData['id'] = user.id;
        _formData['name'] = user.name;
        _formData['Ide'] = user.Ide;
        _formData['valor '] = user.valor;
        _formData['Data_Entrada'] = user.Data_Entrada;
        _formData['Data_Entrega'] = user.Data_Entrega;
        _formData['Estatus'] = user.Estatus;
        _formData['imagem'] = user.imagem;
        _formData['Coments'] = user.Coments;
        _formData['Coments2'] = user.Coments2;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Produção Externa'),
        backgroundColor: const Color.fromARGB(255, 48, 70, 82),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                Provider.of<Clients>(context, listen: false)
                    .saveClient(_formData);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Row(
            children: [
              SizedBox(
                height: 600,
                width: 650,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: TextFormField(
                        inputFormatters: [maskFormatter],
                        initialValue: _formData['Ide'],
                        decoration: const InputDecoration(
                            labelText: 'ID da Obra',
                            prefixIcon: Icon(Icons.business),
                            border: OutlineInputBorder()),
                        onSaved: (value) => _formData['Ide'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: TextFormField(
                        initialValue: _formData['name'],
                        decoration: const InputDecoration(
                            labelText: 'Nome da Obra',
                            prefixIcon: Icon(Icons.business),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome inválido';
                          }
                          if (value.trim().length < 3) {
                            return 'Nome muito pequeno. No mínimo 3 letras.';
                          }
                          return null;
                        },
                        onSaved: (value) => _formData['name'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: TextFormField(
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            locale: 'Pt',
                            symbol: 'R\$',
                          )
                        ],
                        initialValue: _formData['valor'],
                        decoration: const InputDecoration(
                            labelText: 'Valor Estimado',
                            prefixIcon: Icon(Icons.monetization_on_outlined),
                            border: OutlineInputBorder()),
                        onSaved: (value) =>
                            _formData['valor'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: TextFormField(
                        inputFormatters: [maskFormatter2],
                        initialValue: _formData['Data_Entrada'],
                        decoration: const InputDecoration(
                            labelText: 'Data de Entrada',
                            prefixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder()),
                        onSaved: (value) =>
                            _formData['Data_Entrada'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: TextFormField(
                        inputFormatters: [maskFormatter2],
                        initialValue: _formData['Data_Entrega'],
                        decoration: const InputDecoration(
                            labelText: 'Data Entrega',
                            prefixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder()),
                        onSaved: (value) =>
                            _formData['Data_Entrega'] = value as String,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 600,
                width: 650,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        initialValue: _formData['imagem'],
                        decoration: const InputDecoration(
                            labelText: 'URL Anexo Obra',
                            prefixIcon: Icon(Icons.image),
                            border: OutlineInputBorder()),
                        onSaved: (value) =>
                            _formData['imagem'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        child: TextFormField(
                          maxLines: 9,
                          initialValue: _formData['Coments'],
                          decoration: const InputDecoration(
                              labelText: 'Observações',
                              prefixIcon: Icon(Icons.comment),
                              border: OutlineInputBorder()),
                          onSaved: (value) =>
                              _formData['Coments'] = value as String,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
