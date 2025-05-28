#!/bin/bash

# Script de herramientas de pentesting para eJPTv2
# Creado por: Martín Cantero 

# Colores para el output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner ASCII
show_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
    eJPTv2 Pentesting Toolkit
    Creado por: Martín Cantero 
EOF
    echo -e "${NC}"
    echo -e "${YELLOW}========================================${NC}"
    echo -e "${GREEN}Script de herramientas para eJPTv2${NC}"
    echo -e "${YELLOW}========================================${NC}"
    echo
}

# Función para pausar y continuar
pause() {
    echo
    echo -e "${YELLOW}Presiona Enter para continuar...${NC}"
    read
}

# Función para validar IP
validate_ip() {
    local ip=$1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Función para validar URL
validate_url() {
    local url=$1
    if [[ $url =~ ^https?:// ]]; then
        return 0
    else
        return 1
    fi
}

# Función para Nmap
run_nmap() {
    echo -e "${BLUE}=== NMAP - Network Mapper ===${NC}"
    echo
    echo "Opciones disponibles:"
    echo "1. Escaneo básico de puertos"
    echo "2. Escaneo completo con detección de servicios"
    echo "3. Escaneo de vulnerabilidades"
    echo "4. Escaneo personalizado"
    echo
    read -p "Selecciona una opción (1-4): " nmap_option
    
    read -p "Introduce la IP o rango de red a escanear: " target
    
    if ! validate_ip "$target" && [[ ! $target =~ / ]]; then
        echo -e "${RED}IP o rango no válido${NC}"
        pause
        return
    fi
    
    case $nmap_option in
        1)
            echo -e "${GREEN}Ejecutando escaneo básico...${NC}"
            nmap -sS -O $target
            ;;
        2)
            echo -e "${GREEN}Ejecutando escaneo completo...${NC}"
            nmap -sS -sV -O -A $target
            ;;
        3)
            echo -e "${GREEN}Ejecutando escaneo de vulnerabilidades...${NC}"
            nmap --script vuln $target
            ;;
        4)
            read -p "Introduce los parámetros personalizados para nmap: " custom_params
            echo -e "${GREEN}Ejecutando escaneo personalizado...${NC}"
            nmap $custom_params $target
            ;;
        *)
            echo -e "${RED}Opción no válida${NC}"
            ;;
    esac
    pause
}

# Función para CrackMapExec
run_crackmapexec() {
    echo -e "${BLUE}=== CrackMapExec - SMB/WinRM/SSH Testing ===${NC}"
    echo
    echo "Protocolos disponibles:"
    echo "1. SMB"
    echo "2. WinRM"
    echo "3. SSH"
    echo
    read -p "Selecciona el protocolo (1-3): " protocol_option
    
    read -p "Introduce la IP objetivo: " target_ip
    
    if ! validate_ip "$target_ip"; then
        echo -e "${RED}IP no válida${NC}"
        pause
        return
    fi
    
    case $protocol_option in
        1) protocol="smb" ;;
        2) protocol="winrm" ;;
        3) protocol="ssh" ;;
        *) echo -e "${RED}Opción no válida${NC}"; pause; return ;;
    esac
    
    echo
    echo "Opciones de ataque:"
    echo "1. Enumeración básica"
    echo "2. Ataque con credenciales"
    echo "3. Ataque de fuerza bruta"
    echo
    read -p "Selecciona una opción (1-3): " attack_option
    
    case $attack_option in
        1)
            echo -e "${GREEN}Ejecutando enumeración básica...${NC}"
            crackmapexec $protocol $target_ip
            ;;
        2)
            read -p "Usuario: " username
            read -s -p "Contraseña: " password
            echo
            echo -e "${GREEN}Ejecutando ataque con credenciales...${NC}"
            crackmapexec $protocol $target_ip -u "$username" -p "$password"
            ;;
        3)
            read -p "Archivo de usuarios (ruta completa): " user_file
            read -p "Archivo de contraseñas (ruta completa): " pass_file
            echo -e "${GREEN}Ejecutando ataque de fuerza bruta...${NC}"
            crackmapexec $protocol $target_ip -U "$user_file" -P "$pass_file"
            ;;
        *)
            echo -e "${RED}Opción no válida${NC}"
            ;;
    esac
    pause
}

