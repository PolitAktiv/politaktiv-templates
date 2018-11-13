<#--
Quiz-Darstellung und Funktionalität via JavaScript
Version: PA Quiz TMP 0.9.2
Letzte Änderung: Liferay 7 & Freemarker Portierung
-->

<#-- FIXME: das wird nicht funktionieren, wenn man ein Quiz 2x auf einer Seite hat -->
<#-- Problem: Es ist irgendwie unmöglich, eine Portlet-ID zu kriegen. -->
<#-- <#assign articleID = reserved-article-id.getData() /> -->
<#assign articleID = .vars['reserved-article-id'].data/>
<#assign instanceID = "quiz" + articleID />

<#-- Einstellungen: -->
<#-- CSS Klassen für Feedback-Icons: -->
<#assign iconCorrect = "icon-ok PA_Quiz_IconColor_Correct" />
<#assign iconWrong = "icon-remove PA_Quiz_IconColor_Wrong" />
<#assign iconEmpty = "icon-check-empty PA_Quiz_IconColor_Empty" />
<#assign iconMissing = "icon-arrow-right PA_Quiz_IconColor_Missing" />

<#-- Rückmeldung zusätzlich mit diesen CSS-Klassen darstellen: -->
<#assign rueckmeldungClass = "alert alert-info" />

<style>

i.PA_Quiz_IconColor_Empty {
  
  color: white;
  
}
i.PA_Quiz_IconColor_Correct {
  color: green;
  
}
i.PA_Quiz_IconColor_Wrong {
  color: red;
}
i.PA_Quiz_IconColor_Missing {
  color: red;
}



form.PA_Quiz_Formular label  {
  font-size:100%;
}

form.PA_Quiz_Formular input  {
  font-size:100%;
}

input.PA_Quiz_FormularElement {
  <#-- display:inline-block; -->
  display:block;
  float:left;
  margin-right:.5em !important;
}

span.PA_Quiz_Formular_Antwort {
  display:block;
}

span.PA_Quiz_Formular_Icon {
  display:block;
  width:3em;
  text-align:center;
  float:left;
}

</style>

<script language="JavaScript" type="text/javascript">

<#-- Datensammlung vorbereiten für Auswertung (wird bei Iteration über Fragen und Antworten gefüllt) -->
var AntwortenElementID_korrekt = new Array();
AntwortenElementID_korrekt['auswahlKorrekt'] = new Object();
AntwortenElementID_korrekt['checkerID']= new Object();
AntwortenElementID_korrekt['frageID']= new Object();
var FragenFehlerCounter = new Array();
var MeldungenMinKorrekt = new Array();

function auswerten(auswertenID,auswertungID) {

 
  <#-- Über alle Antort-Elemente loopen -->
  for ( var curElementID in AntwortenElementID_korrekt['auswahlKorrekt'] ) {
  
    <#-- alert('Element ID:' + curElementID); -->
  
    var auswahlKorrekt = AntwortenElementID_korrekt['auswahlKorrekt'][curElementID];
    var checkerID = AntwortenElementID_korrekt['checkerID'][curElementID];
    var frageID = AntwortenElementID_korrekt['frageID'][curElementID];
    
    var formularElement = document.getElementById(curElementID);
    
    <#-- Formular-Element ausschalten, benutzer kann nichts mehr ändern -->
    formularElement.disabled = true;
    
    <#-- Bestimmen, ob die Antwort richtig angekreuzt wurde -->
    var antwortRichtig = (formularElement.checked == auswahlKorrekt);

    updateChecker(checkerID, antwortRichtig, formularElement.checked );
    
    <#-- Fehleranzahl für die Frage aufsummieren -->
    if ( !antwortRichtig ) {
      FragenFehlerCounter[frageID]++;
    }
    
  
  } <#-- Ende Loop über alle Antworten -->
  
  <#-- Über Fragen loopen und auf jede Frage reagieren -->
  var fehler = 0;
  var anzahlFragen = 0;
  for ( var curFrageID in FragenFehlerCounter ) {
    anzahlFragen++;
    if (FragenFehlerCounter[curFrageID] > 0 ) {
      fehler++;
    }
  }
  var anzahlFragenKorrekt = anzahlFragen - fehler;
  
  <#-- window.alert("Debug:\n\nAnzahl falsch beantworter Fragen: " + fehler + -->
  <#--  "\nAnzahl korrekt beantworter Fragen: " + anzahlFragenKorrekt ); -->
  
  <#-- Auswerten-Button etc. verstecken, Auswertungsfeld generell anschalten -->
  auswertenToggleDisplay(auswertenID,auswertungID);
  
  <#-- Ergebnis anzeigen in Abhängigkeit von der anzahl korrekt beantworteter Fragen -->
  rueckmeldungAnzeigen(anzahlFragenKorrekt);

}

