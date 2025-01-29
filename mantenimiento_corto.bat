@echo off
:: Verificar si el script se ejecuta como administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Este script debe ejecutarse como administrador.
    pause
    exit /b
)

echo ========================================
echo Iniciando Mantenimiento Basico del Sistema
echo ========================================
echo.

echo --- Limpiando archivos temporales ---
del /s /f /q %temp%\*.*
if %errorLevel% neq 0 (
    echo Error al limpiar %temp%
) else (
    echo %temp% limpiado correctamente.
)

del /s /f /q %systemroot%\temp\*.*
if %errorLevel% neq 0 (
    echo Error al limpiar %systemroot%\temp
) else (
    echo %systemroot%\temp limpiado correctamente.
)

del /s /f /q C:\Windows\Prefetch\*.*
if %errorLevel% neq 0 (
    echo Error al limpiar C:\Windows\Prefetch
) else (
    echo C:\Windows\Prefetch limpiado correctamente.
)

del /s /f /q C:\Windows\SoftwareDistribution\Download\*.*
if %errorLevel% neq 0 (
    echo Error al limpiar C:\Windows\SoftwareDistribution\Download
) else (
    echo C:\Windows\SoftwareDistribution\Download limpiado correctamente.
)

rd /s /q %temp%
if %errorLevel% neq 0 (
    echo Error al eliminar la carpeta %temp%
) else (
    echo Carpeta %temp% eliminada correctamente.
)

md %temp%
if %errorLevel% neq 0 (
    echo Error al crear la carpeta %temp%
) else (
    echo Carpeta %temp% creada correctamente.
)

echo --- Limpieza de cache DNS ---
ipconfig /flushdns
if %errorLevel% neq 0 (
    echo Error al limpiar la cache DNS.
) else (
    echo Cache DNS limpiada correctamente.
)

echo --- Restableciendo Winsock ---
netsh winsock reset
if %errorLevel% neq 0 (
    echo Error al restablecer Winsock.
) else (
    echo Winsock restablecido correctamente.
)

echo --- Restableciendo stack TCP/IP ---
netsh int ip reset
if %errorLevel% neq 0 (
    echo Error al restablecer el stack TCP/IP.
) else (
    echo Stack TCP/IP restablecido correctamente.
)

echo ========================================
echo Mantenimiento Finalizado
echo Se recomienda reiniciar el sistema
echo ========================================

echo ¿Desea reiniciar el sistema ahora? (s/n)
set /p reiniciar=
if /i "%reiniciar%"=="s" (
    shutdown /r /t 0
) else (
    pause
)