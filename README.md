# Android emulator launcher

List the Android Virtual Devices installed on your machine and launch one by
number. Create an AVD in Android Studio's Device Manager before running this
script.

## Requirements

- Android SDK with the Emulator package installed.
- Bash (macOS, Linux, Git Bash, or WSL).
- `ANDROID_SDK_ROOT` or `ANDROID_HOME` set to your SDK directory.

```bash
export ANDROID_HOME="$HOME/Android/Sdk" # replace with your SDK directory
bash emulator.sh
```

On macOS the default SDK location is `$HOME/Library/Android/sdk`.
On Windows, run in **Git Bash**, not PowerShell or Command Prompt, and use a Bash
path such as `/c/Users/your-name/AppData/Local/Android/Sdk`. The script also detects
`emulator.exe`. In WSL use an SDK installed and configured for that environment;
GUI and hardware acceleration availability depend on your WSL setup.

`ANDROID_SDK_ROOT` takes precedence if both variables are set. Paths with spaces
are supported. The script rejects invalid choices and stops when no AVD exists
or the Emulator executable cannot be found.

## Validation

```bash
bash -n emulator.sh
```

Launching a real device requires the Android SDK and a supported emulator host.
