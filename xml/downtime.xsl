<?xml version="1.0" encoding="UTF-8"?>
<!--MIT License

Copyright (c) 2020 ElderNoSpace
        
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
        
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
        
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" media-type="application/x-latex"/>

<!--Apply activity template and create temp latex file for the downtime activities's actions-->
<xsl:template match="downtime"><!--
--><xsl:param name="categoryName" /><!--
--><xsl:apply-templates select="activity"/><!--

    --><xsl:if test="activity/actions">
        <xsl:result-document href="../temp/Actions/{$categoryName}.tex" method="text" media-type="application/x-latex">
<!--     --><xsl:apply-templates select="activity/actions"/>
        </xsl:result-document>
    </xsl:if>
</xsl:template>

<!--Using the activity latex environment format the activity-->
<xsl:template match="activity"><!--
--><xsl:if test="@index='true'">\index{<xsl:value-of select="name"/>}</xsl:if><!--
--> \begin{activity}{\hypertarget{Activity_<xsl:value-of select="translate(name, ' ', '_')"/>}{<xsl:value-of select="name"/>}}{<xsl:value-of select="score"/>}
    \textit{<xsl:value-of select="type"/>}\\
    \rule{\hsize}{0.4pt}
    <xsl:value-of select="effect"/>
    \rule{\hsize}{0.4pt}
    <xsl:for-each select="actions/action"><!--
    --><xsl:call-template name="linkActions"><!--
        --><xsl:with-param name="name" select = "name"/><!--
    --></xsl:call-template><!--
--></xsl:for-each>\end{activity}
</xsl:template>

</xsl:stylesheet>