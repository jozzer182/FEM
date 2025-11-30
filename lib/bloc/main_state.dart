part of '../bloc/main_bloc.dart';

class MainState {
  String mensaje;
  String message;
  String dialogMessage;
  int messageCounter;
  int errorCounter;
  Color messageColor;
  bool isLoading;
  bool isLoadingFem;
  Fem? fem;
  Plataforma? plataforma;
  Oe? oe;
  OeMes? oeMes;
  Mm60? mm60;
  Aportacion? aportacion;
  Sustitutos? sustitutos;
  Pdis? pdis;
  Personas? personas;
  Wbe? wbe;
  Pedidos? pedidos;
  Budget? budget;
  Versiones? versiones;
  FechasFEM? fechasFEM;
  Nuevo? nuevo;
  OeSum? oeSum;
  // VersionDemanda? versionDemanda;
  FemDemand? femDemand;
  // Demanda? demanda;
  Disponibilidad? disponibilidad;
  Extra? extra;
  AlertaProyectos? alertaProyectos;
  bool isDark = false;
  Color? themeColor;
  Fichas? fichas;
  Ficha? ficha;
  String? year;
  int porcentajecarga;
  String? porcentajecargadisponibilidad;
  bool cargar2023 = true;
  CodigosOficiales? codigosOficiales;
  CodigosAdicionales? codigosAdicionales;
  CodigosHabilitados? codigosHabilitados;
  User? user;
  CodigosPorAprobar? codigosPorAprobar;
  CodigosConComplementos? codigosConComplementos;
  AnalisisCodigo? analisisCodigo;
  PlataformaMb51? plataformaMb51;
  EstudioSol? estudioSol;
  DesplazarTiempo? desplazarTiempo;
  SolPeList? solPeList;
  SolPeDoc? solPeDoc;

  MainState({
    this.mensaje = '',
    this.message = '',
    this.dialogMessage = 'Mensaje de prueba',
    this.messageCounter = 0,
    this.errorCounter = 0,
    this.messageColor = Colors.red,
    this.isLoading = false,
    this.isLoadingFem = false,
    this.fem,
    this.plataforma,
    this.oe,
    this.oeMes,
    this.mm60,
    this.aportacion,
    this.sustitutos,
    this.pdis,
    this.personas,
    this.wbe,
    this.pedidos,
    this.budget,
    this.versiones,
    this.fechasFEM,
    this.nuevo,
    this.oeSum,
    // this.versionDemanda,
    this.femDemand,
    // this.demanda,
    this.disponibilidad,
    this.extra,
    this.alertaProyectos,
    this.isDark = false,
    this.themeColor,
    this.fichas,
    this.ficha,
    this.year,
    this.porcentajecarga = 0,
    this.porcentajecargadisponibilidad,
    this.cargar2023 = true,
    this.codigosOficiales,
    this.codigosAdicionales,
    this.codigosHabilitados,
    this.user,
    this.codigosPorAprobar,
    this.codigosConComplementos,
    this.analisisCodigo,
    this.plataformaMb51,
    this.estudioSol,
    this.desplazarTiempo,
    this.solPeList,
    this.solPeDoc,
  });

  initial() {
    mensaje = '';
    message = '';
    dialogMessage = '';
    messageCounter = 0;
    errorCounter = 0;
    messageColor = Colors.red;
    isLoading = false;
    isLoadingFem = false;
    fem = null;
    plataforma = null;
    oe = null;
    oeMes = null;
    mm60 = null;
    aportacion = null;
    sustitutos = null;
    pdis = null;
    personas = null;
    wbe = null;
    pedidos = null;
    budget = null;
    versiones = null;
    fechasFEM = null;
    nuevo = null;
    oeSum = null;
    // versionDemanda = null;
    femDemand = null;
    // demanda = null;
    disponibilidad = null;
    extra = null;
    alertaProyectos = null;
    isDark = false;
    themeColor = null;
    fichas = null;
    ficha = null;
    year = null;
    porcentajecarga = 0;
    porcentajecargadisponibilidad = null;
    cargar2023 = true;
    codigosOficiales = null;
    codigosAdicionales = null;
    codigosHabilitados = null;
    user = null;
    codigosPorAprobar = null;
    codigosConComplementos = null;
    analisisCodigo = AnalisisCodigo();
    plataformaMb51 = null;
    estudioSol = null;
    desplazarTiempo = DesplazarTiempo();
    solPeList = null;
    solPeDoc = null;
  }

