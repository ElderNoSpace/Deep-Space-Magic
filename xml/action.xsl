<?xml version="1.0" encoding="utf-8"?>
<!--MIT License

Copyright (c) 2020 ElderNoSpace
        
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
        
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
        
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" media-type="application/x-latex"/>

<xsl:import href="result.xsl"/>

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
    \textit{<xsl:apply-templates select="type"/>}\\
    \rule{\hsize}{0.4pt}
    <xsl:if test="using">
    Using <xsl:value-of select="number"/><xsl:text> </xsl:text><xsl:apply-templates select="type"/>.
    \rule{\hsize}{0.4pt}
    </xsl:if>

    <xsl:if test="cost">
    <xsl:value-of select="cost"/>
    \rule{\hsize}{0.4pt}
    </xsl:if>

    <xsl:apply-templates select="effect"/>

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

<xsl:template match="effect">
    <xsl:choose>
        <xsl:when test="takeAction">
            Take the <xsl:for-each select="takeAction"><xsl:value-of select="node()"/> action <xsl:apply-templates select="following-sibling::alterAttribute[1]"/>, </xsl:for-each> using <xsl:if test="using"><xsl:for-each select="using"><xsl:value-of select="node()"/>, </xsl:for-each> respectivly.</xsl:if>
        </xsl:when>
        <xsl:when test="target">
            Target <xsl:apply-templates select="target"/> <xsl:if test="range"> at range <xsl:value-of select="range"/>m</xsl:if> <xsl:apply-templates select="aoe"/> <xsl:if test="save"> has to make a <xsl:value-of select="save"/> save or</xsl:if>

            <xsl:apply-templates select="wait"/>
            <xsl:apply-templates select="actionSteal"/>
            <xsl:apply-templates select="visionSteal"/>
            <xsl:apply-templates select="illusion"/>
            <xsl:apply-templates select="levitate"/>
            <xsl:apply-templates select="tempType"/>
            <xsl:apply-templates select="setWeaponAttribute"/>
            <xsl:apply-templates select="addWeaponAttribute"/>
            <xsl:apply-templates select="pullItem"/>
            <xsl:apply-templates select="equip"/>
            <xsl:apply-templates select="unequip"/>
            <xsl:apply-templates select="increaseEquip"/>
            <xsl:apply-templates select="saveModifier"/>
            <xsl:apply-templates select="teleport"/>
            <xsl:apply-templates select="allLineOfSight"/>
            <xsl:apply-templates select="damage"/>
            <xsl:apply-templates select="push"/>
            <xsl:apply-templates select="saveReduceOnHit"/>
            <xsl:apply-templates select="jump"/>
            <xsl:apply-templates select="reduceDifficulty"/>
            
            <xsl:if test="duration"> for <xsl:value-of select="duration"/> Time Units</xsl:if>.
        </xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template match="alterAttribute">
    add <xsl:choose><xsl:when test="range"><xsl:value-of select="range"/> to range</xsl:when><xsl:when test="range"><xsl:value-of select="difficulty"/> to difficulty</xsl:when></xsl:choose>
</xsl:template>

<xsl:template match="using">
    using a <xsl:value-of select="type"/>
</xsl:template>

<xsl:template match="target">
    <xsl:value-of select="modifier"/> <xsl:apply-templates select="type"/> <xsl:value-of select="thing"/>
</xsl:template>

<xsl:template match="aoe">
    <xsl:choose>
        <xsl:when test="Weapon">within Weapon aoe</xsl:when>
        <xsl:when test="circle">in a <xsl:value-of select="circle"/>m radius circle</xsl:when>
        <xsl:when test="cone">in a <xsl:value-of select="cone"/>$^{\circ}$ cone</xsl:when>
        <xsl:when test="line">in a line</xsl:when>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>