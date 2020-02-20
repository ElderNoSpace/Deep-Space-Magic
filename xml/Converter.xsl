<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" media-type="application/x-latex"/>

<xsl:import href="action.xsl"/>
<xsl:import href="equipment.xsl"/>
<xsl:import href="downtime.xsl"/>

<xsl:template match="section"><!--Loop over the categories-->
    <xsl:apply-templates select="category"/>
</xsl:template>

<xsl:template match="category"><!--Create a subsection and apply templates to children
    --><xsl:if test="index">\index{<xsl:value-of select="index"/>}</xsl:if>
    \subsection{<xsl:value-of select="name"/>}
    <xsl:if test="description"><xsl:value-of select="description"/>\\</xsl:if>
    <xsl:apply-templates select="subcategory"/>
    <xsl:call-template name="subdoc-reftex-things"/>
</xsl:template>

<xsl:template match="subcategory"><!--Create a subsubsection and apply templates to children
    --><xsl:if test="index">\index{<xsl:value-of select="index"/>}</xsl:if>
    \subsubsection{<xsl:value-of select="name"/>}
    <xsl:if test="description"><xsl:value-of select="description"/>\\</xsl:if>
    <xsl:call-template name="subdoc-reftex-things"/>
</xsl:template>

<!--Parse subdocs, link reftex using \subimport, apply things template-->
<xsl:template name="subdoc-reftex-things">
    <xsl:choose>
        <xsl:when test="filename">
            <xsl:apply-templates select="document(subdoc/@ref)">
                <xsl:with-param name="categoryName"><xsl:value-of select="translate(filename, ' ', '')" /></xsl:with-param>
            </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="document(subdoc/@ref)">
                <xsl:with-param name="categoryName"><xsl:value-of select="translate(name, ' ', '')" /></xsl:with-param>
            </xsl:apply-templates>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:for-each select="reftex">
        \subimport{.}{<xsl:value-of select="@ref"/>}
    </xsl:for-each>
    <xsl:apply-templates select="things"/>
</xsl:template>

<!--Call template on all things's children-->
<xsl:template match="things">
    <xsl:choose>
        <xsl:when test="parent::node()/filename">
            <xsl:apply-templates select="child::*">
                <xsl:with-param name="categoryName"><xsl:value-of select="translate(parent::node()/filename, ' ', '')" /></xsl:with-param>
            </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="child::*">
                <xsl:with-param name="categoryName"><xsl:value-of select="translate(parent::node()/name, ' ', '')" /></xsl:with-param>
            </xsl:apply-templates>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>