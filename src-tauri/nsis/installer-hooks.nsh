!macro NSIS_HOOK_PREINSTALL
  ; Terminate running OmniGet process so uninstaller can remove files without locks
  DetailPrint "Stopping running instances of OmniGet..."
  nsExec::Exec 'taskkill /F /IM "omniget.exe"'
  nsExec::Exec 'taskkill /F /IM "OmniGet.exe"'
  Sleep 1000

  ; Remove previous per-user OmniGet installation if present
  IfFileExists "$LOCALAPPDATA\Programs\OmniGet\uninstall.exe" 0 +3
    DetailPrint "Removing previous OmniGet installation..."
    ExecWait '"$LOCALAPPDATA\Programs\OmniGet\uninstall.exe" /S _?=$LOCALAPPDATA\Programs\OmniGet'

  ; Remove previous machine-wide OmniGet installation if present
  IfFileExists "$PROGRAMFILES\OmniGet\uninstall.exe" 0 +3
    DetailPrint "Removing previous machine-wide OmniGet installation..."
    ExecWait '"$PROGRAMFILES\OmniGet\uninstall.exe" /S _?=$PROGRAMFILES\OmniGet'
!macroend
