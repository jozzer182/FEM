# 🚀 Prompt: Publicar App Flutter como Repositorio Público

> **Versión:** 1.0  
> **Última actualización:** Noviembre 2024  
> **Probado con:** Flutter 3.x, Firebase, Google Apps Script

---

## 📋 Prompt Optimizado

Copia y pega este prompt adaptando los valores entre `[CORCHETES]`:

```
## Objetivo

Quiero publicar mi aplicación Flutter en un repositorio público de GitHub.
El repositorio se llamará: [NOMBRE_DEL_REPO]
Mi usuario de GitHub es: [TU_USUARIO_GITHUB]

## Contexto del Proyecto

- Framework: Flutter
- Servicios utilizados: [Firebase / Supabase / Google Apps Script / otros]
- Plataformas: [Web / Android / iOS / Desktop]

## Tareas Requeridas

### 1. Externalizar Credenciales (CRÍTICO)

Busca y externaliza TODAS las credenciales hardcodeadas:

**Patrones a buscar:**
- URLs de APIs: `script.google.com`, `supabase.co`, `firebaseio.com`
- API Keys: `apiKey`, `API_KEY`, `AIza`, `anon key`
- Secrets: `secret`, `password`, `token`
- Project IDs y configuraciones sensibles

**Implementación requerida:**
1. Agregar `flutter_dotenv` al proyecto
2. Crear clase `EnvConfig` para acceder a variables de entorno
3. Modificar TODOS los archivos que tengan credenciales hardcodeadas
4. Configurar `main.dart` para cargar dotenv antes de Firebase

### 2. Manejar Archivos de Firebase

⚠️ **ORDEN CRÍTICO DE OPERACIONES:**

1. PRIMERO actualizar `.gitignore`
2. LUEGO eliminar carpeta `.git` completamente (`rm -rf .git` o `Remove-Item -Recurse -Force .git`)
3. DESPUÉS inicializar nuevo repositorio (`git init`)
4. Verificar con `git ls-files` antes de commit
5. Solo entonces hacer commit y push

**Archivos a excluir (si contienen credenciales reales):**
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `ios/firebase_app_id_file.json`

**Archivo a INCLUIR (después de modificar para usar EnvConfig):**
- `lib/firebase_options.dart` - Debe usar variables de entorno, NO credenciales hardcodeadas

### 3. Crear Archivos de Plantilla

Crear archivos `.example` para cada archivo sensible excluido:
- `.env.example` - Plantilla de variables de entorno
- `android/app/google-services.json.example` - Plantilla Firebase Android
- Documentación clara de qué valores se necesitan

### 4. Actualizar .gitignore

```gitignore
# Environment
.env
.env.local
.env.*.local
!.env.example

# Firebase credentials (archivos con credenciales reales)
android/app/google-services.json
!android/app/google-services.json.example
ios/Runner/GoogleService-Info.plist
ios/firebase_app_id_file.json

# Firebase deployment
.firebase/
.firebaserc

# Data files potencialmente sensibles
*.csv
# Excepciones necesarias
!pubspec.lock
```

### 5. Crear README Profesional

El README debe incluir:
- Badges de tecnologías (Flutter, Dart, Firebase, etc.)
- Descripción clara del proyecto
- Screenshots/GIFs si los hay
- Lista de características principales
- Stack tecnológico
- Arquitectura del proyecto
- Instrucciones de instalación y configuración
- Sección de configuración de variables de entorno
- Información de contacto

### 6. Verificación de Seguridad (OBLIGATORIO)

Antes de hacer push, ejecutar TODAS estas verificaciones:

```bash
# 1. Verificar que .env NO está en git
git ls-files .env
# Debe retornar VACÍO

# 2. Verificar que google-services.json NO está en git
git ls-files android/app/google-services.json
# Debe retornar VACÍO

# 3. Verificar que NO hay API keys hardcodeadas en firebase_options.dart
git show HEAD:lib/firebase_options.dart | grep -E "AIza|apiKey.*=.*'"
# Debe retornar VACÍO

# 4. Verificar que archivos .example SÍ están incluidos
git ls-files | grep "\.example"
# Debe mostrar los archivos .example
```

### 7. Crear Repositorio y Push

```bash
# Crear repositorio (NO usar --push automático)
gh repo create [NOMBRE_REPO] --public --source=. --remote=origin

