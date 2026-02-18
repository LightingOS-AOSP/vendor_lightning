#!/bin/bash
# LightningOS Fancy Build Output Banner
# Arguments:
# 1=device, 2=lineage_version, 3=lightning_version, 4=package_type,
# 5=release_type, 6=zip_path, 7=maintainer, 8=build_duration_seconds

DEVICE="$1"
ROM_NAME="$2"
VERSION="$3"
PACKAGE_TYPE="$4"
RELEASE_TYPE="$5"
ZIP_PATH="$6"
MAINTAINER="$7"
BUILD_DURATION="$8"

# Fallbacks
[ -z "$MAINTAINER" ] && MAINTAINER="Unknown"
[ -z "$BUILD_DURATION" ] && BUILD_DURATION=0

# ─────────────────────────────────────────────
# Colors
# ─────────────────────────────────────────────
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
INDIGO="\e[35m"
CYAN="\e[36m"
WHITE="\e[1;37m"
MAGENTA="\e[1;35m"
BOLD="\e[1m"
RESET="\e[0m"

# ─────────────────────────────────────────────
# Release Type Color
# ─────────────────────────────────────────────
case "$(echo "$RELEASE_TYPE" | tr '[:upper:]' '[:lower:]')" in
    official)
        RELEASE_COLOR="$GREEN"
        ;;
    unofficial)
        RELEASE_COLOR="$RED"
        ;;
    *)
        RELEASE_COLOR="$WHITE"
        ;;
esac

# File size
FILE_SIZE=$(du -h "$ZIP_PATH" | awk '{print $1}')

# ─────────────────────────────────────────────
# Build duration (convert seconds → h/m/s)
# ─────────────────────────────────────────────
HOURS=$((BUILD_DURATION / 3600))
MINUTES=$(((BUILD_DURATION % 3600) / 60))
SECONDS=$((BUILD_DURATION % 60))

if [ "$HOURS" -gt 0 ]; then
    DURATION_FORMAT="${HOURS}h ${MINUTES}m ${SECONDS}s"
elif [ "$MINUTES" -gt 0 ]; then
    DURATION_FORMAT="${MINUTES}m ${SECONDS}s"
else
    DURATION_FORMAT="${SECONDS}s"
fi

# ─────────────────────────────────────────────
# ASCII Banner
# ─────────────────────────────────────────────
echo ""
echo -e "${GREEN}-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------${RESET}"
echo -e "${RED}__/\\\\\\______________/\\\\\\\\\\\_____/\\\\\\\\\\\\__/\\\________/\\\__/\\\\\\\\\\\\\\\__/\\\\\_____/\\\__/\\\\\\\\\\\__/\\\\\_____/\\\_____/\\\\\\\\\\\\_________________/\\\\\__________/\\\\\\\\\\\___${RESET}"
echo -e "${RED}_\\/\\\\\\_____________\/////\\\///____/\\\//////////__\\/\\\_______\/\\\_\///////\\\/////__\\/\\\\\\___\/\\\_\/////\\\///__\\/\\\\\\___\/\\\___/\\\//////////________________/\\\///\\\______/\\\/////////\\\_${RESET}"
echo -e "${RED}_\\/\\\\\\_________________\/\\\______/\\\_____________\/\\\_______\/\\\_______\/\\\_______\/\\\/\\\\\\__\\/\\\_____\/\\\_____\/\\\/\\\\\\__\\/\\\__/\\\_________________________/\\\/__\///\\\\\\___\//\\\______\///__${RESET}"
echo -e "${BLUE}_\\/\\\\\\_________________\/\\\_____\/\\\____/\\\\\\\_\/\\\\\\\\\\\\\\\_______\/\\\_______\/\\\//\\\\\\_\/\\\_____\/\\\_____\/\\\//\\\\\\_\/\\\_\/\\\____/\\\\\\\____________/\\\\\\______\//\\\\\\___\////\\\_________${RESET}"
echo -e "${BLUE}_\\/\\\\\\_________________\/\\\_____\/\\\___\/////\\\_\/\\\/////////\\\\\\_______\/\\\_______\/\\\\//\\\\/\\\\\\_____\/\\\_____\/\\\\//\\\\/\\\\\\_\/\\\___\/////\\\___________\/\\\\\\_______\/\\\\\\______\////\\\______${RESET}"
echo -e "${BLUE}_\\/\\\\\\_________________\/\\\_____\/\\\_______\/\\\_\/\\\_______\/\\\_______\/\\\_______\/\\\_\//\\\\\\/\\\\\\_____\/\\\_____\/\\\_\//\\\\\\/\\\\\\_\/\\\_______\/\\\___________\//\\\\\\______/\\\\\\__________\////\\\___${RESET}"
echo -e "${BLUE}_\\/\\\\\\_________________\/\\\_____\/\\\_______\/\\\_\/\\\_______\/\\\_______\/\\\_______\/\\\__\//\\\\\\\\\\\\\\_____\/\\\_____\/\\\__\//\\\\\\\\\\\\\\_\/\\\_______\/\\\____________\///\\\\\\__/\\\\\\_____/\\\______\//\\\\\\__${RESET}"
echo -e "${BLUE}_\\/\\\\\\\\\\\\\\\\\\__/\\\\\\\\\\\_\//\\\\\\\\\\\\/__\\/\\\_______\/\\\_______\/\\\_______\/\\\___\//\\\\\__/\\\\\\\\\\\_\/\\\___\//\\\\\_\//\\\\\\\\\\\\/_______________\///\\\\\\\/_____\///\\\\\\\\\\\/___${RESET}"
echo -e "${BLUE}_\\///////////////__\\///////////___\////////////____\\///________\///________\///________\///_____\/////__\\///////////__\\///_____\/////___\////////////___________________\/////_________\///////////_____${RESET}"
echo -e "${GREEN}-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------${RESET}"
echo -e "${GREEN}======================================${RESET}"

# ─────────────────────────────────────────────
# Build Summary Box
# ─────────────────────────────────────────────
echo -e ""
echo -e "${MAGENTA}╭───────────────────────────────╮${RESET}"
echo -e "${MAGENTA}│${RESET}   ${BOLD}🚀 LightningOS Build Summary${RESET}    ${MAGENTA} │${RESET}"
echo -e "${MAGENTA}├───────────────────────────────┤${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}ROM Name${RESET}:         ${WHITE}${ROM_NAME}${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}Zip File${RESET}:         ${WHITE}$(basename "$ZIP_PATH")${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}Version${RESET}:          ${WHITE}${VERSION}${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}Package Type${RESET}:     ${WHITE}${PACKAGE_TYPE}${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}Release Type${RESET}:     ${RELEASE_COLOR}${BOLD}${RELEASE_TYPE}${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}Device${RESET}:           ${WHITE}${DEVICE}${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}Maintainer${RESET}:       ${WHITE}${MAINTAINER}${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}File Size${RESET}:        ${WHITE}${FILE_SIZE}${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}Build Time${RESET}:       ${WHITE}${DURATION_FORMAT}${RESET}"
echo -e "${MAGENTA}╰───────────────────────────────╯${RESET}"
echo -e ""
echo -e "${GREEN}✅ Build completed successfully!${RESET}"
echo -e "${BLUE}📦 Output: ${ZIP_PATH}${RESET}"
echo -e ""
