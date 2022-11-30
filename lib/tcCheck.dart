import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class Tckimliknvigovtr {
  late String dogumYili, Ad, Soyad, TcNo;

  Tckimliknvigovtr(
      {required this.dogumYili,
        required this.Ad,
        required this.Soyad,
        required this.TcNo});

  Future<String> getCheck() async {
    var forConversion = Xml2Json();
    String soap = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <TCKimlikNoDogrula xmlns="http://tckimlik.nvi.gov.tr/WS">
      <TCKimlikNo>${this.TcNo}</TCKimlikNo>
      <Ad>${this.Ad}</Ad>
      <Soyad>${this.Soyad}</Soyad>
      <DogumYili>${this.dogumYili}</DogumYili>
    </TCKimlikNoDogrula>
  </soap:Body>
</soap:Envelope>''';

    var apiUrl = Uri.parse("https://tckimlik.nvi.gov.tr/Service/KPSPublic.asmx");

    var webReply = await http.post(
      apiUrl,
      headers: {
        'Host': 'tckimlik.nvi.gov.tr',
        'Content-Type': 'text/xml; charset=utf-8',
        'Content-Length': utf8.encode(soap).length.toString(),
        'SOAPAction': 'http://tckimlik.nvi.gov.tr/WS/TCKimlikNoDogrula',
      },
      body: utf8.encode(soap),
    );

    forConversion.parse(webReply.body);
    var jsonString = forConversion.toParker();
    Map mainData = (jsonDecode(jsonString) as Map);

    var dataSent = mainData["soap:Envelope"]["soap:Body"]["TCKimlikNoDogrulaResponse"]
    ["TCKimlikNoDogrulaResult"];

    return dataSent.toString();
  }
}
