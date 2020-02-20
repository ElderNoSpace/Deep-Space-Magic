<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" media-type="application/x-latex"/>

<!--Call the template on each action-->
<xsl:template match="actions">
    <xsl:apply-templates select="action"/>
</xsl:template>

<!--Use the action latex environment to display the action-->
<xsl:template match="action"><!--
--><xsl:if test="@index='true'">\index{<xsl:value-of select="name"/>}</xsl:if><!--
--><xsl:choose><xsl:when test="@specialist='true'">\begin{specialistAction}</xsl:when><xsl:otherwise>\begin{action}</xsl:otherwise></xsl:choose><!--
-->{\hypertarget{Action_<xsl:value-of select="translate(name, ' ', '_')"/>}{<xsl:value-of select="name"/>}}<!--
-->{<xsl:choose><!--
--><xsl:when test="time"><xsl:value-of select="time"/></xsl:when><!--
--><xsl:otherwise>&#8211;</xsl:otherwise><!--
--></xsl:choose>}<!--
-->{<xsl:value-of select="@difficulty"/>}{<xsl:value-of select="@upgrade"/>}
    \textit{<xsl:value-of select="type"/>}\\
    \rule{\hsize}{0.4pt}
    <xsl:if test="cost">
    <xsl:value-of select="cost"/>
    \rule{\hsize}{0.4pt}
    </xsl:if>

    <xsl:value-of select="effect"/>

    <xsl:if test="upeffect">
    \rule{\hsize}{0.4pt}         
    <xsl:value-of select="upeffect"/>
    </xsl:if>

    <xsl:if test="score">
    \rule{\hsize}{0.4pt}  
    <xsl:value-of select="score"/>
    </xsl:if>
    <xsl:choose><xsl:when test="@specialist='true'">\end{specialistAction}
    </xsl:when><xsl:otherwise>\end{action}
    </xsl:otherwise></xsl:choose>
</xsl:template>

<xsl:template name="linkActions">
    <xsl:param name="name"/>
    \hyperlink{Action_<xsl:value-of select="translate($name, ' ', '_')"/>}{<xsl:value-of select="$name"/>}
</xsl:template>

</xsl:stylesheet>