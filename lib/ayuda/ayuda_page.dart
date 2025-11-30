import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AyudaPage extends StatefulWidget {
  AyudaPage({Key? key}) : super(key: key);

  @override
  State<AyudaPage> createState() => _AyudaPageState();
}

class _AyudaPageState extends State<AyudaPage> {
  Uri sharepoint = Uri.parse('https://enelcom.sharepoint.com/sites/ProjectManagementConstructionColombia/cm/SitePages/FEM.aspx');
  Uri inicioSesion = Uri.parse('https://enelcom.sharepoint.com/:v:/s/ProjectManagementConstructionColombia/pp&c/ES2fsgWApMdMs97nnCYN7HgBfRukQod6NpjOOEg9zpl54w?e=1P7etw');
  Uri funcionalidadesJulio = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EX4CHUZiFQBDrs86c8n2Fe0ByWgZNzN3e7dlbz7MQYaG9A?e=fsSQhZ');
  Uri pedidoMaterial = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EV1Hubi5dZBDoexOomSrlRcBN-7DKAd8_XFYYza3RhpcHA?e=nxy2fR');
  Uri agregarMaterial = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EaGwAp-MeZRNrAUFSsGuCDoBjggeB7N2DYzyAIBeJH4UjQ?e=xhBOPw');
  Uri cambiosFichas = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EZiT0UDGuJZDkU60musO1ygB8VfDBNZ2znQxnhgJBQQTTQ?e=8aCUOi');
  Uri versionesDisponibilidad = Uri.parse('https://enelcom.sharepoint.com/:v:/s/ProjectManagementConstructionColombia/pp&c/EU1mC0MyzGVKioxXGhB2r2UBINRe4nE_ccdIut6GQADH9g?e=Gkc9Oq');
  Uri desplazarUnidades = Uri.parse('https://enelcom.sharepoint.com/:v:/s/ProjectManagementConstructionColombia/pp&c/ERGGzWwTGINGuTkfd3YkqeABq9gH3rRo3uqk315fKYT3ng?e=OInKTs');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Más información'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: ()async{ await launchUrl(sharepoint);}, child: const Text('Información General Sharepoint')),
            ElevatedButton(onPressed: ()async{ await launchUrl(inicioSesion);}, child: const Text('Inicio de sesión')),
            ElevatedButton(onPressed: ()async{ await launchUrl(funcionalidadesJulio);}, child: const Text('Funcionalidades Julio')),
            ElevatedButton(onPressed: ()async{ await launchUrl(pedidoMaterial);}, child: const Text('Pedido de material')),
            ElevatedButton(onPressed: ()async{ await launchUrl(agregarMaterial);}, child: const Text('Agregar material')),
            ElevatedButton(onPressed: ()async{ await launchUrl(cambiosFichas);}, child: const Text('Cambios en fichas')),
            ElevatedButton(onPressed: ()async{ await launchUrl(versionesDisponibilidad);}, child: const Text('Versiones y disponibilidad')),
            ElevatedButton(onPressed: ()async{ await launchUrl(desplazarUnidades);}, child: const Text('Desplazar unidades')),
          ],
        ),
      ),
    );
  }
}