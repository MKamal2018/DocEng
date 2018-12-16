<?xml version="1.0" encoding="utf-8"?>
<!--	Created By	: Mohammed Abdel-Fattah Soliman
	Created	on	: Jan. 9, 2008
	Modification History:
    Modified on: Feb. 19, 2008  By: Mohammed AbdelFattah
    Modified on: Feb. 19, 2008  By: Wael Abdelsattar
    Modified on: Feb. 20, 2008	By: Mohammed AbdelFattah 
    Last Modified: Feb. 27, 2008By:	Mohammed AbdelFattah-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink">
  <!--<xsl:output method="text"/>-->
  <!--<xsl:variable name="titlesCase">lower</xsl:variable>-->
  <!--Conversion type value:0 for Tex,1 for HTML-->
  <xsl:param name="ConversionType">0</xsl:param>
  <xsl:template match="back">
    <xsl:if test="$ConversionType='1'">
      <xsl:if test="app-group">
        <xsl:apply-templates select="app-group"/>
      </xsl:if>
      <xsl:if test="ack">
        <xsl:apply-templates select="ack"/>
      </xsl:if>
      <xsl:if test="notes">
        <xsl:apply-templates select="notes"/>
      </xsl:if>
      <xsl:if test="count(//ref-list)">
        <xsl:apply-templates select="ref-list"/>
      </xsl:if>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ref-list">
    <xsl:choose>
      <xsl:when test="$ConversionType='0'">
        <xsl:text>\providecommand{\bysame}{\leavevmode\hbox to3em{\hrulefill}\thinspace}
				\begin{thebibliography}{10}
				 
	</xsl:text>
        <xsl:for-each select="ref">
          <xsl:text>\bibitem{</xsl:text>
          <xsl:apply-templates select="label"/>
          <xsl:text>}
		</xsl:text>
          <xsl:apply-templates select="nlm-citation"/>
          <xsl:text>
	</xsl:text>
        </xsl:for-each>
        <xsl:text>
