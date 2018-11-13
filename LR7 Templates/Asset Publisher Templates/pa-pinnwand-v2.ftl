<#--
This template can be used to modify the look of a specific
application.

Pinnwand-Darstellung, zunächst als Mod-Kärtchen, später alles

Version: 2.1.3
Letzte Überarbeitung: Marcel Eckert, Juli 2018, LR7 Release
-->

<#--
Einstellungen
Positionierung und Drehung zufällig justieren für "organischere" Darstellung
0: nicht anwenden. Andere Werte: Stärke (0...100)
-->
<#assign humanize = 25 />

<#-- Header sind Links zu Einzelposts -->
<#assign headerLinks = true />

<#-- Zusammenfassung anzeigen? Andernfalls volle länge -->
<#assign showSummary = false />

<#-- Standard-Farbe der Kärtchen -->
<#assign defaultColor = 'gelb' />

<#-- Zweispaltigkeit aktivieren? -->
<#assign zweiSpaltig = false />

<#assign divStyle = "" />

<#assign pinStyle = "" />

<#-- Produktiv:
Benötigte externe Dateien -->
<#assign headingFontURL='/documents/20142/46326/RockSalt-OtN.ttf/20b1b63c-3aed-e7d7-154e-76fe0bd84ef4' />
<#assign corkBgURL='/documents/20142/46322/corkHeller.jpg/fcc6ab6b-5732-f044-1257-a01109d5e0c6?t=1524052265229' />
<#assign imagePin = '/documents/20142/46322/pin.png/6af8900b-55b5-d67d-f543-a3a7195f891f?t=1524052265488' />
<#assign borderImgURL = '/documents/20142/46322/rand.jpg/b11c7272-0558-ce4d-0b12-98472ae8ddd3?t=1524052265540' />

<#-- Hintergrundbilder für Kärtchen: -->
<#assign blau = '/documents/20142/46322/modkarte-blau.png/e30899e1-392a-c889-a02a-9cf5838aea30?t=1524052265266' />
<#assign gelb = '/documents/20142/46322/modkarte-gelb.png/ba41134f-eaaf-1c97-0525-39ee5b7ae15d?t=1524052265307' />
<#assign grün = '/documents/20142/46322/modkarte-gruen.png/f66e6f8a-4f0d-d626-af29-e1af0a5b6c01?t=1524052265353' />
<#assign pink = '/documents/20142/46322/modkarte-pink.png/bfed4465-8950-322a-2f21-2a95687b07bb?t=1524052265396' />
<#assign weiß = '/documents/20142/46322/modkarte-weiss.png/3ad53305-3a3a-bb92-9b30-5bf24432a9a9?t=1524052265445' />

<#-- Generische Icon-Klasse/Erweiterung für wichtige Formatierungen: -->
<#assign genericIconClass = "PaStyleIconExtension" />

<#-- Prefix für Farb-Kategorien -->
<#assign colorCatPrefix = "PaPinnwandKarte" />

<style>
 
<#-- font für Überschrift auf sticky-note -->
@font-face {
	font-family: Rock Salt;
	src: url("${headingFontURL}");	
}


 
div.PaPinnwandKork {
	/* überschreibt style.css */
	background-image: url('${corkBgURL}');
	
	/* Abstand nach letzer Karte */
	padding-bottom:15px;
	
	border: 5px solid transparent; 
	
	border-image: url('${borderImgURL}') 50 round;
	
	<#-- 
	Unklar, warum das nötig ist. Allerdings: In Webkit (Chrome/Safari) führt es dazu, dass
	Kärtchen in der rechten Spalte verschwinden
	overflow:hidden;
	-->
}

div.PaPinnwandKarte h3.PaPinnwandKarteHeader {
  font-family: Rock Salt, cursive;
}

div.PaPinnwandKarteOuter {
  padding-left:15px;
  padding-top:15px;
  padding-right:15px;
  padding-bottom:0px;
  
}

