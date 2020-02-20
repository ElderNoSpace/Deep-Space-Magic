<?xml version="1.0" encoding="UTF-8"?>
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