# Renombrar rama a main
git branch -M main

# Push manual DESPUÉS de verificaciones
git push -u origin main
```

## Notas Importantes

1. **NUNCA** usar `gh repo create --push` automático sin verificar primero
2. El historial de git es el enemigo - si los archivos sensibles ya estaban en commits, DEBES eliminar `.git/` completamente
3. Verificar SIEMPRE antes de cada push
4. El archivo `firebase_options.dart` puede incluirse SI Y SOLO SI usa EnvConfig (variables de entorno)
```

---

## 🔧 Estructura de Archivos a Crear

```
proyecto/
├── .env                              # Credenciales reales (NO subir)
├── .env.example                      # Plantilla (SÍ subir)
├── .gitignore                        # Actualizado con exclusiones
├── README.md                         # README profesional
├── lib/
│   ├── resources/
│   │   └── env_config.dart           # Clase para leer variables de entorno
│   └── firebase_options.dart         # Modificado para usar EnvConfig
├── android/
│   └── app/
│       ├── google-services.json      # (NO subir)
│       └── google-services.json.example  # Plantilla (SÍ subir)
└── docs/
    └── SETUP.md                      # Instrucciones de configuración
```

---

## 📝 Plantilla de env_config.dart

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration class to access environment variables
class EnvConfig {
  // Firebase Configuration
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  static String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';
  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get firebaseAuthDomain =>
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
  static String get firebaseDatabaseUrl =>
      dotenv.env['FIREBASE_DATABASE_URL'] ?? '';
  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  static String get firebaseMeasurementId =>
      dotenv.env['FIREBASE_MEASUREMENT_ID'] ?? '';

  // Custom APIs
  static String get apiEndpoint1 => dotenv.env['API_ENDPOINT_1'] ?? '';
  static String get apiEndpoint2 => dotenv.env['API_ENDPOINT_2'] ?? '';
}
```

---

## 📝 Plantilla de .env.example

```env
# ========================================
# [NOMBRE_APP] - Environment Variables Template
# ========================================
# Copy this file to .env and fill in your values
# NEVER commit the .env file to version control

# ========================================
# Firebase Configuration
# ========================================
FIREBASE_API_KEY=your_firebase_api_key_here
FIREBASE_APP_ID=your_firebase_app_id_here
FIREBASE_MESSAGING_SENDER_ID=your_messaging_sender_id_here
FIREBASE_PROJECT_ID=your_project_id_here
FIREBASE_AUTH_DOMAIN=your_project_id.firebaseapp.com
FIREBASE_DATABASE_URL=https://your_project_id-default-rtdb.firebaseio.com
FIREBASE_STORAGE_BUCKET=your_project_id.appspot.com
FIREBASE_MEASUREMENT_ID=your_measurement_id_here

# ========================================
# Custom APIs
# ========================================
API_ENDPOINT_1=https://your-api-endpoint.com/exec
API_ENDPOINT_2=https://your-other-api.com/exec
```

---

## ⚠️ Errores Comunes a Evitar

| Error | Solución |
|-------|----------|
| Agregar `.gitignore` después de commit | Eliminar `.git/` y reiniciar |
| Usar `--push` automático | Siempre verificar antes de push manual |
| Olvidar modificar `pubspec.yaml` | Agregar `.env` a assets |
| No cargar dotenv antes de Firebase | Agregar `await dotenv.load()` al inicio de main() |
| Dejar firebase_options.dart con credenciales | Modificar para usar EnvConfig |
| **GitHub CLI (`gh`) no reconocido** | Ver sección "Problema con GitHub CLI" abajo |

---

## 🐛 Problema con GitHub CLI (Windows)

### Síntoma
Al ejecutar `gh repo create`, aparece el error:
```
gh: The term 'gh' is not recognized as a name of a cmdlet, function, script 
file, or executable program.
```

### Causa
GitHub CLI está instalado pero **no está en el PATH** de la sesión actual de terminal (común en terminales integradas de IDEs como Cursor/VS Code).

### Solución 1: Usar ruta completa (Recomendado)

```powershell
# Verificar que gh está instalado
Get-ChildItem -Path "C:\Program Files" -Recurse -Filter "gh.exe" -ErrorAction SilentlyContinue | Select-Object -First 1

