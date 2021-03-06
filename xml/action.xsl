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

    <xsl:if test="costs">
    <xsl:apply-templates select="costs"/>
    \rule{\hsize}{0.4pt}
    </xsl:if>

    <xsl:apply-templates select="effect"/>

    <xsl:if test="upeffect">
    \rule{\hsize}{0.4pt}         
    <xsl:apply-templates select="upeffect"/>
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
            <xsl:apply-templates select="bounce"/>
            <xsl:apply-templates select="addActionAttribute"/>
            <xsl:apply-templates select="ignoresCover"/>
            <xsl:apply-templates select="refill"/>
            <xsl:apply-templates select="move"/>
            <xsl:apply-templates select="persuade"/>
            <xsl:apply-templates select="negateArgument"/>

            <xsl:if test="duration"> for <xsl:value-of select="duration"/> Time Units</xsl:if>.<xsl:if test="noCooldown"> Don't roll the Action Cooldown Die after taking this action.</xsl:if>
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

<xsl:template match="costs">
    <xsl:if test="Mental"><xsl:value-of select="Mental"/> point(s) from the Mental pool,</xsl:if>
    <xsl:if test="Physical"><xsl:value-of select="Physical"/> point(s) from the Physical pool,</xsl:if>
    <xsl:if test="Spirit"><xsl:value-of select="Spirit"/> point(s) from the Spirit pool,</xsl:if>
    <xsl:if test="health"><xsl:value-of select="health"/> point(s) of damage,</xsl:if>
    <xsl:if test="ammo"><xsl:value-of select="ammo"/> unit(s) of the respective ammunition</xsl:if>

</xsl:template>

<xsl:template match="upeffect">
    <xsl:if test="perLevel"> <xsl:apply-templates select="perLevel"/> per level</xsl:if><xsl:if test="perNLevels"> <xsl:apply-templates select="perNLevels/upgrade"/> per <xsl:value-of select="perNLevels/rate"/> levels</xsl:if><xsl:if test="atLevel"> <xsl:apply-templates select="atLevel/upgrade"/> at level <xsl:value-of select="perNLevels/level"/></xsl:if>.
</xsl:template>

<xsl:template match="upgrade|perLevel">
    <xsl:if test="difficultyCount"> increase Difficulty Count by <xsl:value-of select="difficultyCount"/></xsl:if>
    <xsl:if test="duration"> increase Duration by <xsl:value-of select="duration"/> Time Units</xsl:if>
    <xsl:if test="timeCost"> increase Time Cost by <xsl:value-of select="timeCost"/> Time Units</xsl:if>
    <xsl:if test="range"> increase Range by <xsl:value-of select="range"/>m</xsl:if>
    <xsl:if test="newAoe"> change the aoe to <apply-templates select="newAoe"/></xsl:if>
    <xsl:if test="upAoe"> increase the <apply-templates select="upAoe"/></xsl:if>
    <xsl:if test="damage"> increase damage by <xsl:value-of select="damage"/></xsl:if>
    <xsl:if test="pushDistance"> increase push distance by <xsl:value-of select="pushDistance"/></xsl:if>
    <xsl:if test="saveReduceOnHitModifier"> increase the amount the save is reduced on hit by <xsl:value-of select="saveReduceOnHitModifier"/></xsl:if>
    <xsl:if test="jumpMax"> increase maximum jump distance by <xsl:value-of select="jumpMax"/>m</xsl:if>
    <xsl:if test="waitIncrease"> increase the time the target has to wait by <xsl:value-of select="waitIncrease"/> Time Units</xsl:if>
    <xsl:if test="weaponAttributeIncrease"><xsl:apply-templates select="weaponAttributeIncrease"/></xsl:if>
    <xsl:if test="numberOfActionsIncrease"> increase the number of actions done by <xsl:value-of select="numberOfActionsIncrease"/></xsl:if>
    <xsl:if test="cellsRefilledIncrease"> increase number of cells refilled by <xsl:value-of select="cellsRefilledIncrease"/></xsl:if>
    <xsl:if test="pullWeight"> increase the weight that can be pulled by <xsl:value-of select="pullWeight"/>kg</xsl:if>
</xsl:template>

<xsl:template match="newAoe">
    <xsl:choose>
        <xsl:when test="Weapon">Weapon aoe</xsl:when>
        <xsl:when test="circle">a <xsl:value-of select="circle"/>m radius circle</xsl:when>
        <xsl:when test="cone">a <xsl:value-of select="cone"/>$^{\circ}$ cone</xsl:when>
        <xsl:when test="line">a line</xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template match="upAoe">
    <xsl:choose>
        <xsl:when test="Weapon"> nothing</xsl:when>
        <xsl:when test="circle">radius by <xsl:value-of select="circle"/>m</xsl:when>
        <xsl:when test="cone">angle by <xsl:value-of select="cone"/>$^{\circ}$</xsl:when>
        <xsl:when test="line"> nothing</xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template match="weaponAttributeIncrease">
    increase 
    <xsl:choose>
        <xsl:when test="range">range by <xsl:value-of select="range"/>m</xsl:when>
        <xsl:when test="difficulty">difficulty count by <xsl:value-of select="difficulty"/></xsl:when>
        <xsl:when test="push">push distance by <xsl:value-of select="pusm"/>m</xsl:when>
    </xsl:choose>
    of the created weapon
</xsl:template>

</xsl:stylesheet>