TARGET := intl
prefix :=/usr/local
localedir := ${prefix}/share/locale
include ../Makefile.common

all: locale_file

locale_file:
	@./generate_locale_path.sh ${localedir}
