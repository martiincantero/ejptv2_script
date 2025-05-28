# eJPTv2 Pentesting Toolkit

Un script completo en Bash con menú interactivo que incluye las herramientas esenciales para la preparación y aprobación del examen **eJPTv2 (eLearnSecurity Junior Penetration Tester v2)**.

## 🎯 Características

- **Menú interactivo** con selección numérica
- **Instalación automática** de herramientas faltantes
- **Validación de entradas** (IPs, URLs)
- **Interfaz colorizada** para mejor experiencia de usuario
- **Soporte multiplataforma** (Ubuntu/Debian, RHEL/CentOS/Fedora, Arch Linux)
- **Banner ASCII personalizado**

## 🛠️ Herramientas Incluidas

| Herramienta | Descripción | Uso Principal |
|-------------|-------------|---------------|
| **Nmap** | Network Mapper | Escaneo de red y puertos |
| **CrackMapExec** | Network Service Testing | Testing SMB/WinRM/SSH |
| **SMBClient** | SMB Share Access | Acceso a recursos compartidos |
| **Dirb** | Web Content Scanner | Enumeración de directorios web |
| **Hydra** | Password Cracking | Ataques de fuerza bruta |
| **John the Ripper** | Password Cracker | Crackeo de hashes |
| **Enum4linux** | SMB Enumeration | Enumeración de sistemas Linux/Windows |
| **WPScan** | WordPress Scanner | Análisis de seguridad WordPress |

## 📋 Requisitos

- **Sistema Operativo**: Linux (Ubuntu/Debian, RHEL/CentOS/Fedora, Arch Linux)
- **Privilegios**: sudo (para instalación automática de herramientas)
- **Dependencias**: bash, curl, wget

## 🚀 Instalación y Uso

### 1. Clonar el repositorio
git clone https://github.com/martiincantero/ejptv2_script.git


### 2. Dar permisos de ejecución

chmod +x ejptv2.sh

### 3. Ejecutar el script

sudo ./ejptv2.sh

> **Nota**: Se recomienda ejecutar con `sudo` para permitir la instalación automática de herramientas faltantes.

## 📖 Guía de Uso

### Menú Principal

Al ejecutar el script, se mostrará un menú con las siguientes opciones:

1. Nmap - Network Mapper
2. CrackMapExec - Network Service Testing
3. SMBClient - SMB Share Access
4. Dirb - Web Content Scanner
5. Hydra - Password Cracking
6. John the Ripper - Password Cracker
7. Enum4linux - SMB Enumeration
8. WPScan - WordPress Scanner
9. Salir
    
### Ejemplos de Uso

#### Escaneo con Nmap
- Selecciona opción `1`
- Elige tipo de escaneo (básico, completo, vulnerabilidades, personalizado)
- Introduce la IP objetivo: `192.168.1.100`

#### Enumeración web con Dirb
- Selecciona opción `4`
- Introduce URL objetivo: `http://example.com`
- Selecciona diccionario (común, grande, personalizado)

#### Ataque de fuerza bruta con Hydra
- Selecciona opción `5`
- Elige servicio (SSH, FTP, HTTP-GET, HTTP-POST, SMB)
- Introduce IP objetivo y archivos de credenciales

## 🔧 Instalación Automática

El script incluye funcionalidad de **instalación automática** que:

- **Detecta** el gestor de paquetes del sistema
- **Instala** herramientas faltantes automáticamente
- **Maneja** dependencias especiales (pip, gem)
- **Verifica** la instalación post-proceso

### Gestores de Paquetes Soportados

- `apt-get` (Ubuntu/Debian)
- `yum` (RHEL/CentOS)
- `dnf` (Fedora)
- `pacman` (Arch Linux)

## 🎓 Orientado para eJPTv2

Este toolkit está específicamente diseñado para cubrir las áreas evaluadas en el examen eJPTv2:

- **Host & Network Auditing**
- **Web Application Penetration Testing**
- **System/Host Based Attacks**
- **Network-Based Attacks**

## ⚠️ Advertencias Legales

- **Uso Ético**: Este script está diseñado únicamente para fines educativos y testing autorizado
- **Responsabilidad**: El usuario es responsable del uso apropiado de estas herramientas
- **Permisos**: Asegúrate de tener autorización explícita antes de realizar pruebas de penetración

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para contribuir:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Changelog

### v1.0.0
- Implementación inicial del toolkit
- Menú interactivo con 8 herramientas principales
- Instalación automática de dependencias
- Validación de entradas y manejo de errores

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 👨‍💻 Autor

**Martín Cantero**
- GitHub: [@martiincantero](https://github.com/martiincantero)

## 🙏 Agradecimientos

- Comunidad de eLearnSecurity
- Desarrolladores de las herramientas de pentesting incluidas
- Comunidad de seguridad informática

---

⭐ Si este proyecto te ha sido útil, ¡considera darle una estrella!