@media (min-width:849px){
  div.PaPinnwandKork2Spalten {
    <#-- Zweispaltiges Layout einschalten für Container -->
    -webkit-column-count: 2;
    -moz-column-count: 2;
    column-count: 2;
  }
  div.PaPinnwandKarteOuter2Spalten {
    <#-- Umbrechen von Karten im Spaltenlayout verbieten -->
    -webkit-column-break-inside: avoid;
    break-inside: avoid-column;
    page-break-inside: avoid; 
  }
}
@media (max-width:850px){
  div.PaPinnwandKork2Spalten {
    <#-- zu schmal - kein Spaltenlayout -->
  }
  div.PaPinnwandKarteOuter2Spalten {
    <#-- zu schmal - kein Spaltenlayout -->
  }
}




div.PaPinnwandKarte {
  min-height:12em;
  background-color:white;
  padding:20px;
  border-radius: 2px;
  margin: 1rem;
  position: relative;
  box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 10px 10px rgba(0,0,0,0.29);  
  
 
}

hr.paPinnwandKarteAnzeige {
  width:100%;
  
  padding:0px;
  margin-left:auto;
  margin-right:auto;
  margin-bottom:10px;
  margin-top:10px;
  
  border: 0; height: 1px; background: #333;
}


  


img.PaPinnwandPin {
    width:23px;
    height:auto;
    z-index:1000;
    position:absolute;
  left: 0;
    right: 0;
    top:8px;
    margin-left: auto;
    margin-right: auto;
    
}

h3.PaPinnwandKarteActionIcons {
  float:right;
}



i.${genericIconClass}:before {
  display:inline !important;
  padding-right:.25rem;
}

span.paPinnwandKarteMetadatenItem {
  padding-right:.4rem;

}


div.paPinnwandKarteMetadaten {
  text-align:right;
  
}

</style>


<#assign instanceID = themeDisplay.getPortletDisplay().getInstanceId() />

<#--
Workaround: Gibt es nur ein einziges Kärtchen, so wird einspaltiges Layout benutzt
(Sonst kommt es zu irren Darstellung mit Internet Explorer)
-->

<#--
<#if ( entries.size() == 1 ) >
  <#assign zweiSpaltig = false />
</#if>
-->

<#-- Zweispaltigkeit? -->
<#assign containerAddClass = "" />
<#assign outerAddClass = "" />
<#if (zweiSpaltig) >
  <#assign containerAddClass = " PaPinnwandKork2Spalten" />
  <#assign outerAddClass = " PaPinnwandKarteOuter2Spalten" />
</#if>

<#-- Pinnwand-Container -->
<div id="pinnwand_${instanceID}" class="PaPinnwandKork ${containerAddClass}">


<#if entries?has_content>
	<#list entries as curEntry>

	  <#-- Hintergrundfarbe dieses Kärtchens (falls nicht verfügbar: Default nehmen) -->

	    <#assign bgColorURL = gelb />

	
	  <#-- Und hier schlussendlich: Die Darstellung in HTML -->
	  <div class="PaPinnwandKarteOuter ${outerAddClass}" style="${divStyle}">
	    <div class="PaPinnwandKarte" style="background: url('${bgColorURL}');">
	      <img src="${imagePin}" class="PaPinnwandPin" alt="" style="${pinStyle}" />
	      
	      <div class="paPinnwandModkarteHeader">

		
	      </div>
	      <div class="paPinnwandModkarteContent">
         
         <@liferay_ui["asset-display"]
                        assetEntry=curEntry
                        assetRenderer=curEntry.getAssetRenderer()
                        showExtraInfo=false />
                        
	      </div>
	    
		  
	  </div>
	</div>
		  
    </#list>  
</#if>  <#-- if (!entries.isEmpty()) -->
</div> <#-- Ende Pinnwand-Dive -->
