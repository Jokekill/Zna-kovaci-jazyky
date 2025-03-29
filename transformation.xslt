<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Nastavení výstupu jako text (JSON) -->
  <xsl:output method="text" encoding="UTF-8" indent="yes"/>
  
  <!-- Šablona pro kořenový element healthcareData -->
  <xsl:template match="/healthcareData">
{
  "clinicInfo": "<xsl:value-of select="clinicInfo"/>",
  "departments": [
    <xsl:for-each select="department">
      <xsl:sort select="departmentName"/>
      {
        "id": "<xsl:value-of select="@id"/>",
        "name": "<xsl:value-of select="departmentName"/>",
        "doctors": [
          <xsl:for-each select="doctor">
            <xsl:sort select="doctorName"/>
            {
              "docID": "<xsl:value-of select="@docID"/>",
              "name": "<xsl:value-of select="doctorName"/>",
              "specialty": "<xsl:value-of select="specialty"/>",
              "schedule": {
                "days": [
                  <xsl:for-each select="schedule/day">
                    {
                      "name": "<xsl:value-of select="@name"/>",
                      "shifts": [
                        <xsl:for-each select="shift">
                          {
                            "start": "<xsl:value-of select="@start"/>",
                            "end": "<xsl:value-of select="@end"/>"
                          }<xsl:if test="position() != last()">,</xsl:if>
                        </xsl:for-each>
                      ]
                    }<xsl:if test="position() != last()">,</xsl:if>
                  </xsl:for-each>
                ]
              }
            }<xsl:if test="position() != last()">,</xsl:if>
          </xsl:for-each>
        ]
      }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
  ],
  "patients": [
    <xsl:for-each select="patients/patient">
      <xsl:sort select="patientName"/>
      {
        "patID": "<xsl:value-of select="@patID"/>",
        "name": "<xsl:value-of select="patientName"/>",
        "appointment": {
          "date": "<xsl:value-of select="appointment/appointmentDate"/>",
          "department": "<xsl:value-of select="appointment/refDepartment"/>",
          "doctor": "<xsl:value-of select="appointment/refDoctor"/>"
        }
      }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
  ],
  "newsArticles": [
    <xsl:for-each select="newsArticle">
      <xsl:sort select="datePublished"/>
      <xsl:choose>
        <!-- Podmínka: zobrazit jen články po 1. lednu 2025 -->
        <xsl:when test="datePublished &gt; '2025-01-01'">
          {
            "newsID": "<xsl:value-of select="@newsID"/>",
            "headline": "<xsl:value-of select="headline"/>",
            "body": "<xsl:value-of select="articleBody"/>",
            "datePublished": "<xsl:value-of select="datePublished"/>"
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <!-- Pokud podmínka není splněna, článek se přeskočí -->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  ]
}
  </xsl:template>
  
</xsl:stylesheet>
