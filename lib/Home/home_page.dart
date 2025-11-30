// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

// import 'package:fem_app/codigosconcomplementos/view/codigosconcomplementos_page.dart';
import 'package:fem_app/codigosporaprobar/view/codigosporaprobar_page.dart';
import 'package:fem_app/disponibilidadgrafica/view/disponibilidadgrafica_page.dart';
import 'package:fem_app/historico/view/historico_page.dart';
import 'package:fem_app/oe_mes/view/oemes_page2.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transition;
import 'package:fem_app/aportacion/view/aportacion_page.dart';
import 'package:fem_app/budget/view/budget_page.dart';
import 'package:fem_app/codigosadicionales/view/codigosadicionales_page.dart';
import 'package:fem_app/disponibilidad/view/disponibilidad_page.dart';
import 'package:fem_app/extratemp/view/extra_list_page.dart';
import 'package:fem_app/extratemp/view/extra_page.dart';
import 'package:fem_app/fechas_fem/view/fechasfem_page.dart';
import 'package:fem_app/mm60/view/mm60_page.dart';
import 'package:fem_app/version.dart';
import 'package:fem_app/nuevo/view/nuevo_page.dart';
import 'package:fem_app/oe/view/oe_page.dart';
import 'package:fem_app/pdis/view/pdis_page.dart';
import 'package:fem_app/pedidos/view/pedidos_page.dart';
import 'package:fem_app/plataforma/view/plataforma_page.dart';
import 'package:fem_app/sustitutos/view/sustitutos_page.dart';
// import 'package:fem_app/versiones/versiones_page.dart';
import 'package:fem_app/wbe/view/wbe_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../alertaproyecto/view/alertaproyecto_page.dart';
import '../analisiscodigo/view/analisiscodigo_page.dart';
import '../ayuda/ayuda_page.dart';
import '../bloc/main_bloc.dart';
import '../codigoshabilitados/view/codigoshabilitados_page.dart';
import '../codigosoficiales/view/codigosoficiales_page.dart';
import '../desplazartiempo/view/desplazartiempo_page.dart';
import '../estudiosolicitudes/general/view/estudiosol_page.dart';
import '../ficha/main/fichas/view/fichas_page.dart';
import '../busquedafichase4e/view/busquedafichase4e_page.dart';
import '../gestorusuarios/view/gestorusuraios_page.dart';
import '../user/view/user_page.dart';
import '../versiones/view/versiones_page.dart';
import 'dialog/home_page_cambiar_color.dart';
import 'widgets/home_page_fila_widgets.dart';
import 'widgets/home_page_mensaje.dart';
import 'widgets/home_page_simple_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('mensaje');

  @override
  void initState() {
    FirebaseAnalytics.instance.logLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 16,
        );
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Version().data,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              "Conectado como: ${FirebaseAuth.instance.currentUser!.email}" +
                  "\n Fecha y hora: ${DateTime.now().toString().substring(0, 16)}, " +
                  "Página actual: Home",
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.right,
            )
          ],
        ),
      ],
      appBar: AppBar(
        title: const Text('FEM'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: BlocSelector<MainBloc, MainState, bool>(
            selector: (state) => state.isLoading,
            builder: (context, state) {
              // print('called');
              return state ? const LinearProgressIndicator() : const SizedBox();
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              var url = Uri.parse('https://fem2pmc.web.app/');
              await launchUrl(url);
            },
            child: Text('Versión\nActual', textAlign: TextAlign.center),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Get.to(
                AyudaPage(),
                transition: transition.Transition.cupertino,
              );
            },
            child: const Text(
              'Más \nInformación',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<MainBloc>().load();
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const CambiarColorApp(),
            ),
            icon: const Icon(Icons.color_lens),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              BlocProvider.of<MainBloc>(context).add(ThemeChange());
            },
            icon: const Icon(Icons.brightness_4_outlined),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const UserPage();
              }));
            },
            icon: const Icon(Icons.account_circle),
          ),
          ElevatedButton(
            child: const Center(
              child: Text(
                'Cerrar\nSesión',
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            int porcentaje = state.porcentajecarga;
            String cargaFichas2 = porcentaje == 102 ? '' : '($porcentaje%)';
            String porcentajeDisponibilidad =
                state.porcentajecargadisponibilidad ?? '0%';
            String cargaDisponibilidad = porcentajeDisponibilidad == '100%'
                ? ''
                : '($porcentajeDisponibilidad)';

            List<String> permisos = state.user!.permisos;
            bool esContratista = state.user!.perfil == 'contratista';
            // bool usarFem = state.user!.perfil == 'contratista';
            //Guard para que no se muestre la pantalla a los contratistas por ahora
            if (esContratista) {
              return const Center(
                child: SelectableText(
                  'Si ve este mensaje su perfil no tiene acceso a la información de FEM, favor comunicarse con yuly.barretorodriguez@enel.com, para solucionarlo',
                  textAlign: TextAlign.center,
                ),
              );
            }
            // print('permisos: $permisos');
            // print('permisos.contains("nuevo"): ${permisos.contains("nuevo")}');
            // print('porcentaje: $porcentaje');
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(2),
                const MensajeFirebase(),
                const Gap(6),
                Text("Fichas de Equipos y Materiales", style: titleStyle),
                FilaWidgets(
                  children: [
                    SimpleCard(
                      disabled: state.fichas == null,
                      page: const FichasPage(),
                      title: "Fichas2 $cargaFichas2",
                      image: 'images/project.png',
                      mediumOpacity: true,
                      isSecondary: true,
                    ),
                    // SimpleCard(
                    //   disabled: state.fichas == null,
                    //   page: const FemPage(),
                    //   title: "Fichas",
                    //   image: 'images/gantt-chart.png',
                    //   isSecondary: true,
                    // ),
                    SimpleCard(
                      disabled: state.disponibilidad == null ||
                          !permisos.contains('nuevo'),
                      page: const NuevoPage(),
                      title: "Nuevo",
                      image: 'images/new.png',
                      isSecondary: true,
                    ),
                    Tooltip(
                      message: "Actualizar para ver últimos cambios",
                      child: SimpleCard(
                        disabled: state.fem == null,
                        page: const PedidosPage(),
                        title: "Pedidos",
                        image: 'images/fastdelivery.png',
                      ),
                    ),
                    // const VerticalDivider(
                    //   color: Colors.grey,
                    //   thickness: 1,
                    // ),
                  ],
                ),
                const Gap(8),
                FilaWidgets(
                  children: [
                    SimpleCard(
                      disabled: state.nuevo == null,
                      page: const ExtraPage(),
                      title: "ExtraTemporal",
                      image: 'images/emergency.png',
                      isSecondary: true,
                    ),
                    SimpleCard(
                      disabled: state.extra == null,
                      page: const PedidosExtraPage(),
                      title: "Listado Extra",
                      image: 'images/prioritize.png',
                    ),
                    SimpleCard(
                      disabled: false,
                      page: const EstudioSolPage(),
                      title: "Estudio Solicitudes",
                      image: 'images/ok_icon.png',
                      esPermitido: permisos.contains('aprobar_solicitudes'),
                    ),
                    SimpleCard(
                      disabled: state.fem == null,
                      page: const DesplazarTiempoPage(),
                      title: "Desplazar Tiempo",
                      image: 'images/shift.png',
                      esPermitido: permisos.contains('aprobar_solicitudes'),
                    ),
                  ],
                ),
                const Gap(12),
                Text("Planificación", style: titleStyle),
                FilaWidgets(
                  children: [
                    SimpleCard(
                      disabled: state.versiones == null,
                      page: const VersionOficialPage(),
                      title: "Versiones Oficiales",
                      image: 'images/version.png',
                    ),
                    SimpleCard(
                      disabled: state.disponibilidad == null,
                      page: const DisponibilidadPage(),
                      title: "Disponibilidad$cargaDisponibilidad",
                      image: 'images/delivery-box.png',
                      mediumOpacity: true,
                      isSecondary: true,
                    ),
                    SimpleCard(
                      disabled: state.disponibilidad == null,
                      page: const AnalisisCodigoPage(),
                      title: "Detalle Disponibilidad",
                      image: 'images/prediction.png',
                      isSecondary: true,
                    ),
                    SimpleCard(
                      disabled: state.disponibilidad == null,
                      page: const DisponibilidadGraficaPage(),
                      // fun: () => launchUrl(
                      //   Uri.parse(
                      //     'https://lookerstudio.google.com/reporting/9804dafb-214c-4cea-b04e-072708438172',
                      //   ),
                      // ),
                      title: "Gráfica",
                      image: 'images/chart.png',
                      isSecondary: true,
                      // color: Colors.white,
                    ),
                    SimpleCard(
                      disabled: state.alertaProyectos == null,
                      page: const AlertaProyectosPage(),
                      title: "Alerta por proyecto",
                      image: 'images/danger.png',
                    ),
                    SimpleCard(
                      disabled: state.fechasFEM == null,
                      page: const FechasFEMPage(),
                      title: "Fechas FEM",
                      image: 'images/schedule2.png',
                    ),
                  ],
                ),
                const Gap(12),
                Text("Presupuesto", style: titleStyle),
                const Gap(12),
                FilaWidgets(
                  children: [
                    SimpleCard(
                      disabled: state.budget == null,
                      page: const BudgetPage(),
                      title: "Budget",
                      image: 'images/salary.png',
                    ),
                    SimpleCard(
                      disabled: state.fem == null,
                      page: const BusquedaFichasE4ePage(),
                      title: "Búsqueda Fichas E4E",
                      image: 'images/se.png',
                      isSecondary: true,
                    ),
                  ],
                ),
                const Gap(12),
                Text("Códigos Material", style: titleStyle),
                FilaWidgets(
                  children: [
                    SimpleCard(
                      disabled: state.codigosOficiales == null,
                      page: const CodigosOficialesPage(),
                      title: "Códigos Oficiales",
                      image: 'images/codigosoficiales.png',
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('+'),
                      ],
                    ),
                    SimpleCard(
                      disabled: state.codigosAdicionales == null,
                      page: const CodigosAdicionalesPage(),
                      title: "Códigos Adicionales",
                      image: 'images/folder.png',
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('='),
                      ],
                    ),
                    SimpleCard(
                      disabled: state.codigosHabilitados == null,
                      page: const CodigosHabilitadosPage(),
                      title: "Códigos Habilitados",
                      image: 'images/approved.png',
                    ),
                  ],
                ),
                const Gap(5),
                FilaWidgets(
                  children: [
                    SimpleCard(
                      disabled: state.aportacion == null,
                      page: const AportacionPage(),
                      title: "Aportación",
                      image: 'images/aportacion.png',
                    ),
                    SimpleCard(
                      disabled: state.sustitutos == null,
                      page: const SustitutosPage(),
                      title: "Sustitutos",
                      image: 'images/replacement.png',
                    ),
                    SimpleCard(
                      disabled: state.codigosPorAprobar == null,
                      page: const CodigosPorAprobarPage(),
                      title: "Códigos por Aprobar",
                      image: "images/poraprobar.png",
                    ),
                    // SimpleCard(
                    //   disabled: state.codigosConComplementos == null,
                    //   page: const CodigosConComplementosPage(),
                    //   title: "Códigos Complementos",
                    //   image: "images/complementary.png",
                    // ),
                  ],
                ),
                const Gap(12),
                Text("Datos de SAP", style: titleStyle),
                FilaWidgets(
                  children: [
                    SimpleCard(
                      disabled: state.plataforma == null,
                      page: const PlataformaPage(),
                      title: "Plataforma",
                      image: 'images/warehouse.png',
                    ),
                    SimpleCard(
                      disabled: state.oe == null,
                      page: const OePage(),
                      title: "Órdenes",
                      image: 'images/order.png',
                    ),
                    SimpleCard(
                      disabled: state.oeMes == null,
                      page: const OeMesPage2(),
                      title: "Órdenes Mes",
                      image: 'images/schedule.png',
                    ),
                    SimpleCard(
                      disabled: state.mm60 == null,
                      page: const Mm60Page(),
                      title: "MM60",
                      image: 'images/inventory.png',
                    ),
                    SimpleCard(
                      disabled: state.wbe == null,
                      page: const WbePage(),
                      title: "WBE",
                      image: 'images/diagram.png',
                    ),
                  ],
                ),
                const Gap(12),
                Text("Datos generales", style: titleStyle),
                FilaWidgets(
                  children: [
                    SimpleCard(
                      disabled: state.pdis == null,
                      page: const PdisPage(),
                      title: "Pdis",
                      image: 'images/pushcart.png',
                    ),
                    SimpleCard(
                      disabled: false,
                      page: const GestorUsuariosPage(),
                      title: "Gestor Usuarios",
                      image: 'images/network.png',
                      esPermitido: permisos.contains('gestor_usuarios'),
                    ),
                    const SimpleCard(
                      disabled: false,
                      page: HistoricoPage(),
                      title: "Histórico (2022-2024)",
                      image: 'images/his.png',
                    ),
                    SimpleCard(
                      disabled: false,
                      page: null,
                      fun: () => launchUrl(
                        Uri.parse(
                          'https://enelcom.sharepoint.com/sites/FEM',
                        ),
                      ),
                      title: "Noticias",
                      image: 'images/news.png',
                      color: Colors.blue[100],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
