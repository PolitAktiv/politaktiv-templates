<style>
.asset-title {
    text-align: center;
}
.blogEntry {
  	border-color: #e3e6e8;
	border-style: solid;
	border-width: 1px 1px 1px 1px;
    margin: 10px;
    max-width: 30%;
    padding: 5px;
}
.blogImage {
    max-width: 100%;
}
.blogFlexContainer {
  align-content: flex-start;
      -ms-box-orient: horizontal;
  display: -webkit-box;
  display: -moz-box;
  display: -ms-flexbox;
  display: -moz-flex;
  display: -webkit-flex;
  display: flex;
    -webkit-flex-wrap: wrap;
  flex-wrap: wrap;
}
@media only screen and (max-width: 768px) {
    /* For mobile phones: */
    .blogEntry {
        max-width: 100% !important;
    }
}
</style>

<div class="blogFlexContainer">

<#if !entries?has_content>
	<#if !themeDisplay.isSignedIn()>
		${renderRequest.setAttribute("PORTLET_CONFIGURATOR_VISIBILITY", true)}
	</#if>

	<div class="alert alert-info">
		<@liferay_ui["message"] key="there-are-no-results" />
	</div>
</#if>

<#list entries as entry>
<div class="blogEntry">
	<#assign
		entry = entry

		assetRenderer = entry.getAssetRenderer()

		entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale))

		viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry)
	/>

	<#if !stringUtil.equals(assetLinkBehavior, "showFullContent")>
		<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry, true) />
	</#if>

	<div class="asset-abstract">
		<div class="asset-actions lfr-meta-actions">
			<@getPrintIcon />

			<@getFlagsIcon />

	<#--		<@getEditIcon /> -->
		</div>

		<h3 class="asset-title">
			<a href="${viewURL}">
				${entryTitle}
			</a>
		</h3>
		
			<#assign className = assetRenderer.getClassName() >
            <#if className == "com.liferay.blogs.kernel.model.BlogsEntry">
                <#assign blogsEntry = assetRenderer.getAssetObject() >
                <p><img class="blogImage" src=" ${blogsEntry.getSmallImageURL(themeDisplay)}"</p>
            </#if>

		<@getMetadataField fieldName="tags" />

		<@getMetadataField fieldName="create-date" />

		<@getMetadataField fieldName="view-count" />

		<div class="asset-content">
	<#--		<@getSocialBookmarks /> -->

			<div class="asset-summary">
				<@getMetadataField fieldName="author" />

				${htmlUtil.escape(assetRenderer.getSummary(renderRequest, renderResponse))}

			<p>	<a href="${viewURL}"><@liferay.language key="read-more" /><span class="hide-accessible"><@liferay.language key="about" />${entryTitle}</span> &raquo;</a></p>
			</div>

			<@getRatings />

			<@getRelatedAssets />

			<@getDiscussion />
		</div>
	</div>
	</div>
</#list>
</div>

<#macro getDiscussion>
	<#if getterUtil.getBoolean(enableComments) && assetRenderer.isCommentable()>
		<br />

		<#assign discussionURL = renderResponse.createActionURL() />

		${discussionURL.setParameter("javax.portlet.action", "invokeTaglibDiscussion")}

		<@liferay_ui["discussion"]
			className=entry.getClassName()
			classPK=entry.getClassPK()
			formAction=discussionURL?string
			formName="fm" + entry.getClassPK()
			ratingsEnabled=getterUtil.getBoolean(enableCommentRatings)
			redirect=currentURL
			userId=assetRenderer.getUserId()
		/>
	</#if>
</#macro>

<#macro getEditIcon>
	<#if assetRenderer.hasEditPermission(themeDisplay.getPermissionChecker())>
		<#assign redirectURL = renderResponse.createRenderURL() />

		${redirectURL.setParameter("mvcPath", "/add_asset_redirect.jsp")}
		${redirectURL.setWindowState("pop_up")}

		<#assign editPortletURL = assetRenderer.getURLEdit(renderRequest, renderResponse, windowStateFactory.getWindowState("pop_up"), redirectURL)!"" />

		<#if validator.isNotNull(editPortletURL)>
			<#assign title = languageUtil.format(locale, "edit-x", entryTitle, false) />

			<@liferay_ui["icon"]
				iconCssClass="icon-edit-sign"
				message=title
				url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "editAsset', title: '" + title + "', uri:'" + htmlUtil.escapeURL(editPortletURL.toString()) + "'});"
			/>
		</#if>
	</#if>
