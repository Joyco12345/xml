<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:key name="goroda" match="item" use="@city"/>
<xsl:key name="kompanii" match="item" use="concat(@city,'|',@org)"/>
<xsl:key name="tovary" match="item" use="concat(@city,'|',@org,'|',@title)"/>

<xsl:template match="/">
<html>
<head><title>Города</title></head>
<body>
<h1>Города и компании</h1>
<ul>
<xsl:for-each select="orgs/item[generate-id() = generate-id(key('goroda', @city)[1])]">
<li>
<h3><xsl:value-of select="@city"/></h3>
<p>Всего товаров: <xsl:value-of select="count(key('goroda', @city))"/></p>
<xsl:for-each select="key('goroda', @city)[generate-id() = generate-id(key('kompanii', concat(@city,'|',@org))[1])]">
<ul><li>
<h4><xsl:value-of select="@org"/></h4>
<p>Всего товаров: <xsl:value-of select="count(key('kompanii', concat(@city,'|',@org)))"/></p>
<ul>
<xsl:for-each select="key('kompanii', concat(@city,'|',@org))[generate-id() = generate-id(key('tovary', concat(@city,'|',@org,'|',@title))[1])]">
<li><xsl:value-of select="@title"/></li>
</xsl:for-each>
</ul>
</li></ul>
</xsl:for-each>
</li>
</xsl:for-each>
</ul>
</body>
</html>
</xsl:template>
</xsl:stylesheet>