# Función para SMBClient
run_smbclient() {
    echo -e "${BLUE}=== SMBClient - SMB Share Access ===${NC}"
    echo
    read -p "Introduce la IP del servidor SMB: " smb_server
    
    if ! validate_ip "$smb_server"; then
        echo -e "${RED}IP no válida${NC}"
        pause
        return
    fi
    
    echo
    echo "Opciones disponibles:"
    echo "1. Listar recursos compartidos"
    echo "2. Conectar a un recurso específico"
    echo "3. Acceso anónimo"
    echo
    read -p "Selecciona una opción (1-3): " smb_option
    
    case $smb_option in
        1)
            echo -e "${GREEN}Listando recursos compartidos...${NC}"
            smbclient -L //$smb_server -N
            ;;
        2)
            read -p "Nombre del recurso compartido: " share_name
            read -p "Usuario: " username
            echo -e "${GREEN}Conectando al recurso...${NC}"
            smbclient //$smb_server/$share_name -U $username
            ;;
        3)
            echo -e "${GREEN}Intentando acceso anónimo...${NC}"
            smbclient -L //$smb_server -N
            ;;
        *)
            echo -e "${RED}Opción no válida${NC}"
            ;;
    esac
    pause
}

# Función para Dirb
run_dirb() {
    echo -e "${BLUE}=== DIRB - Web Content Scanner ===${NC}"
    echo
    read -p "Introduce la URL objetivo (ej: http://example.com): " target_url
    
    if ! validate_url "$target_url"; then
        echo -e "${RED}URL no válida. Debe empezar con http:// o https://${NC}"
        pause
        return
    fi
    
    echo
    echo "Diccionarios disponibles:"
    echo "1. Común (/usr/share/dirb/wordlists/common.txt)"
    echo "2. Grande (/usr/share/dirb/wordlists/big.txt)"
    echo "3. Personalizado"
    echo
    read -p "Selecciona el diccionario (1-3): " dict_option
    
    case $dict_option in
        1)
            wordlist="/usr/share/dirb/wordlists/common.txt"
            ;;
        2)
            wordlist="/usr/share/dirb/wordlists/big.txt"
            ;;
        3)
            read -p "Ruta del diccionario personalizado: " wordlist
            ;;
        *)
            echo -e "${RED}Opción no válida${NC}"
            pause
            return
            ;;
    esac
    
    echo -e "${GREEN}Ejecutando DIRB contra $target_url...${NC}"
    dirb $target_url $wordlist
    pause
}

# Función para Hydra
run_hydra() {
    echo -e "${BLUE}=== Hydra - Password Cracking Tool ===${NC}"
    echo
    echo "Servicios disponibles:"
    echo "1. SSH"
    echo "2. FTP"
    echo "3. HTTP-GET"
    echo "4. HTTP-POST"
    echo "5. SMB"
    echo
    read -p "Selecciona el servicio (1-5): " service_option
    
    read -p "Introduce la IP objetivo: " target_ip
    
    if ! validate_ip "$target_ip"; then
        echo -e "${RED}IP no válida${NC}"
        pause
        return
    fi
    
    case $service_option in
        1) service="ssh" ;;
        2) service="ftp" ;;
        3) service="http-get" ;;
        4) service="http-post-form" ;;
        5) service="smb" ;;
        *) echo -e "${RED}Opción no válida${NC}"; pause; return ;;
    esac
    
    echo
    echo "Modo de ataque:"
    echo "1. Usuario específico"
    echo "2. Lista de usuarios"
    echo
    read -p "Selecciona el modo (1-2): " user_mode
    
    if [ "$user_mode" = "1" ]; then
        read -p "Usuario: " username
        user_param="-l $username"
    else
        read -p "Archivo de usuarios: " user_file
        user_param="-L $user_file"
    fi
    
    read -p "Archivo de contraseñas: " pass_file
    
    echo -e "${GREEN}Ejecutando Hydra...${NC}"
    hydra $user_param -P $pass_file $target_ip $service
    pause
}

