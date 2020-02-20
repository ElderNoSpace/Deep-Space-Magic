<?xml version="1.0" encoding="utf-8"?>
<!--MIT License

Copyright (c) 2020 ElderNoSpace
        
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
        
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
        
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" media-type="application/x-latex"/>

<!--Apply item template and create temp latex file for the equipment items's actions-->
<xsl:template match="items"><!--
--><xsl:param name="categoryName"/><!--
    -->\begin{tabularx}{\hsize}{X|X X}
        Name&amp;Cost&amp;Actions\\
        \hline
        \arrayrulecolor{lightgray}
        <xsl:apply-templates select="item"/>
        \arrayrulecolor{black}
        \end{tabularx}<!--
    
    --><xsl:if test="item/actions">
        <xsl:result-document href="../temp/Actions/{$categoryName}.tex" method="text" media-type="application/x-latex">
<!--     --><xsl:apply-templates select="item/actions"/>
        </xsl:result-document>
    </xsl:if>
</xsl:template>

<!--Apply weapon template and create temp latex file for the equipment weapon's actions-->
<xsl:template match="weapons"><!--
--><xsl:param name="categoryName"/><!--
    -->\begin{tabularx}{\hsize}{X|c c c c c X X}
    Name&amp;Cost&amp;Difficulty&amp;Time&amp;Range&amp;Damage&amp;Passive&amp;Actions\\
    \hline
    \arrayrulecolor{lightgray}
    <xsl:apply-templates select="weapon"/>
    \arrayrulecolor{black}
    \end{tabularx}<!--

--><xsl:if test="weapon/actions">
    <xsl:result-document href="../temp/Actions/{$categoryName}.tex" method="text" media-type="application/x-latex">
<!--     --><xsl:apply-templates select="weapon/actions"/>
    </xsl:result-document>
</xsl:if>
</xsl:template>

<!--Apply armour template and create temp latex file for the equipment armour's actions-->
<xsl:template match="armours"><!--
--><xsl:param name="categoryName"/><!--
    -->\begin{tabularx}{\hsize}{X|c c c X X}
    Name&amp;Cost&amp;Save&amp;Modifier&amp;Passive&amp;Actions\\
    \hline
    \arrayrulecolor{lightgray}
    <xsl:apply-templates select="armour"/>
    \arrayrulecolor{black}
    \end{tabularx}<!--

--><xsl:if test="armour/actions">
    <xsl:result-document href="../temp/Actions/{$categoryName}.tex" method="text" media-type="application/x-latex">
<!--     --><xsl:apply-templates select="weapon/actions"/>
    </xsl:result-document>
</xsl:if>
</xsl:template>

<!--Creates the table rows for the items-->
<xsl:template match="item"><!--
    --><xsl:if test="@index='true'">\index{<xsl:value-of select="name"/>}</xsl:if><!--
    -->\hypertarget{Item_<xsl:value-of select="translate(name, ' ', '_')"/>}{<xsl:value-of select="name"/>}&amp;<xsl:value-of select="cost"/>&amp;<!--
    --><xsl:for-each select="actions/action"><!--
        --><xsl:call-template name="linkActions"><!--
            --><xsl:with-param name="name" select = "name"/><!--
        --></xsl:call-template><!--
    --></xsl:for-each>\\
\hline
</xsl:template>

<!--Creates the table rows for the weapons-->
<xsl:template match="weapon"><!--
--><xsl:if test="@index='true'">\index{<xsl:value-of select="name"/>}</xsl:if><!--
-->\hypertarget{Weapon_<xsl:value-of select="translate(name, ' ', '_')"/>}{<xsl:value-of select="name"/>}&amp;<xsl:value-of select="cost"/>&amp;<xsl:value-of select="difficulty"/>&amp;<xsl:value-of select="time"/>&amp;<xsl:value-of select="range"/>m&amp;<xsl:value-of select="damage"/>&amp;<xsl:if test="passiveEffect"><xsl:value-of select="passiveEffect"/></xsl:if>&amp;<!--
--><xsl:for-each select="actions/action"><!--
    --><xsl:call-template name="linkActions"><!--
        --><xsl:with-param name="name" select = "name"/><!--
    --></xsl:call-template><!--
--></xsl:for-each>\\
\hline
</xsl:template>

<!--Creates the table rows for the armours-->
<xsl:template match="armour"><!--
--><xsl:if test="@index='true'">\index{<xsl:value-of select="name"/>}</xsl:if><!--
-->\hypertarget{Armour_<xsl:value-of select="translate(name, ' ', '_')"/>}{<xsl:value-of select="name"/>}&amp;<xsl:value-of select="cost"/>&amp;<xsl:value-of select="save"/>&amp;<xsl:value-of select="modifier"/>&amp;<xsl:value-of select="passiveEffect"/>&amp;<!--
--><xsl:for-each select="actions/action"><!--
    --><xsl:call-template name="linkActions"><!--
        --><xsl:with-param name="name" select = "name"/><!--
    --></xsl:call-template><!--
--></xsl:for-each>\\
\hline
</xsl:template>

</xsl:stylesheet>