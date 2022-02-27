import 'dart:io';

import 'package:http/http.dart';

void main() async {
  String baseUrl = 'https://www.google.com/search?q=';
  String search = 'SWEETASS+-+Si+Kiwi';
  String extraUrl =
      '&client=firefox-b-d&channel=trow5&sxsrf=APq-WBt2TN7f4Vr4BTGF6Zf7uuUauyWP9w:1645805213355&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiAvvGYnpv2AhUSzDgGHVzDCaYQ_AUoAXoECBMQAw&biw=1922&bih=1999&dpr=1';

  // https://www.google.com/search?q=SWEETASS+-+Si+Kiwi&client=firefox-b-d&channel=trow5&sxsrf=APq-WBt2TN7f4Vr4BTGF6Zf7uuUauyWP9w:1645805213355&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiAvvGYnpv2AhUSzDgGHVzDCaYQ_AUoAXoECBMQAw&biw=1922&bih=1999&dpr=1
  Response response = await get(Uri.parse(baseUrl + search + extraUrl));

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);
  }

  await File('output.txt').writeAsString(response.body);
}
