<?xml version="1.0" encoding="UTF-8"?>
<!--MIT License

Copyright (c) 2020 ElderNoSpace
        
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
        
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
        
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" media-type="application/x-latex"/>

<xsl:template match="type[last()]"><!--TODO preceding-sibling::not[last()] probably wont work-->
    <xsl:if test="preceding-sibling::not[last()]">not </xsl:if><xsl:value-of select="."/>.
</xsl:template>

<xsl:template match="type[position()&lt;last()]">
    <xsl:if test="preceding-sibling::not[last()]">not </xsl:if><xsl:value-of select="."/><xsl:text>, </xsl:text>
</xsl:template>

</xsl:stylesheet>