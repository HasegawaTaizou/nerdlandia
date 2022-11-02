import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HelpCenterFrequentlyAskedQuestionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _helpCenterTipsHowToMakeGoodAd() {
      Navigator.of(context).pushNamed('/help-center-tips-how-to-make-good-ad');
    }

    void _helpCenterRules() {
      Navigator.of(context).pushNamed('/help-center-rules');
    }

    void _helpCenterChatTermsUse() {
      Navigator.of(context).pushNamed('/help-center-chat-terms-use');
    }

    return Container(
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Central de Ajuda'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 35,
                  bottom: 16.0,
                  left: 16.0,
                ),
                child: Text(
                  'Duvidas Frequentes',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.only(bottom: 16.0, left: 16.0, top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: _helpCenterTipsHowToMakeGoodAd,
                      child: Text(
                        'Dicas de como fazer um bom anúncio',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _helpCenterRules,
                      child: Text(
                        'Regras',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _helpCenterChatTermsUse,
                      child: Text(
                        'Termos de uso do Chat',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                padding: EdgeInsets.all(25),
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Ainda sobrou alguma dúvida ?'),
                    Text('Fale conosco por:'),
                    Text('E-mail: nerdlandiastudios@gmail.com'),
                    Text('Nosso telefone: 11 4002-8922'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
