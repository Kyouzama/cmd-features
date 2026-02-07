@echo off
setlocal enabledelayedexpansion
title Kyouzama - 0.2
mode con: cols=110 lines=35
color 07

:: --- SETUP ANSI ESCAPE CODE (Untuk Warna & Animasi) ---
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "ESC=%%b"
)

:: --- CEK ADMIN ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo %ESC%[91m[!] ERROR: Harap jalankan script ini sebagai Administrator!%ESC%[0m
    echo.
    pause
    exit /b
)

:: --- ANIMASI INTRO (PURPLE FIRE) ---
cls
:: Frame 1: Api Biru Gelap (Ignition)
echo.
echo %ESC%[34m
call :logo_art
timeout /t 0 >nul

:: Frame 2: Ungu Gelap
cls
echo.
echo %ESC%[35m
call :logo_art
timeout /t 0 >nul

:: Frame 3: Biru Terang
cls
echo.
echo %ESC%[94m
call :logo_art
timeout /t 0 >nul

:: Frame 4: Ungu Neon (Magenta)
cls
echo.
echo %ESC%[95m
call :logo_art
timeout /t 0 >nul

:: Frame 5: Putih (Panas Maksimal)
cls
echo.
echo %ESC%[97m
call :logo_art
timeout /t 0 >nul

:: Frame 6: Stabil di Ungu Neon (Final Look)
cls
echo.
echo %ESC%[95m
call :logo_art
echo %ESC%[0m

:: --- MENU UTAMA ---
:menu
echo.
echo %ESC%[97m==========================================================================================%ESC%[0m
echo                                  %ESC%[95mKYOUZAMA CMD MANAGER%ESC%[0m
echo %ESC%[97m==========================================================================================%ESC%[0m
echo.
echo  %ESC%[95m[1]%ESC%[0m Pasang Fastfetch (Standard)
echo      %ESC%[90m- Muncul Copyright Microsoft + Fastfetch.%ESC%[0m
echo.
echo  %ESC%[95m[2]%ESC%[0m Pasang Fastfetch + Clean Mode
echo      %ESC%[90m- Hapus Copyright Microsoft + Muncul Fastfetch.%ESC%[0m
echo.
echo  %ESC%[95m[3]%ESC%[0m Hapus Tulisan Microsoft Saja (Clean Only)
echo      %ESC%[90m- Layar jadi kosong bersih (Tanpa Fastfetch).%ESC%[0m
echo.
echo  %ESC%[95m[4]%ESC%[0m Kembalikan Tulisan Microsoft (Restore)
echo      %ESC%[90m- Mengembalikan tampilan CMD ke standar Windows.%ESC%[0m
echo.
echo  %ESC%[95m[5]%ESC%[0m Uninstall Semuanya ^& Keluar
echo      %ESC%[90m- Hapus AutoRun lalu tutup aplikasi ini.%ESC%[0m
echo.
echo %ESC%[97m==========================================================================================%ESC%[0m
set /p choice="Pilih Opsi (1-5): "

if "%choice%"=="1" goto opt1
if "%choice%"=="2" goto opt2
if "%choice%"=="3" goto opt3
if "%choice%"=="4" goto opt4
if "%choice%"=="5" goto opt5
goto menu

:: --- FUNGSI GAMBAR (Supaya tidak copy paste berkali-kali) ---
:logo_art
echo   /$$  /$$                                                                   
echo  ^| $$ /$$/                                                                    
echo  ^| $$ /$$/  /$$   /$$  /$$$$$$  /$$   /$$ /$$$$$$$$  /$$$$$$  /$$$$$$/$$$$   /$$$$$$ 
echo  ^| $$$$$/  ^| $$  ^| $$ /$$__  $$^| $$  ^| $$^|____ /$$/ /$$__  $$^| $$_  $$_  $$ /$$__  $$
echo  ^| $$  $$  ^| $$  ^| $$^| $$  \ $$^| $$  ^| $$   /$$$$/  ^| $$$$$$$^| $$ \ $$ \ $$^| $$$$$$$
echo  ^| $$\  $$ ^| $$  ^| $$^| $$  ^| $$^| $$  ^| $$  /$$__/   /$$__  $$^| $$ ^| $$ ^| $$ /$$__  $$
echo  ^| $$ \  $$^|  $$$$$$$^|  $$$$$$/^|  $$$$$$/ /$$$$$$$$^|  $$$$$$$^| $$ ^| $$ ^| $$^|  $$$$$$$
echo  ^|__/  \__/ \____  $$ \______/  \______/ ^|________/ \_______/^|__/ ^|__/ ^|__/ \_______/
echo             /$$  ^| $$                                                        
echo            ^|  $$$$$$/                                                        
echo             \______/       
exit /b

:: --- LOGIKA MENU ---
:opt1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "fastfetch" /f >nul
echo.
echo %ESC%[92m[OK] Fastfetch Standard berhasil dipasang.%ESC%[0m
pause
cls
goto logo_art_static

:opt2
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "cls && fastfetch" /f >nul
echo.
echo %ESC%[92m[OK] Fastfetch Clean Mode berhasil dipasang.%ESC%[0m
pause
cls
goto logo_art_static

:opt3
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "cls" /f >nul
echo.
echo %ESC%[92m[OK] Tulisan Microsoft berhasil disembunyikan.%ESC%[0m
pause
cls
goto logo_art_static

:opt4
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun /f >nul 2>&1
echo.
echo %ESC%[92m[OK] Tulisan Microsoft telah dikembalikan (Default).%ESC%[0m
pause
cls
goto logo_art_static

:opt5
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun /f >nul 2>&1
echo.
echo %ESC%[92m[OK] Semua pengaturan dihapus. Keluar...%ESC%[0m
timeout /t 2 >nul
exit

:logo_art_static
echo.
echo %ESC%[95m
call :logo_art
echo %ESC%[0m
goto menu