class AnalisisCodigo{
  int totalOe = 0;
  int totalFem = 0;
  int totalOraCe = 0;

  copyWith({int? totalOe, int? totalFem, int? totalOraCe}){
    return AnalisisCodigo()
      ..totalOe = totalOe ?? this.totalOe
      ..totalFem = totalFem ?? this.totalFem
      ..totalOraCe = totalOraCe ?? this.totalOraCe;
  }
}