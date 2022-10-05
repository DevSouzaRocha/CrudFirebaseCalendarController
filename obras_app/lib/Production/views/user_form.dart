import 'package:flutter/material.dart';
import 'package:obras_app/Production/models/user.dart';
import 'package:obras_app/Production/provider/users.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

var dataFormater = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);
var dataFormater2 = MaskTextInputFormatter(
    mask: '(##)#####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);
var dataFormater3 = MaskTextInputFormatter(
    mask: '####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<Users>(
      context,
      listen: false,
    ).loadClients();
  }

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _formData['Id_Obra'] = user.Id_Obra;
    _formData['Cliente'] = user.Cliente;
    _formData['telefone'] = user.telefone;
    _formData['imagem'] = user.imagem;
    _formData['Data_Entrada'] = user.Data_Entrada;
    _formData['Endereco'] = user.Endereco;
    _formData['Previsao_Producao'] = user.Previsao_Producao;
    _formData['Previsao_Instalacao'] = user.Previsao_Instalacao;
    _formData['Coments'] = user.Coments;
    _formData['Coments2'] = user.Coments2;
    _formData['Estatus'] = user.Estatus;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = ModalRoute.of(context)?.settings.arguments as User;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Produção'),
        backgroundColor: const Color.fromARGB(255, 48, 70, 82),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false)
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
                width: 725,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        inputFormatters: [dataFormater3],
                        initialValue: _formData['Id_Obra'],
                        decoration: const InputDecoration(
                            labelText: 'ID da Obra',
                            prefixIcon: Icon(Icons.business),
                            border: OutlineInputBorder()),
                        onSaved: (value) =>
                            _formData['Id_Obra'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        initialValue: _formData['Cliente'],
                        decoration: const InputDecoration(
                            labelText: 'Cliente',
                            prefixIcon: Icon(Icons.people_alt_outlined),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'ID inválido';
                          }
                          if (value.trim().length < 3) {
                            return 'ID Precisa conter 4 Números';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _formData['Cliente'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        inputFormatters: [dataFormater2],
                        initialValue: _formData['telefone'],
                        decoration: const InputDecoration(
                            labelText: 'Telefone',
                            prefixIcon: Icon(Icons.people_alt_outlined),
                            border: OutlineInputBorder()),
                        onSaved: (value) =>
                            _formData['telefone'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
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
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        initialValue: _formData['Endereco'],
                        decoration: const InputDecoration(
                            labelText: 'Endereço',
                            prefixIcon: Icon(Icons.add_road_rounded),
                            border: OutlineInputBorder()),
                        onSaved: (value) =>
                            _formData['Endereco'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        inputFormatters: [dataFormater],
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
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        inputFormatters: [dataFormater],
                        initialValue: _formData['Previsao_Producao'],
                        decoration: const InputDecoration(
                            labelText: 'Previsao Produção',
                            prefixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder()),
                        onSaved: (value) =>
                            _formData['Previsao_Producao'] = value as String,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        inputFormatters: [dataFormater],
                        initialValue: _formData['Previsao_Instalacao'],
                        decoration: const InputDecoration(
                            labelText: 'Previsao Instalação',
                            prefixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder()),
                        onSaved: (value) =>
                            _formData['Previsao_Instalacao'] = value as String,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 600,
                width: 600,
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
                          maxLines: 8,
                          initialValue: _formData['Coments'],
                          decoration: const InputDecoration(
                              labelText: 'Observações Produção',
                              prefixIcon: Icon(Icons.comment),
                              border: OutlineInputBorder()),
                          onSaved: (value) =>
                              _formData['Coments'] = value as String,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 11, left: 4, right: 4),
                      child: SizedBox(
                        child: TextFormField(
                          maxLines: 8,
                          initialValue: _formData['Coments2'],
                          decoration: const InputDecoration(
                              labelText: 'Observações Instalação',
                              prefixIcon: Icon(Icons.comment),
                              border: OutlineInputBorder()),
                          onSaved: (value) =>
                              _formData['Coments2'] = value as String,
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
