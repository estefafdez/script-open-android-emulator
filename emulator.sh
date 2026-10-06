#!/usr/bin/env bash
set -euo pipefail

sdk_root=${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}
if [[ -z "$sdk_root" ]]; then
  printf 'Set ANDROID_SDK_ROOT or ANDROID_HOME to your Android SDK directory.\n' >&2
  exit 1
fi
emulator="$sdk_root/emulator/emulator"
if [[ ! -x "$emulator" && -x "$emulator.exe" ]]; then
  emulator="$emulator.exe"
fi
if [[ ! -x "$emulator" ]]; then
  printf 'Emulator executable not found in %s/emulator\n' "$sdk_root" >&2
  exit 1
fi

# Preserve each AVD name and strip CR from Windows output.
avds=()
while IFS= read -r avd; do
  avd=${avd%$'\r'}
  [[ -z "$avd" ]] || avds+=("$avd")
done < <("$emulator" -list-avds)
if (( ${#avds[@]} == 0 )); then
  printf 'No Android Virtual Devices found. Create one in Android Studio first.\n' >&2
  exit 1
fi
printf 'Emulator list:\n'
for i in "${!avds[@]}"; do
  printf '%d. %s\n' "$((i + 1))" "${avds[$i]}"
done
printf 'Select device number: '
IFS= read -r selection || exit 1
# Avoid octal parsing, overflow and expressions from untrusted input.
if [[ ! "$selection" =~ ^[1-9][0-9]{0,5}$ ]] || (( 10#$selection > ${#avds[@]} )); then
  printf 'Invalid selection.\n' >&2
  exit 1
fi
avd=${avds[$((10#$selection - 1))]}
printf 'Launching: %s\n' "$avd"
exec "$emulator" -avd "$avd"