<#-- Alle Rückmeldungen abklappern und die anzeigen, deren Mindest-Zahl korrekt beantworteter Fragen zutrifft -->
function rueckmeldungAnzeigen(anzahlFragenKorrekt) {

  var trefferElementID = "";

  <#-- Alle Rückmeldungen durchgehen und die mit der höchsten passenden Mindest-Antwort finden -->
  <#-- (Highest-Watermark-Algorithmus) -->
  for (var meldungElementID in MeldungenMinKorrekt) {
    var minKorrekt = MeldungenMinKorrekt[meldungElementID];
    if (anzahlFragenKorrekt >= minKorrekt) {
      trefferElementID = meldungElementID;
    }
  }

  <#-- window.alert(trefferElementID); -->
  
  
  <#-- anzeige für dieses Element aktivieren -->
  var meldungDIV = document.getElementById(trefferElementID);
  meldungDIV.style.display = "block";


}


<#-- Display umschalten generell: auswertungsbutton raus, Auswertungsanzeige rein -->
function auswertenToggleDisplay(auswertenID,auswertungID) {

  var auswertenDIV = document.getElementById(auswertenID);
  var auswertungDIV = document.getElementById(auswertungID);

  auswertenDIV.style.display = "none";
  auswertungDIV.style.display = "block";

}



<#-- Checker-Anzeige updaten -->
function updateChecker(checkerID, korrekt, angekreuzt) {

  var checkerI = document.getElementById(checkerID);
  
  if ( korrekt && angekreuzt ) {
      checkerI.className = '${iconCorrect}';
  }
  
  if ( !korrekt && angekreuzt ) {
      checkerI.className = '${iconWrong}';
  }

  if ( ! korrekt && ! angekreuzt ) {
    checkerI.className = '${iconMissing}';
  }
  

}


function antwortRegistrieren(elementID, checkerID, frageID, auswahlKorrekt) {
  
  AntwortenElementID_korrekt['auswahlKorrekt'][elementID] = auswahlKorrekt;
  AntwortenElementID_korrekt['checkerID'][elementID] = checkerID;
  AntwortenElementID_korrekt['frageID'][elementID] = frageID;
  
  FragenFehlerCounter[frageID] = 0;
  
  <#-- Sicherheitshalber elemente anschalten und resetten, wegen Reload-Problemen -->
  var formularElement = document.getElementById(elementID);
  formularElement.disabled = false;
  formularElement.checked = false;
  
}

function meldungRegistrieren(elementID, anzahlMinKorrekt) {

  MeldungenMinKorrekt[elementID] = anzahlMinKorrekt;

}
  
</script>




<div class="PA_Quiz_Erklaerung">
    ${Erklaerung.getData()}
</div>

