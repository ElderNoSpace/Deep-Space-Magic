LATEXC=latexmk
XMLC=saxon
LATEXFLAGS=-pdf
XMLFLAGS=-a:on -quit:on
XMLSOURCES=xml/Actions/Actions.xml xml/Equipment/Equipment.xml xml/DowntimeActivities/DowntimeActivities.xml
XMLSUBSOURCES=xml/Actions/Movement.xml xml/Actions/RangedWeaponry.xml xml/Equipment/RangedWeapons.xml xml/DowntimeActivities/Crafting.xml xml/DowntimeActivities/Gambling.xml
XMLSTYLESHEET=xml/Converter.xsl
XMLSUBSTYLESHEETS=xml/action.xsl xml/equipment.xsl
XMLTEXTEMPS=xml/temp
TEXSUBSOURCES=$(XMLSOURCES:.xml=.tex)
TEXSOURCES=Game.tex
PRODUCT=Game.pdf

all: $(TEXSOURCES) $(PRODUCT)

.PHONY: all clean cleanall

$(PRODUCT): $(TEXSOURCES) $(TEXSUBSOURCES) $(XMLSTYLESHEET)
	$(LATEXC) $(LATEXFLAGS) $(TEXSOURCES) $@

%.tex : %.xml $(XMLSTYLESHEET)
	$(XMLC) $(XMLFLAGS) -o:$@ -s:$<

$(XMLSTYLESHEET): $(XMLSUBSTYLESHEETS) ;

$(XMLSOURCES): $(XMLSUBSOURCES) ;#Needs improvement

clean:
	$(LATEXC) -c
	-rm $(TEXSUBSOURCES)
	find . -type f -name "*.action" -delete
	-rm $(XMLTEXTEMPS)/*/*.*

cleanall:
	$(LATEXC) -C
	-rm $(TEXSUBSOURCES)
	find . -type f -name "*.action" -delete
	-rm $(XMLTEXTEMPS)/*/*.*