  MainState copyWith({
    String? mensaje,
    String? message,
    String? dialogMessage,
    int? messageCounter,
    int? errorCounter,
    Color? messageColor,
    bool? isLoading,
    bool? isLoadingFem,
    Fem? fem,
    Plataforma? plataforma,
    Oe? oe,
    OeMes? oeMes,
    Mm60? mm60,
    Aportacion? aportacion,
    Sustitutos? sustitutos,
    Pdis? pdis,
    Personas? personas,
    Wbe? wbe,
    Pedidos? pedidos,
    Budget? budget,
    Versiones? versiones,
    FechasFEM? fechasFEM,
    Nuevo? nuevo,
    OeSum? oeSum,
    // VersionDemanda? versionDemanda,
    FemDemand? femDemand,
    // Demanda? demanda,
    Disponibilidad? disponibilidad,
    Extra? extra,
    AlertaProyectos? alertaProyectos,
    bool? isDark,
    Color? themeColor,
    Fichas? fichas,
    Ficha? ficha,
    String? year,
    int? porcentajecarga,
    String? porcentajecargadisponibilidad,
    bool? cargar2023,
    CodigosOficiales? codigosOficiales,
    CodigosAdicionales? codigosAdicionales,
    CodigosHabilitados? codigosHabilitados,
    User? user,
    CodigosPorAprobar? codigosPorAprobar,
    CodigosConComplementos? codigosConComplementos,
    AnalisisCodigo? analisisCodigo,
    PlataformaMb51? plataformaMb51,
    EstudioSol? estudioSol,
    DesplazarTiempo? desplazarTiempo,
    SolPeList? solPeList,
    SolPeDoc? solPeDoc,
  }) {
    return MainState(
      mensaje: mensaje ?? this.mensaje,
      message: message ?? this.message,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      messageCounter: messageCounter ?? this.messageCounter,
      errorCounter: errorCounter ?? this.errorCounter,
      messageColor: messageColor ?? this.messageColor,
      isLoading: isLoading ?? this.isLoading,
      isLoadingFem: isLoadingFem ?? this.isLoadingFem,
      fem: fem ?? this.fem,
      plataforma: plataforma ?? this.plataforma,
      oe: oe ?? this.oe,
      oeMes: oeMes ?? this.oeMes,
      mm60: mm60 ?? this.mm60,
      aportacion: aportacion ?? this.aportacion,
      sustitutos: sustitutos ?? this.sustitutos,
      pdis: pdis ?? this.pdis,
      personas: personas ?? this.personas,
      wbe: wbe ?? this.wbe,
      pedidos: pedidos ?? this.pedidos,
      budget: budget ?? this.budget,
      versiones: versiones ?? this.versiones,
      fechasFEM: fechasFEM ?? this.fechasFEM,
      nuevo: nuevo ?? this.nuevo,
      oeSum: oeSum ?? this.oeSum,
      // versionDemanda: versionDemanda ?? this.versionDemanda,
      femDemand: femDemand ?? this.femDemand,
      // demanda: demanda ?? this.demanda,
      disponibilidad: disponibilidad ?? this.disponibilidad,
      extra: extra ?? this.extra,
      alertaProyectos: alertaProyectos ?? this.alertaProyectos,
      isDark: isDark ?? this.isDark,
      themeColor: themeColor ?? this.themeColor,
      fichas: fichas ?? this.fichas,
      ficha: ficha ?? this.ficha,
      year: year ?? this.year,
      porcentajecarga: porcentajecarga ?? this.porcentajecarga,
      porcentajecargadisponibilidad:
          porcentajecargadisponibilidad ?? this.porcentajecargadisponibilidad,
      cargar2023: cargar2023 ?? this.cargar2023,
      codigosOficiales: codigosOficiales ?? this.codigosOficiales,
      codigosAdicionales: codigosAdicionales ?? this.codigosAdicionales,
      codigosHabilitados: codigosHabilitados ?? this.codigosHabilitados,
      user: user ?? this.user,
      codigosPorAprobar: codigosPorAprobar ?? this.codigosPorAprobar,
      codigosConComplementos:
          codigosConComplementos ?? this.codigosConComplementos,
      analisisCodigo: analisisCodigo ?? this.analisisCodigo,
      plataformaMb51: plataformaMb51 ?? this.plataformaMb51,
      estudioSol: estudioSol ?? this.estudioSol,
      desplazarTiempo: desplazarTiempo ?? this.desplazarTiempo,
      solPeList: solPeList ?? this.solPeList,
      solPeDoc: solPeDoc ?? this.solPeDoc,
    );
  }
}
