import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HelpCenterTipsHowToMakeGoodAdScreen extends StatelessWidget {
  final textoBomAnuncio = '''
Nós conectamos pessoas para que elas possam comprar e vender de forma fácil e rápida, mas não participamos ou interferimos de qualquer forma nas negociações.
Queremos que você tenha a melhor experiência possível na Nerdlândia. Por isso, veja as nossas dicas de como inserir um anúncio:
 
Imagens - Elas são essenciais em um anúncio, pois demonstram o estado do produto que você está oferecendo. 
Anúncios com fotos são vistos até 7 vezes mais, além de atraírem a atenção dos compradores.
Atenção: Não é permitido utilizar imagens que contenham links ou e-mails.
Título - Procure ser objetivo. O título deve ser a parte do anúncio que descreve o produto/serviço oferecido em poucas palavras. 
Lembre-se: O título não pode conter palavras ou símbolos que não tenham relação com o que está sendo anunciado. Exemplo: "vendo", "compro", "oportunidade", @#%*, entre outros.
Contato - Crie a sua conta usando o seu próprio e-mail e telefone. Ter contatos verídicos evita denúncias de outros usuários.
Preço - O preço é um ponto muito importante no anúncio. Por isso, sempre coloque o valor total no campo "Preço". Exemplo: Se você está vendendo um carro por 30.000,00, coloque este valor no campo e, na descrição, cite as parcelas.
Lembre-se: Se o valor apresentado no campo Preço não for referente ao valor total do produto, o seu anúncio poderá ser removido.
Campos de seleção - Em algumas categorias você poderá encontrar filtros para detalhar o produto/serviço oferecido. Isso facilita na busca dos anúncios. 
Preencha a quantidade de quartos corretamente, modelo do carro, ano etc., para que os usuários encontrem o máximo de informações.
Descrição - Descreva bem seu produto/serviço, com todas as informações que você ainda não havia detalhado nos campos anteriores. Mostre para os usuários os motivos para comprar o seu produto ou contratar o seu serviço. 
Lembre-se: Não são permitidos anúncios que contenham palavras de busca que não estão diretamente relacionadas ao produto/serviço anunciado. Links e e-mails também não são permitidos.   
''';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Central de Ajuda'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 35,
                  bottom: 16.0,
                  left: 16.0,
                ),
                child: Text(
                  'Dicas de como fazer um bom anúncio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(textoBomAnuncio),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
