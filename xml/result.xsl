<?xml version="1.0" encoding="utf-8"?>
<!--MIT License

Copyright (c) 2020 ElderNoSpace
        
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
        
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
        
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" media-type="application/x-latex"/>

<xsl:template match="wait">
    wait <xsl:value-of select="node()"/> Time Units
</xsl:template>

<xsl:template match="actionSteal">
    you decide their next action for them, this Action must be one they are able to do,
</xsl:template>

<xsl:template match="visionSteal">
    your Character invades the target Character's senses and is able to see through them
</xsl:template>

<xsl:template match="illusion">
    they percive an object that isn't actually there, this object looks, sounds and smells correct but is intangable to the affected Character,
</xsl:template>

<xsl:template match="levitate">
    floats up one meter into the air and can move $2ms^{-1}$ and ignore Difficult Terrain
</xsl:template>

<xsl:template match="tempType">
    gains the <xsl:apply-templates select="node()"/> type
</xsl:template>

<xsl:template match="setWeaponAttribute">
    sets <xsl:if test="range"><xsl:value-of select="range"/>m range</xsl:if> <xsl:if test="difficulty"><xsl:value-of select="difficulty"/> difficulty</xsl:if> <xsl:if test="push"><xsl:value-of select="push"/>m push distance</xsl:if> 
</xsl:template>

<xsl:template match="addWeaponAttribute">
    gains <xsl:if test="range"><xsl:value-of select="range"/>m range</xsl:if> <xsl:if test="difficulty"><xsl:value-of select="difficulty"/>difficulty</xsl:if> <xsl:if test="push"><xsl:value-of select="push"/>m push distance</xsl:if> 
</xsl:template>

<xsl:template match="pullItem">
    pulls target non-Character object, less than 10kg, within 100m that is not held by any other Character into hand
</xsl:template>

<xsl:template match="equip">
    equips a <xsl:apply-templates select="type"/>
</xsl:template>

<xsl:template match="unequip">
    unequips a <xsl:apply-templates select="type"/>
</xsl:template>

<xsl:template match="increaseEquip">
    is able to equip <xsl:value-of select="node()"/> more items
</xsl:template>

<xsl:template match="saveModifier">
    gains a <xsl:value-of select="amount"/> modifier to its <xsl:value-of select="save"/> save
</xsl:template>

<xsl:template match="teleport">
    teleports up to range away
</xsl:template>

<xsl:template match="allLineOfSight">
    is able to see everything within stated range that they could normally see
</xsl:template>

<xsl:template match="damage">
    take <xsl:value-of select="node()"/> damage
</xsl:template>

<xsl:template match="push">
    is pushed back <xsl:value-of select="node()"/>m
</xsl:template>

<xsl:template match="saveReduceOnHit">
    hits with a with a Attack the Target Character gains a <xsl:value-of select="modifier"/> modifier the <xsl:value-of select="save"/> saving throw
</xsl:template>

<xsl:template match="jump">
    Jump over things from a minimum of <xsl:value-of select="min"/>m to a maximum of <xsl:value-of select="max"/>m
</xsl:template>

<xsl:template match="reduceDifficulty">
    gains a <xsl:value-of select="node()"/> to all Difficulty Count Rolls
</xsl:template>

<xsl:template match="bounce">
    each time a Character is effected by this Action the nearest Charcter who has not yet been effected by this Action must make the corresponding save or take the effects of this Action
</xsl:template>

<xsl:template match="addActionAttribute">
    gains <xsl:if test="range"><xsl:value-of select="range"/>m range</xsl:if> <xsl:if test="difficulty"><xsl:value-of select="difficulty"/> difficulty</xsl:if>
</xsl:template>

<xsl:template match="createWeapon">
    creates and equips a <xsl:value-of select="name"/> of type <xsl:apply-templates select="type"/>,<xsl:if test="actions">rip</xsl:if><xsl:if test="passiveEffect">rip</xsl:if> with difficulty <xsl:value-of select="difficulty"/>, that takes <xsl:value-of select="time"/> Time Units to use, with range <xsl:value-of select="range"/>, aoe <xsl:apply-templates select="aoe"/> and deals <xsl:value-of select="damage"/>
</xsl:template>

<xsl:template match="ignoresCover">
    ignores cover
</xsl:template>

<xsl:template match="refill">
    gets completely refilled
</xsl:template>

<xsl:template match="damageHolder">
    character that has this must make a <xsl:value-of select="save"/> save or take <xsl:value-of select="amount"/> damage
</xsl:template>

<xsl:template match="move">
    move to a location up to <xsl:value-of select="node()"/>m away
</xsl:template>
</xsl:stylesheet>