#!/bin/sh
# generate a locale path according to prefix location
#for used in Bind_Text_Domain

if [ "$#" != "1" ]; then
    echo "please enter prefix location."
    exit 1
fi

localedir=$1

locale_path_ads=src/intl_locale.ads

function generate_locale_path_ads() {
    echo "Generating $locale_path_ads for $localedir"
    gen_time=`date +"%F %R"`
    cat > $locale_path_ads <<EOF
-- This is an automatically generated file during compilation
-- Please don't edit it by hand.
-- Generated at $gen_time

package Intl_Locale is
   path : constant String := "${localedir}";
end Intl_Locale;
EOF
}

if [ -f "$locale_path_ads" ]; then
    grep -w "${localedir}" $locale_path_ads > /dev/null
    if [ "$?" != "0" ]; then
	generate_locale_path_ads
    fi
else
    generate_locale_path_ads
fi

