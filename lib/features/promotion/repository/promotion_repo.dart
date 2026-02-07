import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/promo/promo_model.dart';
import 'package:xml/xml.dart';

class PromotionRepo with ApiHandler {
  final _url = 'https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc';

  FutureReport<List<PromoModel>> getPromos() async {
    const envelope = '''<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
         <soapenv:Header/>
         <soapenv:Body>
        <tem:GetCCPromo>
           <tem:lang>en</tem:lang>
        </tem:GetCCPromo>
         </soapenv:Body>
      </soapenv:Envelope>''';

    return handleRaw(
      call: () => client.post(
        _url,
        data: envelope.trim(),
        options: Options(
          headers: {
            'Content-Type': 'text/xml; charset=utf-8',
            'SOAPAction': 'http://tempuri.org/ICabinetMicroService/GetCCPromo',
          },
        ),
      ),
      mapper: (response) {
        cat(response, 'XML RESPONSE');

        final document = XmlDocument.parse(response.data);

        final promoElements = document.findAllElements('PromoPromoItem');

        return promoElements.map((e) => PromoModel.fromXml(e)).nonNulls.toList();
      },
    );
  }
}