</#macro>

<#macro getFlagsIcon>
	<#if getterUtil.getBoolean(enableFlags)>
		<@liferay_flags["flags"]
			className=entry.getClassName()
			classPK=entry.getClassPK()
			contentTitle=entry.getTitle(locale)
			label=false
			reportedUserId=entry.getUserId()
		/>
	</#if>
</#macro>

<#macro getMetadataField
	fieldName
>
	<#if stringUtil.split(metadataFields)?seq_contains(fieldName)>
		<span class="metadata-entry metadata-${fieldName}">
			<#assign dateFormat = "dd MMM yyyy - HH:mm:ss" />

			<#if stringUtil.equals(fieldName, "author")>
				<@liferay.language key="by" /> ${portalUtil.getUserName(assetRenderer.getUserId(), assetRenderer.getUserName())}
			<#elseif stringUtil.equals(fieldName, "categories")>
				<@liferay_ui["asset-categories-summary"]
					className=entry.getClassName()
					classPK=entry.getClassPK()
					portletURL=renderResponse.createRenderURL()
				/>
			<#elseif stringUtil.equals(fieldName, "create-date")>
				${dateUtil.getDate(entry.getCreateDate(), dateFormat, locale)}
			<#elseif stringUtil.equals(fieldName, "expiration-date")>
				${dateUtil.getDate(entry.getExpirationDate(), dateFormat, locale)}
			<#elseif stringUtil.equals(fieldName, "modified-date")>
				${dateUtil.getDate(entry.getModifiedDate(), dateFormat, locale)}
			<#elseif stringUtil.equals(fieldName, "priority")>
				${entry.getPriority()}
			<#elseif stringUtil.equals(fieldName, "publish-date")>
				${dateUtil.getDate(entry.getPublishDate(), dateFormat, locale)}
			<#elseif stringUtil.equals(fieldName, "tags")>
				<@liferay_ui["asset-tags-summary"]
					className=entry.getClassName()
					classPK=entry.getClassPK()
					portletURL=renderResponse.createRenderURL()
				/>
			<#elseif stringUtil.equals(fieldName, "view-count")>
				${entry.getViewCount()} <@liferay.language key="views" />
			</#if>
		</span>
	</#if>
</#macro>

<#macro getPrintIcon>
	<#if getterUtil.getBoolean(enablePrint)>
		<#assign printURL = renderResponse.createRenderURL() />

		${printURL.setParameter("mvcPath", "/view_content.jsp")}
		${printURL.setParameter("assetEntryId", entry.getEntryId()?string)}
		${printURL.setParameter("viewMode", "print")}
		${printURL.setParameter("type", entry.getAssetRendererFactory().getType())}

		<#if (assetRenderer.getUrlTitle()??) && validator.isNotNull(assetRenderer.getUrlTitle())>
			<#if assetRenderer.getGroupId() != themeDisplay.getScopeGroupId()>
				${printURL.setParameter("groupId", assetRenderer.getGroupId()?string)}
			</#if>

			${printURL.setParameter("urlTitle", assetRenderer.getUrlTitle())}
		</#if>

		${printURL.setWindowState("pop_up")}

		<@liferay_ui["icon"]
			iconCssClass="icon-print"
			message="print"
			url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "printAsset', title: '" + languageUtil.format(locale, "print-x-x", ["hide-accessible", entryTitle], false) + "', uri: '" + htmlUtil.escapeURL(printURL.toString()) + "'});"
		/>
	</#if>
</#macro>

<#macro getRatings>
	<#if getterUtil.getBoolean(enableRatings) && assetRenderer.isRatable()>
		<div class="asset-ratings">
			<@liferay_ui["ratings"]
				className=entry.getClassName()
				classPK=entry.getClassPK()
			/>
		</div>
	</#if>
</#macro>

<#macro getRelatedAssets>
	<#if getterUtil.getBoolean(enableRelatedAssets)>
		<@liferay_ui["asset-links"]
			assetEntryId=entry.getEntryId()
			viewInContext=!stringUtil.equals(assetLinkBehavior, "showFullContent")
		/>
	</#if>
</#macro>

<#macro getSocialBookmarks>
	<#if getterUtil.getBoolean(enableSocialBookmarks)>
		<@liferay_ui["social-bookmarks"]
			displayStyle="${socialBookmarksDisplayStyle}"
			target="_blank"
			title=entry.getTitle(locale)
			url=viewURL
		/>
	</#if>
</#macro>
