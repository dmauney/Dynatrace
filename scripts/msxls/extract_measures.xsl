<?xml version="1.0"?>
<xsl:stylesheet 
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
     version="1.0">
     <xsl:strip-space  elements="*"/>
     <xsl:output  method="text" indent="no"/>
	 <xsl:template match="measure">
"<xsl:value-of select="@id" />","<xsl:value-of select="@description" />",<xsl:value-of select="thresholds/@threshold.upper.severe" />,<xsl:value-of select="thresholds/@threshold.upper.warning" />,<xsl:value-of select="thresholds/@threshold.lower.warning" />,<xsl:value-of select="thresholds/@threshold.lower.severe" />
    </xsl:template>
</xsl:stylesheet>
