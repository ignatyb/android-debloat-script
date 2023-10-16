#
#/bin/bash
# Define an array of JSON files
json_files=("aosp.json" "carrier.json" "google.json" "misc.json" "oem.json")
for json_file in "${json_files[@]}"; do
  package_names=($(jq -r '.[].id' "$json_file"))
  for package_name in "${package_names[@]}"; do
    removal=$(jq -r --arg pkg "$package_name" '.[] | select(.id == $pkg) | .removal' "$json_file")
    if [[ "$removal" == "delete" || "$removal" == "replace" ]]; then
      adb shell pm install-existing --user $(adb shell am get-current-user) "$package_name"
    else
    fi
  done
done

