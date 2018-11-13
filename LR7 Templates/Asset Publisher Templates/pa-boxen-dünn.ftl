<style>
.assetBoxenContainer {
	border-style: solid;
    border-width: 1px;
	border-color: #e3e6e8;
	padding: 5px;
	margin-bottom: 5px;
}

.titleContainer {
	text-align: center;
	<#-- background-color: #e3e6e8; -->
	margin-top: 0px !important;
}
</style>



<#if entries?has_content>
	<#list entries as curEntry>
	<#assign title = curEntry.getTitle(locale) />
	<#assign summary = curEntry.getSummary() />

	<div class="assetBoxenContainer">
		
			<h2 class="titleContainer">${title}</h2>
		
		<div>
			<@liferay_ui["asset-display"]
                        assetEntry=curEntry
                        assetRenderer=curEntry.getAssetRenderer()
                        showExtraInfo=false />
		</div>

	</div>
	</#list>
</#if>