<div class="PA_Quiz_Fragen_Alle">
<#-- Schleife über Fragen -->
<#assign fragenCounter = 0 />
<#if (Frage.getSiblings()?has_content) >
	<#list Frage.getSiblings() as cur_Frage >
        <#assign frageID  = instanceID + "_" + fragenCounter />

	    <div class="PA_Quiz_Frage_Komplett">
	    
	    <#-- Frage anzeigen -->
	    <div class="PA_Quiz_Frage_Text">
	        ${cur_Frage.getData()}
	    </div>
	    
	        <div class="PA_Quiz_Antworten_Alle">
	        <#-- Schleife über Antworten -->
	        <#if (cur_Frage.Antwort.getSiblings()?has_content) >
	            <#-- Erste Schleife: Anzahl korrekte einfangen für Single- vs Multiple-Choice -->
	            <#assign anzahlKorrekt = 0 />
		    <#list cur_Frage.Antwort.getSiblings() as cur_Antwort >
	                    <#if (getterUtil.getBoolean(cur_Antwort.AntwortRichtig.getData())) >
	                        <#assign anzahlKorrekt = anzahlKorrekt + 1 />
	                    </#if>    
	            </#list>
	            <#-- Zweite Schleife: In Abhängigkeit von Single-/Multiple-Choice Formular designen -->
	            <#-- Wenn nur eine Antwort richtig: Radioboxen, AUSSER es ist angegeben, dass mehrere richtig sein können -->
	            <#-- $getterUtil.getBoolean($cur_Frage.EineAntwortRichtig) -->
                <#if ( anzahlKorrekt  == 1 &&  getterUtil.getBoolean(cur_Frage.EineAntwortRichtig.getData())  ) >
                    <#assign selectType = "radio" />
                <#else>
                    <#assign selectType = "checkbox" />
                </#if>
	            
	            <form class="PA_Quiz_Formular">
	                <fieldset>
	                <#assign antwortCounter = 0 />
	                <#list cur_Frage.Antwort.getSiblings() as cur_Antwort >
			    <#assign antwortIstRichtig = getterUtil.getBoolean(cur_Antwort.AntwortRichtig.getData()) />
	                    <label><span class="PA_Quiz_Formular_Icon"><i class="${iconEmpty}" id="${frageID}_checker_${antwortCounter}"></i></span><input type="${selectType}" id="${frageID}_antwort_${antwortCounter}" name="${frageID}" class="PA_Quiz_FormularElement" /><span class="PA_Quiz_Formular_Antwort">${htmlUtil.escape(cur_Antwort.getData())}</span></label>
	                    <#-- Element für die Auswertung in JavaScript-Daten registrieren: -->
	                    <script language="JavaScript" type="text/javascript"><!--
			      antwortRegistrieren('${frageID}_antwort_${antwortCounter}', '${frageID}_checker_${antwortCounter}',  '${frageID}', ${antwortIstRichtig?c});
	                    //-->
	                    </script>
	                <#assign antwortCounter = antwortCounter + 1 />
			</#list> <#-- Ende Loop über Antworten -->
    	            </fieldset>
	            </form>
	    
    	    </#if>
    	    </div>
	    </div>
	<#assign fragenCounter = fragenCounter + 1 />   
	</#list> <#-- Ende Loop über Fragen -->
	
</#if>
</div>

<#assign auswertenID  = instanceID + "_auswerten" />
<#assign auswertungID  = instanceID + "_auswertung" />

<div class="PA_Quiz_AuswertenButton" id="${auswertenID}" style="display:block;">
<form>
  <button  class="btn  btn-primary" type="button" onclick="auswerten('${auswertenID}', '${auswertungID}' );">Meine Antworten jetzt auswerten</button>
</form>  
</div>



<div class="PA_Quiz_Auswertung ${rueckmeldungClass}" id="${auswertungID}" style="display:none;">
  <div class="PA_Quiz_Auswertung_GenerelleMeldung">
    ${RueckmeldungGenerell.getData()}
  </div>
  <div class="PA_Quiz_Auswertung_EinzelneMeldungen">
      <#assign meldungCounter = 0 />
      <#assign nullPunkteMeldungExistiert = false />
      <#list RueckmeldungGenerell.RueckmeldungFuerPunkte.getSiblings() as cur_Rueckmeldung >
	<#assign meldungID  = instanceID + "_meldung_" + meldungCounter />
	<#assign minAnzahlKorrekt = cur_Rueckmeldung.AnzahlRichtige.getData() />
	<#if ( minAnzahlKorrekt?number == 0 ) >
	   <#assign nullPunkteMeldungExistiert = true />
	</#if>
	<div class="PA_Quiz_Auswertung_EinzelMeldung" id="${meldungID}" style="display:none;">
	  ${cur_Rueckmeldung.getData()}
	</div>
        <script language="JavaScript" type="text/javascript">
	  meldungRegistrieren('${meldungID}', ${minAnzahlKorrekt});
        </script>
	
      <#assign meldungCounter = meldungCounter + 1 /> 	
      </#list> <#-- Ende Loop über Rückmeldungen -->
  </div>

</div>

<#-- Los geht's bei 0 richtigen Fragen! -->
<#if ( !nullPunkteMeldungExistiert )>
    <span class="alert alert-error">Fehler: Es gibt keine Rückmeldung für 0 richtig beantworte Fragen!</span>
</#if>



<#-- ${RueckmeldungGenerell.getData()} -->
