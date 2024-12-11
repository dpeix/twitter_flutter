import 'package:flutter/material.dart';
import 'pages/home_page.dart'; 

void main() {
  runApp(const TwitterClone());
}

class TwitterClone extends StatelessWidget {
  const TwitterClone({super.key});

  static const url = 'https://std30.beaypeyrat.com'; // Replace with your API endpoint
  static const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE3MzM4MzcxMDcsImV4cCI6MTczMzg0MDcwNywicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImFkbWluIn0.OpGioPIQ6hrdJFt9AZ6Wjm4RUNRQ3dZz-qUQAUlgvBUsXlIYPWdxqm7aBLPDHkfMiLqyv6rgwWuuDob0K35t55jhfd6iEqV8j2LjHVVpOio_wDKIqp9pQuk3fg_L5rkzQ2lNDJfbrXWr7L73sFlQ_NbUtKibSy3QxUh7UP5s-JDCZ_SdePVPWUW49YiSovviZkLXT3ks3rZ8eeO-mtNQ1t7hk8F1uvOwaIxvC4Zy2ojTd-g4WlNTHxtXU5ETtWwn0bI5Txr_icum6X2VAGh03frQIUvOTycM8ip9EaDLXQJkPhosrs1FCgg9TiSutdtHB_3BNtwNv0IR0ts1UiZ9kg';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TwitterHomePage(),
    );
  }
}

