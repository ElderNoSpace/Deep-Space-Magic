#MIT License
#
#Copyright (c) 2020 ElderNoSpace
#     
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#        
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#     
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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