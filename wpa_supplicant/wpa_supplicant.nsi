!define PRODUCT_NAME "wpa_supplicant"
!define PRODUCT_VERSION "@WPAVER@"
!define PRODUCT_PUBLISHER "Jouni Malinen"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
outfile "../wpa_supplicant-@WPAVER@.exe"

installDir "$PROGRAMFILES\wpa_supplicant"

Page Directory
Page InstFiles

section -Prerequisites
	SetOutPath $INSTDIR\Prerequisites
	MessageBox MB_YESNO "Install WinPcap?" /SD IDYES IDNO endWinPcap
		File "/opt/Qt-Win/files/WinPcap_4_0_2.exe"
		ExecWait "$INSTDIR\Prerequisites\WinPcap_4_0_2.exe"
		Goto endWinPcap
	endWinPcap:
sectionEnd


section
	setOutPath $INSTDIR

	File wpa_gui.exe
	File wpa_cli.exe
	File COPYING
	File README
	File README-Windows.txt
	File win_example.reg
	File win_if_list.exe
	File wpa_passphrase.exe
	File wpa_supplicant.conf
	File wpa_supplicant.exe
	File wpasvc.exe

	File /opt/Qt-Win/files/mingwm10.dll
	File /opt/Qt-Win/files/QtCore4.dll
	File /opt/Qt-Win/files/QtGui4.dll

	writeUninstaller "$INSTDIR\uninstall.exe"

	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\wpa_supplicant" \
		"DisplayName" "wpa_supplicant"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\wpa_supplicant" \
		"UninstallString" "$INSTDIR\uninstall.exe"

	ExecWait "$INSTDIR\wpasvc.exe reg"
sectionEnd


section "uninstall"
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\wpa_supplicant"
	delete "$INSTDIR\uninstall.exe"

	ExecWait "$INSTDIR\wpasvc.exe unreg"

	delete "$INSTDIR\wpa_gui.exe"
	delete "$INSTDIR\wpa_cli.exe"
	delete "$INSTDIR\COPYING"
	delete "$INSTDIR\README"
	delete "$INSTDIR\README-Windows.txt"
	delete "$INSTDIR\win_example.reg"
	delete "$INSTDIR\win_if_list.exe"
	delete "$INSTDIR\wpa_passphrase.exe"
	delete "$INSTDIR\wpa_supplicant.conf"
	delete "$INSTDIR\wpa_supplicant.exe"
	delete "$INSTDIR\wpasvc.exe"

	delete "$INSTDIR\mingwm10.dll"
	delete "$INSTDIR\QtCore4.dll"
	delete "$INSTDIR\QtGui4.dll"

	delete "$INSTDIR\Prerequisites\WinPcap_4_0_2.exe"
	rmdir "$INSTDIR\Prerequisites"

	rmdir "$INSTDIR"
sectionEnd