# Función para John the Ripper
run_john() {
    echo -e "${BLUE}=== John the Ripper - Password Cracker ===${NC}"
    echo
    echo "Opciones disponibles:"
    echo "1. Crackear archivo de hashes"
    echo "2. Mostrar contraseñas crackeadas"
    echo "3. Generar wordlist con reglas"
    echo
    read -p "Selecciona una opción (1-3): " john_option
    
    case $john_option in
        1)
            read -p "Archivo de hashes: " hash_file
            echo
            echo "Modos de ataque:"
            echo "1. Wordlist"
            echo "2. Incremental"
            echo "3. Single crack"
            echo
            read -p "Selecciona el modo (1-3): " attack_mode
            
            case $attack_mode in
                1)
                    read -p "Archivo de wordlist: " wordlist
                    echo -e "${GREEN}Ejecutando ataque con wordlist...${NC}"
                    john --wordlist=$wordlist $hash_file
                    ;;
                2)
                    echo -e "${GREEN}Ejecutando ataque incremental...${NC}"
                    john --incremental $hash_file
                    ;;
                3)
                    echo -e "${GREEN}Ejecutando single crack...${NC}"
                    john --single $hash_file
                    ;;
                *)
                    echo -e "${RED}Opción no válida${NC}"
                    ;;
            esac
            ;;
        2)
            read -p "Archivo de hashes: " hash_file
            echo -e "${GREEN}Mostrando contraseñas crackeadas...${NC}"
            john --show $hash_file
            ;;
        3)
            read -p "Wordlist base: " base_wordlist
            read -p "Archivo de salida: " output_file
            echo -e "${GREEN}Generando wordlist con reglas...${NC}"
            john --wordlist=$base_wordlist --rules --stdout > $output_file
            echo "Wordlist generada en: $output_file"
            ;;
        *)
            echo -e "${RED}Opción no válida${NC}"
            ;;
    esac
    pause
}

# Función para Enum4linux
run_enum4linux() {
    echo -e "${BLUE}=== Enum4linux - SMB Enumeration ===${NC}"
    echo
    read -p "Introduce la IP objetivo: " target_ip
    
    if ! validate_ip "$target_ip"; then
        echo -e "${RED}IP no válida${NC}"
        pause
        return
    fi
    
    echo
    echo "Opciones de enumeración:"
    echo "1. Enumeración completa (-a)"
    echo "2. Solo usuarios (-U)"
    echo "3. Solo recursos compartidos (-S)"
    echo "4. Solo información del sistema (-o)"
    echo "5. Personalizada"
    echo
    read -p "Selecciona una opción (1-5): " enum_option
    
    case $enum_option in
        1)
            echo -e "${GREEN}Ejecutando enumeración completa...${NC}"
            enum4linux -a $target_ip
            ;;
        2)
            echo -e "${GREEN}Enumerando usuarios...${NC}"
            enum4linux -U $target_ip
            ;;
        3)
            echo -e "${GREEN}Enumerando recursos compartidos...${NC}"
            enum4linux -S $target_ip
            ;;
        4)
            echo -e "${GREEN}Obteniendo información del sistema...${NC}"
            enum4linux -o $target_ip
            ;;
        5)
            read -p "Introduce los parámetros personalizados: " custom_params
            echo -e "${GREEN}Ejecutando enumeración personalizada...${NC}"
            enum4linux $custom_params $target_ip
            ;;
        *)
            echo -e "${RED}Opción no válida${NC}"
            ;;
    esac
    pause
}

