<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="text" indent="no"/>
<xsl:strip-space  elements="*"/>
<xsl:template match="/">
  <xsl:text/>
  <xsl:apply-templates/> 
</xsl:template>

<xsl:template match="dynatrace">
  <xsl:apply-templates select="systemprofile"/>
</xsl:template>

<xsl:template match="systemprofile">
  <xsl:apply-templates select="incidentrules"/>
</xsl:template>

<xsl:template match="incidentrules">
  <xsl:apply-templates select="incidentrule"/>
</xsl:template>

<xsl:template match="incidentrule">
Rule: <xsl:value-of select="@id" /><xsl:if test="@flags='0'"><xsl:text> (Inactive)</xsl:text></xsl:if>
  <xsl:apply-templates select="conditions"/>
</xsl:template>

<xsl:template match="conditions">
  <xsl:apply-templates select="condition"/>
</xsl:template>

<xsl:template match="condition">
      Measure:       <xsl:value-of select="@refmeasure" /> 
	  Severity:      <xsl:value-of select="@thresholdseverity" /> 
	  Aggregate:     <xsl:value-of select="@aggregate" /> 
	  Metric:        <xsl:value-of select="@refmetric" /> 
	  Operator:      <xsl:value-of select="@logicaloperator" /> 
 <xsl:apply-templates select="/dynatrace/systemprofile/measures/measure[@id=current()/@refmeasure]"/>
 <xsl:apply-templates select="/dynatrace/systemprofile/transactions/transaction/value/measure[@id=current()/@refmeasure]"/>
 <xsl:apply-templates select="/dynatrace/systemprofile/mastermonitors/mastermonitor[@id=current()/@refagent]/measures/measure[@id=current()/@refmeasure]"/>
</xsl:template>

<xsl:template match="/dynatrace/systemprofile/measures/measure">
      Type:          Measure
      Desc:          <xsl:value-of select="@description" />
	  <xsl:apply-templates select="thresholds"/>
</xsl:template>
<xsl:template match="thresholds">
	  <xsl:if test="@threshold.upper.severe!=''">
	  Upper Severe:  <xsl:value-of select="@threshold.upper.severe" />
	  </xsl:if>
	  <xsl:if test="@threshold.upper.warning!=''">
	  Upper Warning: <xsl:value-of select="@threshold.upper.warning" />
	  </xsl:if>
	  <xsl:if test="@threshold.lower.warning!=''">
	  Lower Warning: <xsl:value-of select="@threshold.lower.warning" />
	  </xsl:if>
	  <xsl:if test="@threshold.lower.severe!=''">
	  Lower Severe:  <xsl:value-of select="@threshold.lower.severe" />
	  </xsl:if>
</xsl:template>

<xsl:template match="/dynatrace/systemprofile/transactions/transaction/value/measure">
      Type:          Business Transaction
	  Desc:          <xsl:value-of select="@description" />
	  <xsl:apply-templates select="thresholds"/>
</xsl:template>

<xsl:template match="/dynatrace/systemprofile/mastermonitors/mastermonitor/measures/measure">
      Type:          Monitor
      Monitor Type:  <xsl:value-of select="@metricgroupid" />
	  Desc:          <xsl:value-of select="@description" />
	  <xsl:apply-templates select="thresholds"/>
</xsl:template>
</xsl:stylesheet>

<!--
      <incidentrule id="Excessive Serious Exceptions" flags="1" incidentdashboardname="SeriousExceptions" description="" timeframe="300">
        <conditions>
          <condition aggregate="count" logicaloperator="or" thresholdseverity="severe" refmetric="Count" refmetricgroup="Exceptions" refmeasure="Count org.jboss.util.NestedSQLException-Unable to get managed connection" />
          <condition aggregate="sum" logicaloperator="and" thresholdseverity="severe" refmetric="Count" refmetricgroup="Exceptions" refmeasure="Count com.nm.utils.keyedmutex.KeyedMutexException-Exceeded timeout" />
        </conditions>
-->
