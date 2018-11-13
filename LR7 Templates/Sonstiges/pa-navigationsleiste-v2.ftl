<style>
.navItemHighlight {
    background-color: #cce0ff !important;
}

#menu ul {
  margin: 0;
  padding: 0;
}

#menu .main-menu {
  display: block;
}

#menu .sub-menu,
#menu li {
    display: block;
}

#tm:checked + .main-menu {
  display: block;
}

#menu input[type="checkbox"], 
#menu ul span.drop-icon {
  display: none;
}

#menu li, 
#toggle-menu, 
#menu .sub-menu {
  border-style: solid;
  border-color: rgba(0, 0, 0, .1);
}

#menu li, 
#toggle-menu {
  border-width: 0 0 2px;
}

#menu .sub-menu {
  background-color: white;
  border-top-width: 2px;
  border-left-width: 2px;
  margin-left: 20px;
}

#menu .sub-menu li:last-child {
  border-width: 0;
}

#menu li, 
#toggle-menu, 
#menu a {
  position: relative;
  display: block;
  color: black;
  text-shadow: 1px 1px 0 rgba(0, 0, 0, .125);
}

#menu, 
#toggle-menu {
  background-color: white;
}

#toggle-menu, 
#menu a {
  padding: 1em 1.5em;
}

#menu a {
  transition: all .125s ease-in-out;
  -webkit-transition: all .125s ease-in-out;
}

#menu li:hover {
  background-color: #cce0ff;
  color: black;
}

#menu .sub-menu {
  display: block;
}

#menu input[type="checkbox"]:checked + .sub-menu {
  display: block;
}

#menu .sub-menu li:hover {
  color: #cce0ff;
}

#toggle-menu .drop-icon, 
#menu li label.drop-icon {
  position: absolute;
  right: 1.5em;
  top: 1.25em;
}

#menu label.drop-icon, #toggle-menu span.drop-icon {
  border-radius: 50%;
  width: 1em;
  height: 1em;
  text-align: center;
  background-color: rgba(0, 0, 0, .125);
  text-shadow: 0 0 0 transparent;
  color: rgba(255, 255, 255, .75);
}

#menu .drop-icon {
  line-height: 1;
}


@media only screen and (max-width: 64em) and (min-width: 52.01em) {
  #menu li {
    width: 33.333%;
  }

  #menu .sub-menu li {
    width: auto;
  }
  
}

@media only screen and (min-width: 52em) {
  #menu .main-menu {
    display: block;
  }

  #toggle-menu, 
  #menu label.drop-icon {
    display: none;
  }

  #menu ul span.drop-icon {
    display: inline-block;
  }

  #menu li {
    float: left;
    border-width: 0 1px 0 0;
  }

  #menu .sub-menu li {
    float: none;
  }

  #menu .sub-menu {
    border-width: 0;
    margin: 0;
    position: absolute;
    top: 100%;
    left: 0;
    
    z-index: 10;
  }

  #menu .sub-menu, 
  #menu input[type="checkbox"]:checked + .sub-menu {
    display: none;
  }

  #menu .sub-menu li {
    border-width: 0 0 0;
  }

  #menu .sub-menu .sub-menu {
    top: 0;
    left: 100%;
  }

  #menu li:hover > input[type="checkbox"] + .sub-menu {
    display: block;
  }
  
}

@media only screen and (max-width: 768px) {
.stuck {
    position: relative !important;
}

}
</style>

<#if !entries?has_content>
	<#if preview>
		<div class="alert alert-info">
			<@liferay.language key="there-are-no-pages-to-display-for-the-current-page-level" />
		</div>
	</#if>
