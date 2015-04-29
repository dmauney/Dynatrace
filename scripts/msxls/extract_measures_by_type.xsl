<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="text" indent="no"/>
<xsl:strip-space  elements="*"/>
<xsl:template match="/">
  <xsl:text/>
  <xsl:apply-templates/> 
</xsl:template>

<xsl:template match="/dynatrace/systemprofile/measures/measure">
      Type:          Measure
      ID:            <xsl:value-of select="@id" />
      Desc:          <xsl:value-of select="@description" />
</xsl:template>

<xsl:template match="/dynatrace/systemprofile/transactions/transaction/value/measure">
      Type:          Business Transaction
      ID:            <xsl:value-of select="@id" />
	  Desc:          <xsl:value-of select="@description" />
	  <xsl:apply-templates select="thresholds"/>
</xsl:template>

<xsl:template match="/dynatrace/systemprofile/mastermonitors/mastermonitor/measures/measure">
      Type:          Monitor
      Monitor Type:  <xsl:value-of select="@metricgroupid" />
      ID:            <xsl:value-of select="@id" />
	  Desc:          <xsl:value-of select="@description" />
	  <xsl:apply-templates select="thresholds"/>
</xsl:template>

</xsl:stylesheet>
