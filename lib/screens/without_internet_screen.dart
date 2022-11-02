import 'package:flutter/material.dart';

class WithoutInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/passaroSemInternetScreen.png',
                  height: 330,
                  width: 330,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 26.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Text(
                  'Parece que não há internet !',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Verifique a sua conexão para continuar navegando',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tentar novamente',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
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
