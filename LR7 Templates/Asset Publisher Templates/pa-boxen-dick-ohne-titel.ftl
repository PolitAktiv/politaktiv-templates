<#--
This template changes the basic view and functionality
of the asset publisher.

It puts all content in 2px border boxes.
This version will have no titles!

Latest change: Marcel Eckert, Nov 2018, Documentation
-->

<style>
.assetBoxenContainer {
	border-style: solid;
    border-width: 2px;
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
		
			
		
		<div>
			<@liferay_ui["asset-display"]
                        assetEntry=curEntry
                        assetRenderer=curEntry.getAssetRenderer()
                        showExtraInfo=false />
		</div>

	</div>
	</#list>
</#if>
