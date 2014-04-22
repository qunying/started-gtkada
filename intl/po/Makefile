LANGS:=zh_CN
CP:=cp
prgname := intl
## Refresh all translations by extracting the strings from the current sources
refresh:
	./build_skeleton.pl ${prgname} 2014 "Zhu Qun-Ying" "zhu.qunying@gmail.com" > ${prgname}.pot
	${foreach lang,${LANGS}, \
	if [ -f ${lang}.po ]; then true; else ${CP} ${prgname}.pot ${lang}.po; fi; \
	msgmerge --no-wrap --update ${lang}.po ${prgname}.pot}

## Install the translation files
$(LANGS): 
	-msgfmt -o $@.gmo $@.po --statistics --check-header --check-format --check-domain

clean:
	-$(RM) *.gmo 