# Función para WPScan
run_wpscan() {
    echo -e "${BLUE}=== WPScan - WordPress Security Scanner ===${NC}"
    echo
    read -p "Introduce la URL del sitio WordPress (ej: http://example.com): " wp_url
    
    if ! validate_url "$wp_url"; then
        echo -e "${RED}URL no válida. Debe empezar con http:// o https://${NC}"
        pause
        return
    fi
    
    echo
    echo "Opciones de escaneo:"
    echo "1. Escaneo básico"
    echo "2. Enumerar usuarios"
    echo "3. Enumerar plugins vulnerables"
    echo "4. Enumerar temas vulnerables"
    echo "5. Ataque de fuerza bruta"
    echo
    read -p "Selecciona una opción (1-5): " wp_option
    
    case $wp_option in
        1)
            echo -e "${GREEN}Ejecutando escaneo básico...${NC}"
            wpscan --url $wp_url
            ;;
        2)
            echo -e "${GREEN}Enumerando usuarios...${NC}"
            wpscan --url $wp_url --enumerate u
            ;;
        3)
            echo -e "${GREEN}Enumerando plugins vulnerables...${NC}"
            wpscan --url $wp_url --enumerate vp
            ;;
        4)
            echo -e "${GREEN}Enumerando temas vulnerables...${NC}"
            wpscan --url $wp_url --enumerate vt
            ;;
        5)
            read -p "Usuario objetivo: " wp_user
            read -p "Archivo de contraseñas: " wp_passlist
            echo -e "${GREEN}Ejecutando ataque de fuerza bruta...${NC}"
            wpscan --url $wp_url --usernames $wp_user --passwords $wp_passlist
            ;;
        *)
            echo -e "${RED}Opción no válida${NC}"
            ;;
    esac
    pause
}

# Menú principal
main_menu() {
    while true; do
        show_banner
        echo -e "${PURPLE}Herramientas disponibles:${NC}"
        echo
        echo "1.  Nmap - Network Mapper"
        echo "2.  CrackMapExec - Network Service Testing"
        echo "3.  SMBClient - SMB Share Access"
        echo "4.  Dirb - Web Content Scanner"
        echo "5.  Hydra - Password Cracking"
        echo "6.  John the Ripper - Password Cracker"
        echo "7.  Enum4linux - SMB Enumeration"
        echo "8.  WPScan - WordPress Scanner"
        echo "9.  Salir"
        echo
        echo -e "${YELLOW}========================================${NC}"
        
        read -p "Selecciona una herramienta (1-9): " choice
        
        case $choice in
            1) run_nmap ;;
            2) run_crackmapexec ;;
            3) run_smbclient ;;
            4) run_dirb ;;
            5) run_hydra ;;
            6) run_john ;;
            7) run_enum4linux ;;
            8) run_wpscan ;;
            9) 
                echo -e "${GREEN}¡Gracias por usar el toolkit eJPTv2!${NC}"
                echo -e "${CYAN}Creado por: ByRex03${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Opción no válida. Por favor, selecciona un número del 1 al 9.${NC}"
                pause
                ;;
        esac
    done
}

# Verificar si las herramientas están instaladas
check_tools() {
    tools=("nmap" "crackmapexec" "smbclient" "dirb" "hydra" "john" "enum4linux" "wpscan")
    missing_tools=()
    
    for tool in "${tools[@]}"; do
        if ! command -v $tool &> /dev/null; then
            missing_tools+=($tool)
        fi
    done
    
    if [ ${#missing_tools[@]} -ne 0 ]; then
        echo -e "${RED}Las siguientes herramientas no están instaladas:${NC}"
        printf '%s\n' "${missing_tools[@]}"
        echo
        echo -e "${YELLOW}Instálalas antes de usar este script.${NC}"
        pause
    fi
}

# Función principal
main() {
    # Verificar si se ejecuta como root
    if [ "$EUID" -ne 0 ]; then
        echo -e "${YELLOW}Advertencia: Algunas herramientas requieren privilegios de root.${NC}"
        echo -e "${YELLOW}Considera ejecutar el script con sudo.${NC}"
        pause
    fi
    
    # Verificar herramientas
    check_tools
    
    # Mostrar menú principal
    main_menu
}

# Ejecutar script
main