\end{thebibliography}		 
	 </xsl:text>
      </xsl:when>
      <xsl:when test="$ConversionType='1'">
        <ol class="ref-list">
          <xsl:for-each select="ref">
            <li class="ref-item" id="{@id}">
              <xsl:apply-templates select="nlm-citation"/>
            </li>
          </xsl:for-each>
        </ol>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="article-title">
    <xsl:if test="parent::nlm-citation/parent::ref[@content-type='missing']">
      <xsl:text>\fbox{\parbox{375pt}{</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="nlm-citation">
    <xsl:choose>
      <xsl:when test="@publication-type='journal' or @publication-type='other'">
        <xsl:choose>
          <xsl:when test="person-group[@person-group-type='author']">
            <xsl:apply-templates select="person-group[@person-group-type='author']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="person-group[@person-group-type='editor']">
              <xsl:apply-templates select="person-group[@person-group-type='editor']"/>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="article-title">
          <xsl:if test="person-group">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='0'">
            <xsl:text>``</xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='1'">
            <xsl:text>&#x201C;</xsl:text>
          </xsl:if>
          <xsl:apply-templates select="article-title"/>
          <xsl:choose>
            <xsl:when test="supplement or source or publisher-name or publisher-loc or volume or issue or fpage or lpage or edition or (comment and not(normalize-space(comment/text())='.') and not(article-title[@xml:lang])) or year">
              <xsl:if test="not(substring(normalize-space(article-title),string-length(normalize-space(article-title)),1)='?')">
                <xsl:text>,</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="source">
          <xsl:choose>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="source"/>
        </xsl:if>
        <xsl:if test="publisher-name">
          <xsl:choose>
            <xsl:when test="source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="publisher-name"/>
        </xsl:if>
        <xsl:if test="publisher-loc">
          <xsl:choose>
            <xsl:when test="publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="publisher-loc"/>
        </xsl:if>
        <xsl:if test="volume">
          <xsl:choose>
            <xsl:when test="publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:text>vol. </xsl:text>
          <xsl:apply-templates select="volume"/>
        </xsl:if>
        <xsl:if test="supplement">
          <xsl:choose>
            <xsl:when test="volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="normalize-space(supplement/text())"/>
        </xsl:if>
        <xsl:if test="issue">
          <xsl:choose>
            <xsl:when test="supplement or volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:text>no. </xsl:text>
          <xsl:apply-templates select="issue"/>
        </xsl:if>
        <xsl:if test="pub-id[@pub-id-type='publisher-id']">
          <xsl:choose>
            <xsl:when test="supplement or volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:text>Article ID </xsl:text>
          <xsl:value-of select="normalize-space(pub-id[@pub-id-type='publisher-id']/text())"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="fpage and lpage">
            <xsl:choose>
              <xsl:when test="pub-id[@pub-id-type='publisher-id'] or issue or supplement or volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group and not(source)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:text>pp. </xsl:text>
            <xsl:call-template name="deff">
              <xsl:with-param name="fpage" select="fpage"/>
              <xsl:with-param name="lpage" select="lpage"/>
              <xsl:with-param name="ConversionType" select="$ConversionType"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="fpage">
            <xsl:choose>
              <xsl:when test="pub-id[@pub-id-type='publisher-id'] or issue or supplement or volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group and not(source)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:choose>
              <xsl:when test="contains(normalize-space(fpage/text()),'pages')">
                <xsl:message terminate="yes">Error: Fpage has 'pages' please remove it</xsl:message>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>p. </xsl:text>
                <xsl:apply-templates select="fpage"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="lpage">
            <xsl:choose>
              <xsl:when test="pub-id[@pub-id-type='publisher-id'] or issue or supplement or volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group and not(source)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:choose>
              <xsl:when test="contains(normalize-space(lpage/text()),'pages')">
                <xsl:value-of select="normalize-space(substring(normalize-space(lpage/text()),1,string-length(normalize-space(lpage/text()))-5))"/>
                <xsl:text> pages</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="page" select="lpage"/>
                <xsl:apply-templates select="lpage"/>
                <xsl:text> page</xsl:text>
                <xsl:if test="$page - 1 != 0">s</xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
        </xsl:choose>
        <xsl:if test="edition">
          <xsl:choose>
            <xsl:when test="fpage or lpage or pub-id[@pub-id-type='publisher-id'] or issue or supplement or volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="edition"/>
          <xsl:text> edition</xsl:text>
        </xsl:if>
        <xsl:if test="month">
          <xsl:choose>
            <xsl:when test="edition or fpage or lpage or pub-id[@pub-id-type='publisher-id'] or issue or supplement or volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="month"/>
        </xsl:if>
        <xsl:if test="year">
          <xsl:choose>
            <xsl:when test="month">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="edition or fpage or lpage or pub-id[@pub-id-type='publisher-id']  or issue or supplement or volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="year"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="article-title[@xml:lang]">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="GetLanguage">
              <xsl:with-param name="LanguagePrefix">
                <xsl:value-of select="article-title/@xml:lang"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:when test="source[@xml:lang]">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="GetLanguage">
              <xsl:with-param name="LanguagePrefix">
                <xsl:value-of select="source/@xml:lang"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="comment and not(normalize-space(comment)='.')">
            <xsl:choose>
              <xsl:when test="year or month or edition or fpage or lpage or pub-id[@pub-id-type='publisher-id']  or issue or supplement or volume or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')) or article-title[@xml:lang]">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group and not(source)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="comment"/>
            <xsl:if test="$ConversionType='0'">
              <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="person-group[@person-group-type='author']/etal and (not(article-title[@xml:lang]) or not(source[@xml:lang])) and not(month) and not(year) and not(edition) and not(fpage) and not(lpage) and not(publisher-name) and not(publisher-loc) and not(article-title) and not(source) and not(volume) and not(issue)"/>
              <xsl:when test="contains(normalize-space(person-group[@person-group-type='author']/name[position()=last()]/suffix/text()),'.') and not(person-group[@person-group-type='editor']) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage) and not(lpage) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)"/>
              <xsl:when test="contains(normalize-space(person-group[@person-group-type='author']/name[position()=last()]/surname/text()),'.') and not(person-group[@person-group-type='editor']) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage) and not(lpage) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)"/>
              <xsl:when test="person-group[@person-group-type='editor'] and (not(article-title[@xml:lang]) or not(source[@xml:lang])) and not(month) and not(year) and not(edition) and not(fpage) and not(lpage) and not(publisher-name) and not(publisher-loc) and not(article-title) and not(source) and not(volume) and not(issue)"/>
              <xsl:otherwise>
                <xsl:text>.</xsl:text>
                <xsl:if test="$ConversionType='0'">
                  <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@publication-type = 'book'">
        <xsl:choose>
          <xsl:when test="parent::ref[@content-type='proceedings'] or parent::ref[@content-type='book']">
            <xsl:if test="person-group[@person-group-type='author']">
              <xsl:apply-templates select="person-group[@person-group-type='author']"/>
            </xsl:if>
            <xsl:if test="person-group[@person-group-type='editor'] and not(person-group[@person-group-type='author'])">
              <xsl:apply-templates select="person-group[@person-group-type='editor']"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="person-group[@person-group-type='author']">
              <xsl:apply-templates select="person-group[@person-group-type='author']"/>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="article-title">
          <xsl:if test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group)">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='0'">
            <xsl:text>``</xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='1'">
            <xsl:text>&#x201C;</xsl:text>
          </xsl:if>
          <xsl:apply-templates select="article-title"/>
          <xsl:choose>
            <xsl:when test="supplement or source or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or volume or series or issue or chapter or (fpage and not(parent::ref[@content-type='book'])) or (lpage and not(parent::ref[@content-type='book'])) or publisher-name or publisher-loc or edition or month or year or (comment and not(normalize-space(comment/text())='.'))">
              <xsl:if test="not(substring(normalize-space(article-title),string-length(normalize-space(article-title)),1)='?')">
                <xsl:text>,</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
              <xsl:if test="parent::ref[@content-type='missing']">
                <xsl:text>}}\vspace{5pt}</xsl:text>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="source">
          <xsl:choose>
            <xsl:when test="parent::ref/@content-type='book' or parent::ref/@content-type='proceedings'">
              <xsl:choose>
                <xsl:when test="article-title">
                  <xsl:text> </xsl:text>
                </xsl:when>
                <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group)">
                  <xsl:text>, </xsl:text>
                </xsl:when>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="parent::ref/@content-type='incollection'">
              <xsl:choose>
                <xsl:when test="not(article-title) and not(person-group[@person-group-type='author']) and person-group[@person-group-type='editor'] and fpage and lpage">
                  <xsl:text> </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="article-title">
                      <xsl:text> in </xsl:text>
                    </xsl:when>
                    <xsl:when test="person-group[@person-group-type='author']">
                      <xsl:text>, in </xsl:text>
                    </xsl:when>
                    <xsl:when test="fpage or lpage">
                      <xsl:text> in </xsl:text>
                    </xsl:when>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="article-title">
                  <xsl:text> in </xsl:text>
                </xsl:when>
                <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group)">
                  <xsl:text>, in </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>in </xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="source"/>
        </xsl:if>
        <xsl:if test="not(parent::ref[@content-type='proceedings'])">
          <xsl:if test="person-group[@person-group-type='editor'] and person-group[@person-group-type='author']">
            <xsl:choose>
              <xsl:when test="source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='author'] and not(source)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="person-group[@person-group-type='editor']"/>
          </xsl:if>
        </xsl:if>
        <xsl:if test="volume">
          <xsl:choose>
            <xsl:when test="person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))">
              <xsl:text>, vol. </xsl:text>
            </xsl:when>
            <xsl:when test="source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, vol. </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> vol. </xsl:text>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
              <xsl:text>, vol. </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>vol. </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="volume"/>
        </xsl:if>
        <xsl:if test="series">
          <xsl:choose>
            <xsl:when test="volume">
              <xsl:text> of </xsl:text>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>\emph{</xsl:text>
                <xsl:value-of select="normalize-space(series)"/>
                <xsl:text>}</xsl:text>
                <xsl:apply-templates select="series"/>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <i>
                  <xsl:apply-templates select="series"/>
                </i>
              </xsl:if>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="normalize-space(series)"/>
              <xsl:apply-templates select="series"/>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
              <xsl:value-of select="series"/>
              <xsl:apply-templates select="series"/>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="normalize-space(series)"/>
              <xsl:apply-templates select="series"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="normalize-space(series)"/>
              <xsl:apply-templates select="series"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="supplement">
          <xsl:choose>
            <xsl:when test="series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="normalize-space(supplement/text())"/>
        </xsl:if>
        <xsl:if test="issue">
          <xsl:choose>
            <xsl:when test="supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:text>no. </xsl:text>
          <xsl:apply-templates select="issue"/>
        </xsl:if>
        <xsl:if test="chapter">
          <xsl:choose>
            <xsl:when test="issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:text>chapter </xsl:text>
          <xsl:apply-templates select="chapter"/>
        </xsl:if>
        <xsl:if test="not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])">
          <xsl:choose>
            <xsl:when test="fpage and lpage">
              <xsl:choose>
                <xsl:when test="chapter or issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
                  <xsl:text>, </xsl:text>
                </xsl:when>
                <xsl:when test="article-title">
                  <xsl:text> </xsl:text>
                </xsl:when>
                <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
                  <xsl:text>, </xsl:text>
                </xsl:when>
              </xsl:choose>
              <xsl:text>pp. </xsl:text>
              <xsl:call-template name="deff">
                <xsl:with-param name="fpage" select="fpage"/>
                <xsl:with-param name="lpage" select="lpage"/>
                <xsl:with-param name="ConversionType" select="$ConversionType"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="fpage">
              <xsl:choose>
                <xsl:when test="chapter or issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
                  <xsl:text>, </xsl:text>
                </xsl:when>
                <xsl:when test="article-title">
                  <xsl:text> </xsl:text>
                </xsl:when>
                <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
                  <xsl:text>, </xsl:text>
                </xsl:when>
              </xsl:choose>
              <xsl:text>p. </xsl:text>
              <xsl:apply-templates select="fpage"/>
            </xsl:when>
            <xsl:when test="lpage">
              <xsl:choose>
                <xsl:when test="chapter or issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
                  <xsl:text>, </xsl:text>
                </xsl:when>
                <xsl:when test="article-title">
                  <xsl:text> </xsl:text>
                </xsl:when>
                <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
                  <xsl:text>, </xsl:text>
                </xsl:when>
              </xsl:choose>
              <xsl:text>p. </xsl:text>
              <xsl:apply-templates select="lpage"/>
            </xsl:when>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="publisher-name">
          <xsl:choose>
            <xsl:when test="(fpage and not(parent::ref[@content-type='book'])) or (lpage and not(parent::ref[@content-type='book'])) or chapter or issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title or parent::ref[@content-type='book']">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="publisher-name"/>
        </xsl:if>
        <xsl:if test="publisher-loc">
          <xsl:choose>
            <xsl:when test="publisher-name or (fpage and not(parent::ref[@content-type='book'])) or (lpage and not(parent::ref[@content-type='book'])) or chapter or issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="publisher-loc"/>
        </xsl:if>
        <xsl:if test="edition">
          <xsl:choose>
            <xsl:when test="publisher-loc or publisher-name or (fpage and not(parent::ref[@content-type='book'])) or (lpage and not(parent::ref[@content-type='book'])) or chapter or issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="edition"/>
          <xsl:text> edition</xsl:text>
        </xsl:if>
        <xsl:if test="month">
          <xsl:choose>
            <xsl:when test="edition or publisher-loc or publisher-name or (fpage and not(parent::ref[@content-type='book'])) or (lpage and not(parent::ref[@content-type='book'])) or chapter or issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="month"/>
        </xsl:if>
        <xsl:if test="year">
          <xsl:choose>
            <xsl:when test="month">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="edition or publisher-loc or publisher-name or (fpage and not(parent::ref[@content-type='book'])) or (lpage and not(parent::ref[@content-type='book'])) or chapter or issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="year"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="comment and not(normalize-space(comment/text())='.')">
            <xsl:choose>
              <xsl:when test="year or month or edition or publisher-loc or publisher-name or (fpage and not(parent::ref[@content-type='book'])) or (lpage and not(parent::ref[@content-type='book'])) or chapter or issue or supplement or series or volume or (person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="(person-group[@person-group-type='author'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings'])))  or ((parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings']) and person-group and not(source))">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="comment"/>
            <xsl:if test="$ConversionType='0'">
              <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="(person-group[@person-group-type='editor'] and (not(parent::ref[@content-type='book']) and not(parent::ref[@content-type='proceedings']))) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage and not(parent::ref[@content-type='book'])) and not(lpage and not(parent::ref[@content-type='book'])) and not(chapter) and not(issue) and not(series) and not(volume)">
              </xsl:when>
              <xsl:when test="(person-group[@person-group-type='editor'] and not(person-group[@person-group-type='author']) and (parent::ref[@content-type='book'] or parent::ref[@content-type='proceedings'])) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage and not(parent::ref[@content-type='book'])) and not(lpage and not(parent::ref[@content-type='book'])) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='author']/etal and not(person-group[@person-group-type='editor']) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage and not(parent::ref[@content-type='book'])) and not(lpage and not(parent::ref[@content-type='book'])) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="contains(normalize-space(person-group[@person-group-type='author']/name[position()=last()]/suffix/text()),'.') and not(person-group[@person-group-type='editor']) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage and not(parent::ref[@content-type='book'])) and not(lpage and not(parent::ref[@content-type='book'])) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="contains(normalize-space(person-group[@person-group-type='author']/name[position()=last()]/surname/text()),'.') and not(person-group[@person-group-type='editor']) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage) and not(lpage) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>.</xsl:text>
                <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@publication-type = 'confproc'">
        <xsl:if test="person-group[@person-group-type='author']">
          <xsl:apply-templates select="person-group[@person-group-type='author']"/>
        </xsl:if>
        <xsl:if test="article-title">
          <xsl:if test="person-group[@person-group-type='author']">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='0'">
            <xsl:text>``</xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='1'">
            <xsl:text>&#x201C;</xsl:text>
          </xsl:if>
          <xsl:apply-templates select="article-title"/>
          <xsl:choose>
            <xsl:when test="conf-name or volume or series or supplement or issue or person-group[@person-group-type='editor'] or fpage or lpage or conf-loc or conf-date or (comment and not(normalize-space(comment/text())='.'))">
              <xsl:if test="not(substring(normalize-space(article-title),string-length(normalize-space(article-title)),1)='?')">
                <xsl:text>,</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="conf-name">
          <xsl:choose>
            <xsl:when test="article-title">
              <xsl:text> in </xsl:text>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='author']">
              <xsl:text>, in </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>in </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="conf-name"/>
        </xsl:if>
        <xsl:if test="person-group[@person-group-type='editor']">
          <xsl:choose>
            <xsl:when test="conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="person-group[@person-group-type='editor']"/>
        </xsl:if>
        <xsl:if test="volume">
          <xsl:choose>
            <xsl:when test="person-group[@person-group-type='editor'] or conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:text>vol. </xsl:text>
          <xsl:apply-templates select="volume"/>
        </xsl:if>
        <xsl:if test="series">
          <xsl:choose>
            <xsl:when test="volume">
              <xsl:text> of </xsl:text>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>\emph{</xsl:text>
                <xsl:value-of select="normalize-space(series)"/>
                <xsl:text>}</xsl:text>
                <xsl:apply-templates select="series"/>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <i>
                  <xsl:apply-templates select="series"/>
                </i>
              </xsl:if>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='editor'] or conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?')">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="normalize-space(series)"/>
              <xsl:apply-templates select="series"/>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
              <xsl:value-of select="normalize-space(series)"/>
              <xsl:apply-templates select="series"/>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="normalize-space(series)"/>
              <xsl:apply-templates select="series"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="normalize-space(series)"/>
              <xsl:apply-templates select="series"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="supplement">
          <xsl:choose>
            <xsl:when test=" volume or series or person-group[@person-group-type='editor'] or conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="normalize-space(supplement/text())"/>
        </xsl:if>
        <xsl:if test="issue">
          <xsl:choose>
            <xsl:when test="supplement or series or volume or person-group[@person-group-type='editor'] or (conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:text>no. </xsl:text>
          <xsl:apply-templates select="issue"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="fpage and lpage">
            <xsl:choose>
              <xsl:when test="issue or supplement or series or volume or person-group[@person-group-type='editor'] or (conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:text>pp. </xsl:text>
            <xsl:call-template name="deff">
              <xsl:with-param name="fpage" select="fpage"/>
              <xsl:with-param name="lpage" select="lpage"/>
              <xsl:with-param name="ConversionType" select="$ConversionType"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="fpage">
            <xsl:choose>
              <xsl:when test="issue or supplement or series or volume or person-group[@person-group-type='editor'] or (conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:text>p. </xsl:text>
            <xsl:apply-templates select="fpage"/>
          </xsl:when>
          <xsl:when test="lpage">
            <xsl:choose>
              <xsl:when test="issue or supplement or series or volume or person-group[@person-group-type='editor'] or (conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="lpage"/>
            <xsl:text> pages</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:if test="publisher-name">
          <xsl:choose>
            <xsl:when test="fpage or lpage or issue or supplement or series or volume or person-group[@person-group-type='editor'] or conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="publisher-name"/>
        </xsl:if>
        <xsl:if test="conf-loc">
          <xsl:choose>
            <xsl:when test="publisher-name or fpage or lpage or issue or supplement or series or volume or person-group[@person-group-type='editor'] or conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="conf-loc"/>
        </xsl:if>
        <xsl:if test="conf-date">
          <xsl:choose>
            <xsl:when test="conf-loc or publisher-name or fpage or lpage or issue or supplement or series or volume or person-group[@person-group-type='editor'] or conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="conf-date"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="article-title[@xml:lang]">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="GetLanguage">
              <xsl:with-param name="LanguagePrefix">
                <xsl:value-of select="article-title/@xml:lang"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:when test="source[@xml:lang]">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="GetLanguage">
              <xsl:with-param name="LanguagePrefix">
                <xsl:value-of select="source/@xml:lang"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="comment and not(normalize-space(comment/text())='.')">
            <xsl:choose>
              <xsl:when test="conf-date or conf-loc or publisher-name or fpage or lpage or issue or supplement or series or volume or person-group[@person-group-type='editor'] or conf-name and not(substring(normalize-space(conf-name/text()),string-length(normalize-space(conf-name/text())),1)='?')">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='author'] and not(conf-name)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="comment"/>
            <xsl:if test="$ConversionType='0'">
              <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="person-group[@person-group-type='author']/etal and not(article-title) and not(conf-name) and  not(person-group[@person-group-type='editor']) and not(volume) and not(series) and not(issue) and not(fpage) and not(lpage) and not(publisher-name) and not(conf-loc) and not(conf-date) and not(comment and not(normalize-space(comment/text())='.'))">
              </xsl:when>
              <xsl:when test="contains(normalize-space(person-group[@person-group-type='author']/name/suffix/text()),'.') and not(article-title) and not(conf-name) and not(person-group[@person-group-type='editor']) and not(volume) and not(series) and not(issue) and not(fpage) and not(lpage) and not(publisher-name) and not(conf-loc) and not(conf-date) and not(comment and not(normalize-space(comment/text())='.'))">
              </xsl:when>
              <xsl:when test="contains(normalize-space(person-group[@person-group-type='author']/name[position()=last()]/surname/text()),'.') and not(person-group[@person-group-type='editor']) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage) and not(lpage) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='editor'] and not(volume) and not(series) and not(issue) and not(fpage) and not(lpage) and not(publisher-name) and not(conf-loc) and not(conf-date) and not(comment and not(normalize-space(comment/text())='.'))">
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>.</xsl:text>
                <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@publication-type = 'thesis'">
        <xsl:choose>
          <xsl:when test="person-group[@person-group-type='author']">
            <xsl:apply-templates select="person-group[@person-group-type='author']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="person-group[@person-group-type='editor']">
              <xsl:apply-templates select="person-group[@person-group-type='editor']"/>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="article-title">
          <xsl:if test="person-group">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='0'">
            <xsl:text>``</xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='1'">
            <xsl:text>&#x201C;</xsl:text>
          </xsl:if>
          <xsl:apply-templates select="article-title"/>
          <xsl:choose>
            <xsl:when test="source or publisher-name or publisher-loc or month or year or (comment and not(normalize-space(comment/text())='.'))">
              <xsl:if test="not(substring(normalize-space(article-title),string-length(normalize-space(article-title)),1)='?')">
                <xsl:text>,</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="source">
          <xsl:choose>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="source"/>
        </xsl:if>
        <xsl:if test="publisher-name">
          <xsl:choose>
            <xsl:when test="source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="publisher-name"/>
        </xsl:if>
        <xsl:if test="publisher-loc">
          <xsl:choose>
            <xsl:when test="publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="publisher-loc"/>
        </xsl:if>
        <xsl:if test="month">
          <xsl:choose>
            <xsl:when test="publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="month"/>
        </xsl:if>
        <xsl:if test="year">
          <xsl:choose>
            <xsl:when test="month">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="year"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="article-title[@xml:lang]">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="GetLanguage">
              <xsl:with-param name="LanguagePrefix">
                <xsl:value-of select="article-title/@xml:lang"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:when test="source[@xml:lang]">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="GetLanguage">
              <xsl:with-param name="LanguagePrefix">
                <xsl:value-of select="source/@xml:lang"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="comment and not(normalize-space(comment/text())='.')">
            <xsl:choose>
              <xsl:when test="year or month or publisher-loc or publisher-name or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="person-group and not(source)">
                <xsl:text>, </xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="comment"/>
            <xsl:if test="$ConversionType='0'">
              <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="person-group[@person-group-type='author']/etal and not(year) and not(month) and not(publisher-loc) and not(publisher-name) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="normalize-space(person-group[@person-group-type='author']/name/suffix/text())='Jr.' and not(person-group[@person-group-type='editor']) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage and not(parent::ref[@content-type='book'])) and not(lpage and not(parent::ref[@content-type='book'])) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="contains(normalize-space(person-group[@person-group-type='author']/name[position()=last()]/surname/text()),'.') and not(person-group[@person-group-type='editor']) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage) and not(lpage) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='editor'] and not(year) and not(month) and not(publisher-loc) and not(publisher-name) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>.</xsl:text>
                <xsl:if test="$ConversionType='0'">
                  <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@publication-type = 'gov'">
        <xsl:choose>
          <xsl:when test="person-group[@person-group-type='author'] and not(person-group[@person-group-type='author']/following-sibling::*)">
            <xsl:apply-templates select="person-group[@person-group-type='author']"/>
            <xsl:text>,Tech. Rep.</xsl:text>
          </xsl:when>
          <xsl:when test="person-group[@person-group-type='author']">
            <xsl:apply-templates select="person-group[@person-group-type='author']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="person-group[@person-group-type='editor'] and not(person-group[@person-group-type='editor']/following-sibling::*)">
                <xsl:apply-templates select="person-group[@person-group-type='editor']"/>
                <xsl:text>,Tech. Rep.</xsl:text>
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='editor']">
                <xsl:apply-templates select="person-group[@person-group-type='editor']"/>
              </xsl:when>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="article-title">
          <xsl:if test="person-group">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='0'">
            <xsl:text>``</xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='1'">
            <xsl:text>&#x201C;</xsl:text>
          </xsl:if>
          <xsl:apply-templates select="article-title"/>
          <xsl:choose>
            <xsl:when test="source or fpage or lpage or publisher-name or issue or publisher-loc or month or year or (comment and not(normalize-space(comment/text())='.'))">
              <xsl:if test="not(substring(normalize-space(article-title),string-length(normalize-space(article-title)),1)='?')">
                <xsl:text>,</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:when test="not(following-sibling::*)">
              <xsl:if test="not(substring(normalize-space(article-title),string-length(normalize-space(article-title)),1)='?')">
                <xsl:text>,</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>'' Tech. Rep.</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D; Tech. Rep.</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$ConversionType='0'">
                <xsl:text>''</xsl:text>
              </xsl:if>
              <xsl:if test="$ConversionType='1'">
                <xsl:text>&#x201D;</xsl:text>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="source">
          <xsl:choose>
            <xsl:when test="article-title">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="person-group">
              <xsl:text>, </xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="source"/>
        </xsl:if>
        <xsl:if test="issue">
          <xsl:choose>
            <xsl:when test="source">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="article-title and not(source)">
              <xsl:text> Tech. Rep. </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, Tech. Rep. </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> Tech.Rep. </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="issue"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="fpage and lpage">
            <xsl:choose>
              <xsl:when test="issue or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> Tech. Rep., </xsl:text>
              </xsl:when>
              <xsl:when test="person-group and not(source)">
                <xsl:text>, Tech. Rep., </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text> Tech. Rep., </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>pp. </xsl:text>
            <xsl:call-template name="deff">
              <xsl:with-param name="fpage" select="fpage"/>
              <xsl:with-param name="lpage" select="lpage"/>
              <xsl:with-param name="ConversionType" select="$ConversionType"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="fpage">
            <xsl:choose>
              <xsl:when test="issue or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> Tech. Rep., </xsl:text>
              </xsl:when>
              <xsl:when test="person-group and not(source)">
                <xsl:text>, Tech. Rep., </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text> Tech. Rep., </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>p. </xsl:text>
            <xsl:apply-templates select="fpage"/>
          </xsl:when>
          <xsl:when test="lpage">
            <xsl:choose>
              <xsl:when test="issue or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> Tech. Rep., </xsl:text>
              </xsl:when>
              <xsl:when test="person-group and not(source)">
                <xsl:text>, Tech. Rep., </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text> Tech. Rep., </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>p. </xsl:text>
            <xsl:apply-templates select="lpage"/>
          </xsl:when>
        </xsl:choose>
        <xsl:if test="publisher-name">
          <xsl:choose>
            <xsl:when test="issue or fpage or lpage or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> Tech. Rep., </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, Tech. Rep., </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> Tech. Rep., </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="publisher-name"/>
        </xsl:if>
        <xsl:if test="publisher-loc">
          <xsl:choose>
            <xsl:when test="issue or publisher-name or fpage or lpage or (source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?'))">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> Tech. Rep., </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, Tech. Rep., </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> Tech. Rep., </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="publisher-loc"/>
        </xsl:if>
        <xsl:if test="month">
          <xsl:choose>
            <xsl:when test="publisher-loc or publisher-name or fpage or lpage or issue or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> Tech. Rep., </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, Tech. Rep., </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> Tech. Rep., </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="month"/>
        </xsl:if>
        <xsl:if test="year">
          <xsl:choose>
            <xsl:when test="month">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="publisher-loc or publisher-name or fpage or lpage or issue or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="article-title">
              <xsl:text> Tech. Rep., </xsl:text>
            </xsl:when>
            <xsl:when test="person-group and not(source)">
              <xsl:text>, Tech. Rep., </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> Tech. Rep., </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="year"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="article-title[@xml:lang]">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="GetLanguage">
              <xsl:with-param name="LanguagePrefix">
                <xsl:value-of select="article-title/@xml:lang"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:when test="source[@xml:lang]">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="GetLanguage">
              <xsl:with-param name="LanguagePrefix">
                <xsl:value-of select="source/@xml:lang"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="comment and not(normalize-space(comment/text())='.')">
            <xsl:choose>
              <xsl:when test="year or month or publisher-loc or publisher-name or fpage or lpage or issue or source and not(substring(normalize-space(source),string-length(normalize-space(source)),1)='?')">
                <xsl:text>, </xsl:text>
              </xsl:when>
              <xsl:when test="article-title">
                <xsl:text> Tech. Rep., </xsl:text>
              </xsl:when>
              <xsl:when test="person-group and not(source)">
                <xsl:text>, Tech. Rep., </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text> Tech. Rep., </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="comment"/>
            <xsl:if test="$ConversionType='0'">
              <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="person-group[@person-group-type='author']/etal and not(year) and not(month) and not(publisher-loc) and not(publisher-name) and not(fpage) and not(lpage) and not(issue) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="contains(normalize-space(person-group[@person-group-type='author']/name[position()=last()]/suffix/text()),'.') and not(year) and not(month) and not(publisher-loc) and not(publisher-name) and not(fpage) and not(lpage) and not(issue) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="contains(normalize-space(person-group[@person-group-type='author']/name[position()=last()]/surname/text()),'.') and not(person-group[@person-group-type='editor']) and not(year) and not (month) and not(edition) and not(publisher-loc) and not(publisher-name) and not(fpage) and not(lpage) and not(chapter) and not(issue) and not(series) and not(volume) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:when test="person-group[@person-group-type='editor'] and not(year) and not(month) and not(publisher-loc) and not(publisher-name) and not(fpage) and not(lpage) and not(source) and not(article-title)">
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="article-title and not(article-title/following-sibling::*)">
                  </xsl:when>
                  <xsl:when test="person-group and not(person-group/following-sibling::*)">
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>.</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$ConversionType='0'">
                  <xsl:apply-templates select="pub-id[@pub-id-type='other']"/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">This type of reference is not supported, please contact IT Department</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="deff">
    <xsl:param name="fpage"/>
    <xsl:param name="lpage"/>
    <xsl:param name="ConversionType"/>
    <xsl:variable name="fpage_num">
      <xsl:choose>
        <xsl:when test="contains(normalize-space($fpage/text()),'pages')">
          <xsl:value-of select="normalize-space(substring-before(normalize-space($fpage/text()),'pages'))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$fpage"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="lpage_num">
      <xsl:choose>
        <xsl:when test="contains(normalize-space($lpage/text()),'pages')">
          <xsl:value-of select="normalize-space(substring-before(normalize-space($lpage/text()),'pages'))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$lpage"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$fpage"/>
    <xsl:if test="$lpage!=''">
      <xsl:choose>
        <xsl:when test="not(number($fpage)) or not(number($lpage))">
          <xsl:if test="$ConversionType='0'">
            <xsl:text>--</xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='1'">
            <xsl:text>&#45;</xsl:text>
          </xsl:if>
        </xsl:when>
        <xsl:when test="($lpage_num - $fpage_num) &gt; 1">
          <xsl:if test="$ConversionType='0'">
            <xsl:text>--</xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='1'">
            <xsl:text>&#8211;</xsl:text>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="$ConversionType='0'">
            <xsl:text>-</xsl:text>
          </xsl:if>
          <xsl:if test="$ConversionType='1'">
            <xsl:text>&#45;</xsl:text>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$lpage"/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="publisher-name | publisher-loc | source">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ext-link">
    <xsl:choose>
      <xsl:when test="$ConversionType='0'">
        <xsl:text>\href{</xsl:text>
        <xsl:value-of select="@xlink:href"/>
        <xsl:text>}{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="$ConversionType='1'">
        <a href="{@xlink:href}">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="italic">
    <xsl:if test="not(parent::source/parent::nlm-citation[@publication-type='gov'])">
      <xsl:choose>
        <xsl:when test="$ConversionType='0'">
          <xsl:text>\emph{</xsl:text>
          <xsl:apply-templates/>
          <xsl:text>}</xsl:text>
        </xsl:when>
        <xsl:when test="$ConversionType=1">
          <i>
            <xsl:apply-templates/>
          </i>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="parent::source/parent::nlm-citation[@publication-type='gov']">
      <xsl:value-of select="."/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="conf-name">
    <xsl:choose>
      <xsl:when test="$ConversionType='0'">
        <xsl:text>\emph{</xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="$ConversionType='1'">
        <i>
          <xsl:value-of select="."/>
        </i>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="pub-id[@pub-id-type='other']">
    <xsl:if test="starts-with(.,'M')">
      <xsl:text>\MR{</xsl:text>
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:text>}{</xsl:text>
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:if test="starts-with(normalize-space(.),'Z')">
      <xsl:text>\Zbl{</xsl:text>
      <xsl:value-of select="substring(normalize-space(.),4)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="fpage | chapter | conf-date | conf-loc | edition | volume | month | issue | year | lpage | name | suffix | surname | given-names">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>
  <xsl:template match="comment">
    <xsl:if test="contains(substring(normalize-space(.),string-length(normalize-space(.)),1),'.')">
      <xsl:apply-templates/>
    </xsl:if>
    <xsl:if test="not(contains(substring(normalize-space(.),string-length(normalize-space(.)),1),'.'))">
      <xsl:apply-templates/>
      <xsl:if test="not(substring(normalize-space(.),string-length(normalize-space(.)),1)='?')">
        <xsl:text>.</xsl:text>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:template match="bold">
    <xsl:choose>
      <xsl:when test="$ConversionType='0'">
        <xsl:text>\textbf{</xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="$ConversionType='1'">
        <b>
          <xsl:value-of select="normalize-space(.)"/>
        </b>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="series">
    <xsl:if test="$ConversionType='1'">
      <xsl:apply-templates/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="person-group">
    <xsl:variable name="namesCount" select="count(child::name)"/>
    <xsl:choose>
      <xsl:when test="$namesCount>6">
        <xsl:if test="name[1]/given-names">
          <xsl:apply-templates select="name[1]/given-names"/>
        </xsl:if>
        <xsl:if test="name[1]/surname">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="name[1]/surname"/>
        </xsl:if>
        <xsl:if test="name[1]/suffix">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="name[1]/suffix"/>
        </xsl:if>
        <xsl:text>, </xsl:text>
        <xsl:if test="name[2]/given-names">
          <xsl:apply-templates select="name[2]/given-names"/>
        </xsl:if>
        <xsl:if test="name[2]/surname">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="name[2]/surname"/>
        </xsl:if>
        <xsl:if test="name[2]/suffix">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="name[2]/suffix"/>
        </xsl:if>
        <xsl:text>, </xsl:text>
        <xsl:if test="name[3]/given-names">
          <xsl:apply-templates select="name[3]/given-names"/>
        </xsl:if>
        <xsl:if test="name[3]/surname">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="name[3]/surname"/>
        </xsl:if>
        <xsl:if test="name[3]/suffix">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="name[3]/suffix"/>
        </xsl:if>
        <xsl:text> et al.</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="name">
          <xsl:if test="given-names">
            <xsl:apply-templates select="given-names"/>
          </xsl:if>
          <xsl:if test="surname">
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="surname"/>
          </xsl:if>
          <xsl:if test="suffix">
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="suffix"/>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="position()=last()-1 and $namesCount>1">
              <xsl:choose>
                <xsl:when test="$namesCount = 2">
                  <xsl:choose>
                    <xsl:when test="parent::person-group/etal">
                      <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text> and </xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="parent::person-group/etal">
                      <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>, and </xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="position()=last()">
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>, </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="etal">
      <xsl:text> et al.</xsl:text>
    </xsl:if>
    <xsl:if test="@person-group-type='editor'">
      <xsl:choose>
        <xsl:when test="count(child::name)>1">
          <xsl:text>, Eds.</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>, Ed.</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <xsl:template name="GetLanguage">
    <xsl:param name="LanguagePrefix"/>
    <xsl:choose>
      <xsl:when test="$LanguagePrefix = 'hi'">Hindi</xsl:when>
      <xsl:when test="$LanguagePrefix = 'tk'">Turkmen</xsl:when>
      <xsl:when test="$LanguagePrefix = 'ar'">Arabic</xsl:when>
      <xsl:when test="$LanguagePrefix = 'fa'">Persian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'uk'">Ukrainian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'bg'">Bulgarian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'ca'">Catalan</xsl:when>
      <xsl:when test="$LanguagePrefix = 'cs'">Czech</xsl:when>
      <xsl:when test="$LanguagePrefix = 'da'">Danish</xsl:when>
      <xsl:when test="$LanguagePrefix = 'de'">German</xsl:when>
      <xsl:when test="$LanguagePrefix = 'el'">Greek</xsl:when>
      <xsl:when test="$LanguagePrefix = 'en'">English</xsl:when>
      <xsl:when test="$LanguagePrefix = 'es'">Spanish</xsl:when>
      <xsl:when test="$LanguagePrefix = 'et'">Estonian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'eu'">Basque</xsl:when>
      <xsl:when test="$LanguagePrefix = 'fi'">Finnish</xsl:when>
      <xsl:when test="$LanguagePrefix = 'fr'">French</xsl:when>
      <xsl:when test="$LanguagePrefix = 'he'">Hebrew</xsl:when>
      <xsl:when test="$LanguagePrefix = 'hr'">Croatian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'hu'">Hungarian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'jp'">Japanese</xsl:when>
      <xsl:when test="$LanguagePrefix = 'lt'">Lithuanian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'lv'">Latvian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'is'">Icelandic</xsl:when>
      <xsl:when test="$LanguagePrefix = 'mt'">Maltese</xsl:when>
      <xsl:when test="$LanguagePrefix = 'nl'">Dutch</xsl:when>
      <xsl:when test="$LanguagePrefix = 'no'">Norwegian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'pl'">Polish</xsl:when>
      <xsl:when test="$LanguagePrefix = 'pt'">Portuguese</xsl:when>
      <xsl:when test="$LanguagePrefix = 'ro'">Romanian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'ru'">Russian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'sk'">Slovak</xsl:when>
      <xsl:when test="$LanguagePrefix = 'sl'">Slovenian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'it'">Italian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'sv'">Swedish</xsl:when>
      <xsl:when test="$LanguagePrefix = 'tr'">Turkish</xsl:when>
      <xsl:when test="$LanguagePrefix = 'zh'">Chinese</xsl:when>
      <xsl:when test="$LanguagePrefix = 'ko'">Korean</xsl:when>
      <xsl:when test="$LanguagePrefix = 'sh'">Serbo-Croatian</xsl:when>
      <xsl:when test="$LanguagePrefix = 'fa'">Persian</xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
