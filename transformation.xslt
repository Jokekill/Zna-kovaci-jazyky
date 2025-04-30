<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Nastavení výstupu jako text -->
  <xsl:output method="text" encoding="UTF-8" indent="no"/>

  <!-- Hlavní šablona pro kořenový element -->
  <xsl:template match="/healthcareData">
{
  "departments": [
    <xsl:for-each select="department">
      <xsl:sort select="name"/>
      {
        "id": "<xsl:value-of select='@id'/>",
        "name": "<xsl:value-of select='name'/>",
        "doctors": [
          <xsl:for-each select="doctor">  
            <xsl:sort select="name"/>
            {
              "id": "<xsl:value-of select='@id'/>",
              "name": "<xsl:value-of select='name'/>",
              "specialty": "<xsl:value-of select='specialty'/>",
              "schedule": [
                <xsl:for-each select="schedule/day">
                  {
                    "day": "<xsl:value-of select='@name'/>",
                    "shifts": [
                      <xsl:for-each select="shift">
                        {
                          "start": "<xsl:value-of select='@start'/>",
                          "end": "<xsl:value-of select='@end'/>"
                        }<xsl:if test="position() != last()">,</xsl:if>
                      </xsl:for-each>
                    ]
                  }<xsl:if test="position() != last()">,</xsl:if>
                </xsl:for-each>
              ]
            }<xsl:if test="position() != last()">,</xsl:if>
          </xsl:for-each>
        ]
      }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
  ],

  "patients": [
    <xsl:for-each select="patients/patient">
      <xsl:sort select="name"/>
      {
        "id": "<xsl:value-of select='@id'/>",
        "name": "<xsl:value-of select='name'/>",
        "appointment": {
          "date": "<xsl:value-of select='appointment/date'/>",
          "department": "<xsl:value-of select='appointment/department/@ref'/>",
          "doctor": "<xsl:value-of select='appointment/doctor/@ref'/>"
        }
        <xsl:choose>
          <xsl:when test="contains(name, 'Eva')">
            ,"note": "Pacientka s preferencí dopoledních termínů"
          </xsl:when>
        </xsl:choose>
      }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
  ]
}
  </xsl:template>

</xsl:stylesheet>