# Usar ruta completa para todos los comandos gh
& "C:\Program Files\GitHub CLI\gh.exe" auth status
& "C:\Program Files\GitHub CLI\gh.exe" repo create NOMBRE_REPO --public --source=. --remote=origin
```

### Solución 2: Refrescar PATH en la sesión actual

```powershell
# Refrescar variables de entorno
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Ahora intentar gh
gh --version
```

### Solución 3: Agregar al PATH permanentemente

```powershell
# Agregar GitHub CLI al PATH del usuario
$ghPath = "C:\Program Files\GitHub CLI"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$ghPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$ghPath", "User")
}
# Reiniciar la terminal después de esto
```

### Solución 4: Reinstalar con winget

```powershell
winget install --id GitHub.cli -e --accept-source-agreements --accept-package-agreements
# Reiniciar la terminal
```

### Verificar autenticación

```powershell
# Con ruta completa
& "C:\Program Files\GitHub CLI\gh.exe" auth status

# Debería mostrar algo como:
# github.com
#   ✓ Logged in to github.com account TU_USUARIO (keyring)
#   - Active account: true

# Si no está autenticado:
& "C:\Program Files\GitHub CLI\gh.exe" auth login
```

### Comandos gh con ruta completa (referencia)

```powershell
# Crear repositorio
& "C:\Program Files\GitHub CLI\gh.exe" repo create NOMBRE --public --source=. --remote=origin

# Ver repositorio en navegador
& "C:\Program Files\GitHub CLI\gh.exe" repo view USUARIO/REPO --web

# Verificar archivos en repo remoto
& "C:\Program Files\GitHub CLI\gh.exe" api repos/USUARIO/REPO/git/trees/main?recursive=1 --jq '.tree[].path'
```

---

## ✅ Checklist Final

### Preparación del código
- [ ] `flutter_dotenv` agregado a `pubspec.yaml`
- [ ] `.env` agregado a assets en `pubspec.yaml`
- [ ] `.env` creado con credenciales reales
- [ ] `.env.example` creado como plantilla
- [ ] `env_config.dart` creado
- [ ] `firebase_options.dart` modificado para usar EnvConfig
- [ ] Todos los archivos con URLs/APIs modificados
- [ ] `main.dart` carga dotenv antes de Firebase

### Configuración de Git
- [ ] `.gitignore` actualizado
- [ ] Archivos `.example` creados para Firebase
- [ ] `.git/` eliminado y repositorio reiniciado
- [ ] `README.md` profesional creado

### Verificación de seguridad
- [ ] `git ls-files .env` retorna vacío
- [ ] `git ls-files android/app/google-services.json` retorna vacío
- [ ] `firebase_options.dart` no contiene "AIza" ni API keys hardcodeadas
- [ ] Archivos `.example` están incluidos en git

### GitHub CLI y Push
- [ ] GitHub CLI funciona (`gh --version` o usar ruta completa)
- [ ] Autenticado en GitHub (`gh auth status`)
- [ ] Repositorio creado sin `--push` automático
- [ ] Push manual realizado después de verificar

---

## 🔍 Comandos de Búsqueda Útiles

```bash
# Buscar URLs de APIs hardcodeadas
grep -r "script\.google\.com\|supabase\.co\|firebaseio\.com" lib/

# Buscar API keys
grep -r "apiKey\|API_KEY\|AIza" lib/

# Buscar todos los archivos con posibles credenciales
grep -rn "http.*://" lib/ | grep -v "flutter.dev\|dart.dev\|pub.dev\|github.com"

# Listar archivos en git que coincidan con patrones sensibles
git ls-files | grep -E "firebase|google-services|\.env$"
```

---

## 📚 Recursos Adicionales

- [flutter_dotenv documentation](https://pub.dev/packages/flutter_dotenv)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- [GitHub CLI](https://cli.github.com/)
- [Git filter-branch (para limpiar historial)](https://git-scm.com/docs/git-filter-branch)

---

*Este prompt fue creado basándose en la experiencia de publicar el proyecto FEM.*

