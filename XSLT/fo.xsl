<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink">
<!-- Test 2 -->
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	<xsl:variable name="Ops" select="normalize-space(document('D:\programs\ProductionTools\TexConverter\FOP\foptemp.xml')/root/result)"/>
	<xsl:template match="front">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:mml="http://www.w3.org/1998/Math/MathML">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="two_column" page-height="800pt" page-width="600pt" margin-left="1in" margin-right="1in">
					<fo:region-body margin-top="1in" margin-bottom=".5in" column-count="2"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="two_column">
				<fo:flow flow-name="xsl-region-body">
					<xsl:apply-templates select="//contrib-group"/>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<!--<xsl:template match="contrib-group">
 <xsl:apply-templates select="./name"/>
 </xsl:template>-->
	<xsl:template match="contrib-group">
		<fo:block font-family="MinionPro-Bold" font-size="14pt" font-weight="bold" padding-bottom="2em" text-align="center" span="all">
      Author(s) Name(s)
    </fo:block>
		<fo:block font-family="MinionPro-Regular" font-size="11pt" text-align="justify" span="all">
			<!--font-style="italic"-->
      It is very important to confirm the author(s) last and first names in order to be displayed correctly
    </fo:block>
		<fo:block font-family="MinionPro-Regular" font-size="11pt" padding-bottom="1.5em" text-align="justify" span="all">
      on our website as well as in the indexing databases:
    </fo:block>
		<xsl:for-each select="./contrib[@contrib-type='author']/name">
			<fo:block font-family="MinionPro-Bold" font-size="11pt" font-weight="bold">
        Author <xsl:number value="position()"/>
			</fo:block>
			<fo:block font-family="MinionPro-Regular" font-size="11pt">
				<!--&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;-->Given Names: <xsl:value-of select="./given-names"/>
			</fo:block>
			<fo:block font-family="MinionPro-Regular" font-size="11pt">
				<!--&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;-->Last Name: <xsl:value-of select="./surname"/>
				<xsl:if test="string-length(./suffix)!=0">
					<xsl:text> </xsl:text>
					<xsl:value-of select="./suffix"/>
				</xsl:if>
			</fo:block>
			<fo:block font-family="MinionPro-Regular" font-size="11pt" padding-bottom=".85em">
				<fo:character character=" "/>
			</fo:block>
		</xsl:for-each>
		<xsl:choose>
			<xsl:when test="starts-with(../preceding-sibling::*[1]/journal-id,'RESEARCH')">
				<!--as per gad requrest empty paragaraph for authors-->
				<fo:block font-family="MinionPro-Regular" font-size="11pt" padding-bottom=".65em" padding-before="2em" text-align="justify" span="all"/>
			</xsl:when>
			<xsl:otherwise>
	<!--as per gad requrest commnet out 2-10-2018-->
<xsl:if test="$Ops='1'">
<xsl:if test="starts-with(../preceding-sibling::*[1]/journal-id,'AHEP')">
					<fo:block font-family="MinionPro-Regular" font-size="11pt" padding-bottom=".65em" padding-before="2em" text-align="justify" span="all">
        We strongly recommend that you deposit your article with arXiv, under one of the high energy physics categories;
        Experiment (hep-ex), Lattice (hep-lat), Phenomenology (hep-ph), or Theory (hep-th). You can log into their system at https://arxiv.org/user/login.
        The submission procedure is well explained at http://arxiv.org/help/, where you can also find the answers to frequently asked questions. 
        Once your manuscript is submitted there, please provide us with the arXiv ID.
      </fo:block>
</xsl:if>
</xsl:if>
		<fo:block font-family="MinionPro-Regular" font-size="11pt" padding-bottom=".65em" text-align="justify" span="all">
		It is very important for each author to have a linked ORCID (Open Researcher and Contributor ID) account on MTS. 
		ORCID aims to solve the name ambiguity problem in scholarly communications by creating a registry of persistent unique identifiers for individual researchers. 
    </fo:block>
				<fo:block font-family="MinionPro-Regular" font-size="11pt" text-align="justify" span="all">
		To register a linked ORCID account, please go to the Account Update page (http://mts.hindawi.com/update/) in our Manuscript Tracking System and after you have logged in click on the ORCID link at the top of the page. This link will take you to the ORCID website where you will be
		able to create an account for yourself. Once you have done so, your new ORCID will be saved in our Manuscript Tracking System automatically.
    </fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="file:///d:/Production Softwares/Tasks/PDF Cover/8346563.abs.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="fop" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