<#else>
	<#assign
		portletDisplay = themeDisplay.getPortletDisplay()

		navbarId = "navbar_" + portletDisplay.getId()
		
		sm_index = 0
		
		currentPageName = themeDisplay.getLayout().getName(locale)
	/>

	<div id="menu">
		<ul aria-label=<@liferay.language key="site-pages" />" class="main-menu clearfix">
			<h1 class="hide-accessible"><@liferay.language key="navigation" /></h1>

			<#assign navItems = entries />

			<#list navItems as navItem>
				<#assign showChildren = (displayDepth != 1) && navItem.hasChildren() />

				<#if navItem.isBrowsable() || showChildren>
					<#assign
						nav_item_attr_has_popup = ""
						nav_item_attr_selected = ""
						nav_item_caret = ""
						nav_item_css_class = "lfr-nav-item"
						nav_item_href_link = ""
						nav_item_link_css_class = ""
					/>

					<#if showChildren>
					    <#assign sm_index = sm_index + 1 />
					    <#assign sm_id = "sm" + sm_index />
						<#assign nav_item_attr_has_popup = "aria-haspopup='true'" />
						<#assign nav_item_caret = '<span class="drop-icon">▾</span>
                        <label title="Toggle Drop-down" class="drop-icon" for="${sm_id}">▾</label>' />
						<#assign
							nav_item_css_class = "${nav_item_css_class} dropdown"
							nav_item_link_css_class = "dropdown-toggle"
						/>
					</#if>

					<#if navItem.isBrowsable()>
						<#assign nav_item_href_link = "href='${navItem.getURL()}'" />
					</#if>

					<#if navItem.isSelected()>
						<#assign
							nav_item_attr_selected = "aria-selected='true'"
							nav_item_css_class = "${nav_item_css_class} selected active"
						/>
					</#if>
					
					<#if navItem.getName() == currentPageName>
					    <#assign
							nav_item_attr_selected = "aria-selected='true'"
							nav_item_css_class = "${nav_item_css_class} navItemHighlight"
						/>
					</#if>

					<li class="${nav_item_css_class}">
						<a ${nav_item_href_link} ${navItem.getTarget()}>
							<span><@liferay_theme["layout-icon"] layout=navItem.getLayout() /> ${navItem.getName()} ${nav_item_caret}
						</a>

						<#if showChildren>
						    <input type="checkbox" id="${sm_id}">
							<ul class="sub-menu">
								<#list navItem.getChildren() as childNavigationItem>
									<#assign showChildren2 = childNavigationItem.hasChildren() />
									<#assign
										nav_child_attr_selected = ""
										nav_child_css_class = ""
										nav_child_href_link = ""
										nav_item_caret = ""
										nav_child_link_css_class = ""
										nav_child_attr_has_popup = ""
									/>
									
									<#if showChildren2>
									    <#assign sm_index = sm_index + 1 />
					                    <#assign sm_id = "sm" + sm_index />
										<#assign nav_child_attr_has_popup = "aria-haspopup='true'" />
										<#assign nav_child_css_class = "${nav_child_css_class} dropdown-submenu"/>
										<#assign nav_child_link_css_class = "dropdown-toggle"/>										                        <#assign nav_item_caret = '<span class="drop-icon">▾</span>
                                            <label title="Toggle Drop-down" class="drop-icon" for="${sm_id}">▾</label>' />
									</#if>
									
									<#if childNavigationItem.isBrowsable()>
										<#assign nav_child_href_link = "href='${childNavigationItem.getURL()}'" />
									</#if>									
									
									<#if childNavigationItem.isSelected()>
										<#assign
											nav_child_attr_selected = "aria-selected='true'"
											nav_child_css_class = "${nav_child_css_class} active selected"
										/>
									</#if>
									
									<#if childNavigationItem.getName() == currentPageName>
					                    <#assign
							                nav_child_attr_selected = "aria-selected='true'"
							                nav_child_css_class = "${nav_child_css_class} navItemHighlight"
						                />
					                </#if>

									<li class="${nav_child_css_class}">
										<a ${nav_child_href_link}>${childNavigationItem.getName()} ${nav_item_caret}</a>
										
										<#if showChildren2>
										    <input type="checkbox" id="${sm_id}">
											<ul class="sub-menu">
												<#list childNavigationItem.getChildren() as childNavigationItem2>
													<#assign showChildren3 = childNavigationItem2.hasChildren() />
													<#assign
														nav_child_attr_selected2 = ""
														nav_child_css_class2 = ""
														nav_child_href_link2 = ""
														nav_item_caret = ""
														nav_child_link_css_class2 = ""
														nav_child_attr_has_popup2 = ""
													/>
													
													<#if showChildren3>
													    <#assign sm_index = sm_index + 1 />
					                                    <#assign sm_id = "sm" + sm_index />
														<#assign nav_child_attr_has_popup2 = "aria-haspopup='true'" />
														<#assign nav_child_css_class2 = "${nav_child_css_class2} dropdown-submenu"/>
														<#assign nav_child_link_css_class2 = "dropdown-toggle"/>										                    <#assign nav_item_caret = '<span class="drop-icon">▾</span>
                                                            <label title="Toggle Drop-down" class="drop-icon" for="${sm_id}">▾</label>' />
													</#if>
													
													<#if childNavigationItem2.isBrowsable()>
														<#assign nav_child_href_link2 = "href='${childNavigationItem2.getURL()}'" />
													</#if>		
													
													<#if childNavigationItem2.isSelected()>
														<#assign
															nav_child_attr_selected2= "aria-selected='true'"
															nav_child_css_class2 = "${nav_child_css_class2} active selected"
														/>
													</#if>
													
													<#if childNavigationItem2.getName() == currentPageName>
					                                    <#assign
							                                nav_child_attr_selected2 = "aria-selected='true'"
							                                nav_child_css_class2 = "${nav_child_css_class2} navItemHighlight"
						                                />
					                                </#if>

													<li class="${nav_child_css_class2}">
														<a ${nav_child_href_link2}>${childNavigationItem2.getName()} ${nav_item_caret}</a>
														
														<#if showChildren3>
														    <input type="checkbox" id="${sm_id}">
															<ul class="sub-menu">
																<#list childNavigationItem2.getChildren() as childNavigationItem3>
																	<#assign
																		nav_child_attr_selected3 = ""
																		nav_child_css_class3 = ""
																	/>

																	<#if childNavigationItem3.isSelected()>
																		<#assign
																			nav_child_attr_selected3 = "aria-selected='true'"
																			nav_child_css_class3 = "active selected"
																		/>
																	</#if>
																	
																	<#if childNavigationItem3.getName() == currentPageName>
					                                                    <#assign
							                                                nav_child_attr_selected3 = "aria-selected='true'"
							                                                nav_child_css_class3 = "${nav_child_css_class3} navItemHighlight"
						                                                />
					                                                </#if>

																	<li class="${nav_child_css_class3}">
																		<a href="${childNavigationItem3.getURL()}">${childNavigationItem3.getName()}</a>
																	</li>
																</#list>
															</ul>
														</#if>
													</li>
												</#list>
											</ul>
										</#if>
									</li>
								</#list>
							</ul>
							
						</#if>
						
					</li>
				</#if>
			</#list>
		</ul>
	</div>
</#if>
