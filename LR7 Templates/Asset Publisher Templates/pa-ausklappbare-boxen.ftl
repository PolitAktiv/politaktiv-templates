<style>
.einklapp-ausklapp-buttons-container {
	padding-top: 5px;
}

.tolles-knoepfle {
	background-color: #e3e6e8;
}

.einklapp-button {
	display: none;
}
.assetBoxenContainer {
	border-style: solid;
    border-width: 2px;
	border-color: #e3e6e8;
	padding: 5px;
	margin-bottom: 5px;
}

.langfassung {
	display: none;
}

.titleContainer {
	text-align: center;
	background-color: #e3e6e8;
	margin-top: 0px !important;
}
</style>



<#if entries?has_content>
	<#list entries as curEntry>
	<#assign title = curEntry.getTitle(locale) />
	<#assign summary = curEntry.getSummary() />

	<div class="assetBoxenContainer">
		
			<h2 class="titleContainer">${title}</h2>
		

		<div class="kurzfassung">
			${summary}
		</div>

		<div class="langfassung">
			<@liferay_ui["asset-display"]
                        assetEntry=curEntry
                        assetRenderer=curEntry.getAssetRenderer()
                        showExtraInfo=false />
		</div>

		<div class="einklapp-ausklapp-buttons-container">
			<button class="btn ausklapp-button tolles-knoepfle" onClick="ausklappen(this)">
				Mehr anzeigen
			</button>
			<button class="btn einklapp-button tolles-knoepfle" onClick="einklappen(this)">
				Weniger anzeigen
			</button>
		</div>

	</div>
	</#list>
</#if>

<script type="text/javascript">
function ausklappen(elem)
{
	var buttonBox = elem.parentNode;
	var outerBox = elem.parentNode.parentNode;

	var kurzfassung = outerBox.getElementsByClassName("kurzfassung")[0];
	kurzfassung.style.display = "none";

	var langfassung = outerBox.getElementsByClassName("langfassung")[0];
	langfassung.style.display = "block";

	var einklappButton = buttonBox.getElementsByClassName("einklapp-button")[0];
	einklappButton.style.display = "block";

	var ausklappButton = buttonBox.getElementsByClassName("ausklapp-button")[0];
	ausklappButton.style.display = "none";
}
function einklappen(elem)
{
    var buttonBox = elem.parentNode;
	var outerBox = elem.parentNode.parentNode;

	var kurzfassung = outerBox.getElementsByClassName("kurzfassung")[0];
	kurzfassung.style.display = "block";

	var langfassung = outerBox.getElementsByClassName("langfassung")[0];
	langfassung.style.display = "none";

	var einklappButton = buttonBox.getElementsByClassName("einklapp-button")[0];
	einklappButton.style.display = "none";

	var ausklappButton = buttonBox.getElementsByClassName("ausklapp-button")[0];
	ausklappButton.style.display = "block";
}
</script>
