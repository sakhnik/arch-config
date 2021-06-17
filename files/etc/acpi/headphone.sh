#!/bin/bash
set -euxo pipefail

card_name=0  # For pulseaudio
#card=alsa_card.platform-skl_n88l25_s4567  # For pipewire

enable() {
    cards="sklnau8825adi sklnau8825max"
    for card in $cards; do
	if [[ -e "/proc/asound/${card}" ]]; then
            pid=$(pidof pulseaudio)
            user=$(stat -c '%U' /proc/"${pid}")
            uid=$(stat -c '%u' /proc/"${pid}")
            export PULSE_RUNTIME_PATH="/run/user/${uid}/pulse"
            su --preserve-environment -c "pactl set-card-profile $card_name $1" "${user}"
	fi
    done
}

desc="$1 $2 $3"

if [[ "$desc" == "jack/headphone HEADPHONE plug" ]]; then
    enable Headphones-Profile
#elif [[ "$desc" == "jack/microphone MICROPHONE plug" ]]; then
#    # for a headphones+mic, we will get 1st: headphone plug, 2nd this event
#    enable Headset-Profile
elif [[ "$desc" == "jack/headphone HEADPHONE unplug" ]]; then
    enable HiFi
elif [[ "$desc" == "jack/microphone MICROPHONE unplug" ]]; then
    enable HiFi
fi
