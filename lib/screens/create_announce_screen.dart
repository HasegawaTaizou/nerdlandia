import 'package:flutter/material.dart';
import 'package:projeto_nerdlandia/models/game.dart';
import 'package:projeto_nerdlandia/models/game_list.dart';
import 'package:projeto_nerdlandia/my_icons.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class CreateAnnounceScreen extends StatefulWidget {
  const CreateAnnounceScreen({Key key}) : super(key: key);

  @override
  _CreateAnnounceScreenState createState() => _CreateAnnounceScreenState();
}

class _CreateAnnounceScreenState extends State<CreateAnnounceScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _platformTypeFocus = FocusNode();
  final _ageRestrictionFocus = FocusNode();
  final _genderFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;

  final List<Map<String, dynamic>> _platformTypeItems = [
    {
      'value': 'PS4',
      'label': 'PS4',
      'textStyle': TextStyle(color: Colors.blue),
    },
    {
      'value': 'XBOX',
      'label': 'XBOX',
      'textStyle': TextStyle(color: Colors.green),
    },
    {
      'value': 'PC',
      'label': 'PC',
      'textStyle': TextStyle(color: Colors.brown),
    },
  ];

  final List<Map<String, dynamic>> _ageRestrictionItems = [
    {
      'value': 'Livre',
      'label': 'Livre',
      'textStyle': TextStyle(color: Colors.green),
    },
    {
      'value': '+7',
      'label': '+7',
      'textStyle': TextStyle(color: Colors.limeAccent[400]),
    },
    {
      'value': '+12',
      'label': '+12',
      'textStyle': TextStyle(color: Colors.yellow),
    },
    {
      'value': '+16',
      'label': '+16',
      'textStyle': TextStyle(color: Colors.amber),
    },
    {
      'value': '+18',
      'label': '+18',
      'textStyle': TextStyle(color: Colors.red),
    },
  ];

  final List<Map<String, dynamic>> _genderItems = [
    {
      'value': 'Ação',
      'label': 'Ação',
    },
    {
      'value': 'Aventura',
      'label': 'Aventura',
    },
    {
      'value': 'Corrida',
      'label': 'Corrida',
    },
    {
      'value': 'Esporte',
      'label': 'Esporte',
    },
    {
      'value': 'Estratégia',
      'label': 'Estratégia',
    },
    {
      'value': 'Luta',
      'label': 'Luta',
    },
    {
      'value': 'Música',
      'label': 'Música',
    },
    {
      'value': 'Puzzle',
      'label': 'Puzzle',
    },
    {
      'value': 'Romance',
      'label': 'Romance',
    },
    {
      'value': 'Simulação',
      'label': 'Simulação',
    },
    {
      'value': 'Suspense',
      'label': 'Suspense',
    },
    {
      'value': 'Tabuleiro',
      'label': 'Tabuleiro',
    },
    {
      'value': 'Terror',
      'label': 'Terror',
    },
    {
      'value': 'Tiro',
      'label': 'Tiro',
    },
  ];

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context).settings.arguments;

      if (arg != null) {
        final product = arg as Game;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['platformType'] = product.platformType;
        _formData['ageRestriction'] = product.ageRestriction;
        _formData['gender'] = product.gender;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _platformTypeFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<GameList>(
        context,
        listen: false,
      ).saveProduct(_formData);

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar o produto.'),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';

                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }

                        if (name.trim().length < 3) {
                          return 'Nome precisa no mínimo de 3 letras.';
                        }

                        return null;
                      },
                    ),
                    SelectFormField(
                      type: SelectFormFieldType.dropdown,
                      labelText: 'Plataforma',
                      items: _platformTypeItems,
                      initialValue: _formData['platformType'].toString(),
                      onSaved: (platformType) =>
                          _formData['platformType'] = platformType ?? '',
                      validator: (_platformType) {
                        final platformType = _platformType ?? '';

                        if (platformType.toString() == "") {
                          return 'Plataforma é obrigatória.';
                        }

                        return null;
                      },
                    ),
                    SelectFormField(
                      type: SelectFormFieldType.dropdown,
                      labelText: 'Gênero',
                      items: _genderItems,
                      initialValue: _formData['gender'].toString(),
                      onSaved: (gender) => _formData['gender'] = gender ?? '',
                      validator: (_gender) {
                        final gender = _gender ?? '';

                        if (gender.toString() == "") {
                          return 'Gênero é obrigatório.';
                        }

                        return null;
                      },
                    ),
                    SelectFormField(
                      type: SelectFormFieldType.dropdown,
                      labelText: 'Restrição de Idade',
                      items: _ageRestrictionItems,
                      initialValue: _formData['ageRestriction'].toString(),
                      onSaved: (ageRestriction) =>
                          _formData['ageRestriction'] = ageRestriction ?? '',
                      validator: (_ageRestriction) {
                        final ageRestriction = _ageRestriction ?? '';

                        if (ageRestriction.toString() == "") {
                          return 'Restrição de idade é obrigatória.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço válido.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: InputDecoration(labelText: 'Descrição'),
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';

                        if (description.trim().isEmpty) {
                          return 'Descrição é obrigatória.';
                        }

                        if (description.trim().length < 10) {
                          return 'Descrição precisa no mínimo de 10 letras.';
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Url da Imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';

                              if (!isValidImageUrl(imageUrl)) {
                                return 'Informe uma Url válida!';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? Text('Informe a Url')
                              : Image.network(_imageUrlController.text),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
