<#--
This template changes the basic view and functionality
of the asset publisher.

It divides all contents with a horizontal fading line

Latest change: Marcel Eckert, Nov 2018, Documentation
-->

<style>
hr.trennstrich {
border: 0; 
height: 2px;
background-image: linear-gradient(to right, rgba(150, 150, 150, 0), rgba(150, 150, 150, 0.75), rgba(150, 150, 150, 0)); 
}
</style>

<#if entries?has_content>
    <#list entries as curEntry>
        <@liferay_ui["asset-display"]
                        assetEntry=curEntry
                        assetRenderer=curEntry.getAssetRenderer()
                        showExtraInfo=false />
        <hr class="trennstrich">
      </#list>
</#if>
