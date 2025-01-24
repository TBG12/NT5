<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- This file contains the security configuration knowledge base stylesheet -->

	<!-- output HTML -->
	<xsl:output method="html"/>
	<xsl:include href="Vars.xsl"/>
	<xsl:key name="RoleLocalization" match="RoleLocalization/Role" use="Name"/>
	<xsl:key name="TaskLocalization" match="TaskLocalization/Task" use="Name"/>
	<xsl:key name="ServiceLocalization" match="ServiceLocalization/Service" use="Name"/>
	<xsl:key name="PortLocalization" match="PortLocalization/Port" use="Name"/>
	<xsl:key name="Ports"            match="Ports/Port"            use="Name"/>

	<xsl:template match="SSRKnowledgeBase">
		<html>
			<!-- output title and CSS -->
			<head>
				<title>Security Configuration Knowledge Base</title>
				<link rel="stylesheet" type="text/css" href="../TransformFiles/View/kb.css"/>
			</head>

			<body oncontextmenu="contextMenu(); return false;">
				<xsl:if test="$Display=1">
					<xsl:attribute name="class">kbbody</xsl:attribute>
				</xsl:if>

				<xsl:choose>
					<xsl:when test="$Display=1">
						<span class="kbheader">Security Configuration Knowledge Base</span>	
						<p class="kbdescription">The Security Configuration Knowledge Base contains information about client and server roles, tasks, services, ports, and other settings.</p>
					</xsl:when>
					<xsl:otherwise>
						<span class="kbheader2">Security Configuration Knowledge Base</span>
						<p class="kbdescription2">The Security Configuration Knowledge Base contains information about client and server roles, tasks, services, ports, and other settings.</p>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:apply-templates/>
			</body>
					
		</html>
	</xsl:template>
	
	<!-- This displays the Roles section of the Knowledgebase -->
	
	<xsl:template match="Roles">
		<xsl:if test="$Display=1">
		<span id="shortRoleTitle" style="display: 'none'">
			<table class="kbsections" width="100%" marginheight="0" marginwidth="0" cellpadding="0" cellspacing="0">
			<tr class="kbsectionheaders">
				<td width="10"></td>
				<td width="17" style="cursor:hand;" onclick="shortRoleTitle.style.display='none'; longRoleTitle.style.display='inline';">
				<img src="../TransformFiles/View/RightArrow.gif"  onmouseout="this.src='../TransformFiles/View/RightArrow.gif';"/></td>
				<td>
					<table class="kbsectionheaders" cellpadding="0" cellspacing="0">
						<tr>
						<td style="cursor:hand;" onclick="shortRoleTitle.style.display='none'; longRoleTitle.style.display='inline';">Roles</td>
						</tr>
					</table>
				</td>
			</tr>
			</table>
		</span>	
	
		<span id="longRoleTitle">
			<table class="kbsections" width="100%" cellpadding="0" cellspacing="0">
			<tr class="kbsectionheaders">
				<td width="10"></td>
				<td width="10" style="cursor:hand;" onclick="shortRoleTitle.style.display='inline'; longRoleTitle.style.display='none';">
				<img src="../TransformFiles/View/DownArrow.gif"  onmouseout="this.src='../TransformFiles/View/DownArrow.gif';"/></td>
				<td>
					<table class="kbsectionheaders" cellpadding="0" cellspacing="0">
						<tr>
							<td width="5"></td>
							<td style="cursor:hand;" onclick="shortRoleTitle.style.display='inline'; longRoleTitle.style.display='none';">Roles</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td><xsl:apply-templates><xsl:sort select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/></xsl:apply-templates></td>
			</tr>
			</table>
		</span>	
		</xsl:if>
		
		<xsl:if test="$Display=0">
			<h1>Roles</h1>
			<xsl:apply-templates>
				<xsl:sort select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Role">
		<xsl:variable name="Name" select="translate(Name, '&#x20;&#x9;&#xA;&#xD;-', '')"/>
		<xsl:variable name="DisplayName" select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>
		<xsl:variable name="Description" select="normalize-space(key('RoleLocalization', Name)/Description)"/>

		<xsl:if test="$Display=1">
		<div>
		<span id="shortRole{$Name}">
		<table class="settingsheaderscollapsed" width="100%" >
		<tr>
			<td width="5" style="cursor:hand;" onclick="shortRole{$Name}.style.display='none'; longRole{$Name}.style.display='inline';" title="{$Description}&#13;&#13;Click the triangle to show more information.">
				<img src="../TransformFiles/View/RightArrow.gif"  onmouseout="this.src='../TransformFiles/View/RightArrow.gif';"/>
			</td>
			
			<td style="cursor:hand;" onclick="shortRole{$Name}.style.display='none'; longRole{$Name}.style.display='inline';" title="{$Description}&#13;&#13;Click the triangle to show more information.">
				<xsl:value-of select="$DisplayName"/> 
			</td>
		</tr>
		</table>
		</span>
		
		<span id="longRole{$Name}" style="display: none;">
		<table width="100%">
		<tr>
			<td valign="top" width="15" style="cursor:hand;" onclick="shortRole{$Name}.style.display='inline'; longRole{$Name}.style.display='none';">
				<img src="../TransformFiles/View/DownArrow.gif"  onmouseout="this.src='../TransformFiles/View/DownArrow.gif';"/>
			</td>
			
			<td>		
			<table class="sectionsexpanded" width="95%" cellpadding="0" cellspacing="0">
				<tr>
					<td  class="settingsheadersexpanded" style="cursor:hand;" onclick="shortRole{$Name}.style.display='inline'; longRole{$Name}.style.display='none';">
					<xsl:value-of select="$DisplayName"/> 
					</td>
				</tr>
				<tr>
				<td>	
					<table class="expanddescription" width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td width="5"></td>
							<td>
								<div class="descriptionsections">
									<xsl:if test="@Type">
										<b>Type:</b>&#160;
										<xsl:value-of select="@Type"/>
									</xsl:if>
								</div>
											
								<div class="descriptionsections">
									<xsl:if test="Satisfiable">
										<b>Status:</b>&#160;
										<xsl:choose>
											<xsl:when test="normalize-space(Satisfiable)='TRUE'">Installed</xsl:when>
											<xsl:otherwise>Not installed</xsl:otherwise>
										</xsl:choose>
										<xsl:if test="normalize-space(Selected)='TRUE'">, Selected</xsl:if>
										<xsl:if test="normalize-space(Selected)='FALSE'">, not selected</xsl:if>
									</xsl:if>
									</div>
					
								<div class="descriptionsections">
									<xsl:if test="$Description">
										<b>Description:</b>&#160;
										<xsl:value-of select="$Description"/>
									</xsl:if>
								</div>

								<div class="descriptionsections">
									<xsl:if test="DependsOn/Roles">
										<b>Required roles:</b>
										<xsl:for-each select="DependsOn/Roles/Role">
											<xsl:sort select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>&#160;
											<xsl:value-of select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>
											<xsl:if test="position() != last()">,</xsl:if>
										</xsl:for-each>
									</xsl:if>
								</div>

								<div class="descriptionsections">
									<xsl:if test="Services/Service">
										<b>Required services:</b>
										<xsl:for-each select="Services/Service">
											<xsl:sort select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>&#160;
											<xsl:value-of select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>
											<xsl:if test="position() != last()">,</xsl:if>
										</xsl:for-each>
									</xsl:if>
								</div>
					
								<div class="descriptionsections">
									<xsl:if test="Ports/Port">
										<b>Ports:</b>
										<xsl:for-each select="Ports/Port">
											<xsl:sort select="normalize-space(key('Ports', Name)/Number)" data-type="number"/>&#160;
											<xsl:value-of select="normalize-space(key('Ports', Name)/Number)"/>&#160;(
											<xsl:value-of select="normalize-space(key('PortLocalization', Name)/DisplayName)"/>&#x2014;
											<xsl:value-of select="normalize-space(Type)"/>)
											<xsl:if test="position() != last()">,</xsl:if>
										</xsl:for-each>
									</xsl:if>
								</div>
							</td>
						</tr>
					</table>
				</td>
				</tr>
			</table>
		</td>
		</tr>
		</table>
		</span>
		</div>
		</xsl:if>
		
		<xsl:if test="$Display=0">
		<table>
		<tr>
			<td>
			<div>
			<xsl:if test="$DisplayName">
				<b>Name:</b>&#160;
				<xsl:value-of select="$DisplayName"/>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="@Type">
				<b>Type:</b>&#160;
				<xsl:value-of select="@Type"/>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="$Description">
				<b>Description:</b>&#160;
				<xsl:value-of select="$Description"/>
			</xsl:if>
			</div>

			<div>
			<xsl:if test="DependsOn/Roles">
				<b>Required roles:</b>
				<xsl:for-each select="DependsOn/Roles/Role">
					<xsl:sort select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>&#160;
					<xsl:value-of select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>
					<xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>
			</xsl:if>
			</div>

			<div>
			<xsl:if test="Services/Service">
				<b>Required services:</b>
				<xsl:for-each select="Services/Service">
					<xsl:sort select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>&#160;
					<xsl:value-of select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>
					<xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="Ports/Port">
				<b>Ports:</b>
				<xsl:for-each select="Ports/Port">
					<xsl:sort select="normalize-space(key('Ports', Name)/Number)" data-type="number"/>&#160;
					<xsl:value-of select="normalize-space(key('Ports', Name)/Number)"/>&#160;(
					<xsl:value-of select="normalize-space(key('PortLocalization', Name)/DisplayName)"/>&#x2014;
					<xsl:value-of select="normalize-space(Type)"/>)
					<xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>
			</xsl:if>
			</div>
			</td>
		</tr>
		</table>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="Tasks">
		<xsl:if test="$Display=1">
		<span id="shortTasksTitle" style="display: 'none'">
			<table class="kbsections" width="100%" marginheight="0" marginwidth="0" cellpadding="0" cellspacing="0">
			<tr class="kbsectionheaders">
			<td width="10"></td>
				<td width="17" style="cursor:hand;" onclick="shortTasksTitle.style.display='none'; longTasksTitle.style.display='inline';">
				<img src="../TransformFiles/View/RightArrow.gif"  onmouseout="this.src='../TransformFiles/View/RightArrow.gif';"/></td>
				<td>
					<table class="kbsectionheaders" cellpadding="0" cellspacing="0">
						<tr>
							<td style="cursor:hand;" onclick="shortTasksTitle.style.display='none'; longTasksTitle.style.display='inline';">Tasks</td>
						</tr>
					</table>
				</td>
			</tr>
			</table>
		</span>	
	
		<span id="longTasksTitle">
			<table class="kbsections" width="100%" marginheight="0" marginwidth="0" cellpadding="0" cellspacing="0">
			<tr class="kbsectionheaders">
				<td width="10"></td>
				<td width="10" style="cursor:hand;" onclick="shortTasksTitle.style.display='inline'; longTasksTitle.style.display='none';">
				<img src="../TransformFiles/View/DownArrow.gif"  onmouseout="this.src='../TransformFiles/View/DownArrow.gif';"/></td>
				<td>
					<table class="kbsectionheaders" cellpadding="0" cellspacing="0">
						<tr>
							<td width="5"></td>
							<td style="cursor:hand;" onclick="shortTasksTitle.style.display='inline'; longTasksTitle.style.display='none';">Tasks</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td><xsl:apply-templates>
				<xsl:sort select="normalize-space(key('TaskLocalization', Name)/DisplayName)"/>
				</xsl:apply-templates>
				</td>
			</tr>
			</table>
		</span>	
		</xsl:if>
		
		<xsl:if test="$Display=0">
			<h1>Tasks</h1>
			<xsl:apply-templates>
				<xsl:sort select="normalize-space(key('TaskLocalization', Name)/DisplayName)"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Task">
		<xsl:variable name="Name" select="translate(Name, '&#x20;&#x9;&#xA;&#xD;-', '')"/>
		<xsl:variable name="DisplayName" select="normalize-space(key('TaskLocalization', Name)/DisplayName)"/>
		<xsl:variable name="Description" select="normalize-space(key('TaskLocalization', Name)/Description)"/>

		<xsl:if test="$Display=1">
		<div>
		
		<span id="shortTasks{$Name}">
		<table class="settingsheaderscollapsed" width="100%" >
		<tr>
			<td width="5" style="cursor:hand;" onclick="shortTasks{$Name}.style.display='none'; longTasks{$Name}.style.display='inline';" title="{$Description}&#13;&#13;Click the triangle to show more information.">
				<img src="../TransformFiles/View/RightArrow.gif"  onmouseout="this.src='../TransformFiles/View/RightArrow.gif';"/>
			</td>
			
			<td style="cursor:hand;" onclick="shortTasks{$Name}.style.display='none'; longTasks{$Name}.style.display='inline';" title="{$Description}&#13;&#13;Click the triangle to show more information.">
				<xsl:value-of select="$DisplayName"/> 
			</td>
		</tr>
		</table>
		</span>
			
		<span id="longTasks{$Name}" style="display: none;">
			<table width="100%">
			<tr>
				<td valign="top" width="15" style="cursor:hand;" onclick="shortTasks{$Name}.style.display='inline'; longTasks{$Name}.style.display='none';">	
				<img src="../TransformFiles/View/DownArrow.gif" style="cursor:hand;" onclick="shortTasks{$Name}.style.display='inline'; longTasks{$Name}.style.display='none';"  onmouseout="this.src='../TransformFiles/View/DownArrow.gif';"/>
				</td>
				
				<td>
				<table class="sectionsexpanded" width="95%" cellpadding="0" cellspacing="0">				
				<tr>
				<td class="settingsheadersexpanded" style="cursor:hand;" onclick="shortTasks{$Name}.style.display='inline'; longTasks{$Name}.style.display='none';">
				<xsl:value-of select="$DisplayName"/>
				</td>
				</tr>

				<tr>
				<td>
				<table class="expanddescription" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="5"></td>
					<td>
					<div class="descriptionsections">
					<xsl:if test="Satisfiable">
						<b>Status:</b>&#160;
						<xsl:choose>
							<xsl:when test="normalize-space(Satisfiable)='TRUE'">Installed</xsl:when>
							<xsl:otherwise>Not installed</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="normalize-space(Selected)='TRUE'">, Selected</xsl:if>
						<xsl:if test="normalize-space(Selected)='FALSE'">, not selected</xsl:if>
					</xsl:if>
					</div>
					
					<div class="descriptionsections">
					<xsl:if test="$Description">
						<b>Description:</b>&#160;
						<xsl:value-of select="$Description"/>
					</xsl:if>
					</div>
					
					<div class="descriptionsections">
					<xsl:if test="Roles/Role">
						<b>Required by these Roles:</b>
						<xsl:for-each select="Roles/Role">
							<xsl:sort select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>&#160;
							<xsl:value-of select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>
							<xsl:if test="position() != last()">,</xsl:if>
						</xsl:for-each>
					</xsl:if>
					</div>
					
					<div class="descriptionsections">
					<xsl:if test="Services/Service">
						<b>Required services:</b>
						<xsl:for-each select="Services/Service">
							<xsl:sort select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>&#160;
							<xsl:value-of select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>
							<xsl:if test="position() != last()">,</xsl:if>
						</xsl:for-each>
					</xsl:if>
					</div>
					
					<div class="descriptionsections">
					<xsl:if test="Ports/Port">
						<b>Ports:</b>
						<xsl:for-each select="Ports/Port">
							<xsl:sort select="normalize-space(key('Ports', Name)/Number)" data-type="number"/>&#160;
							<xsl:value-of select="normalize-space(key('Ports', Name)/Number)"/>&#160;(
							<xsl:value-of select="normalize-space(key('PortLocalization', Name)/DisplayName)"/>&#x2014;
							<xsl:value-of select="normalize-space(Type)"/>)
							<xsl:if test="position() != last()">,</xsl:if>
						</xsl:for-each>
					</xsl:if>
					</div>
					</td>
				</tr>
				</table>
				</td>
				</tr>
				</table>
			</td>
			</tr>
			</table>
			</span>
		</div>
		</xsl:if>
				
		<xsl:if test="$Display=0">
		<table>
		<tr>
			<td>
			<div>
			<xsl:if test="$DisplayName">
			<b>Name:</b>&#160;
				<xsl:value-of select="$DisplayName"/>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="$Description">
				<b>Description:</b>&#160;
				<xsl:value-of select="$Description"/>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="Roles/Role">
				<b>Required by these Roles:</b>
				<xsl:for-each select="Roles/Role">
					<xsl:sort select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>&#160;
					<xsl:value-of select="normalize-space(key('RoleLocalization', Name)/DisplayName)"/>
					<xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="Services/Service">
				<b>Required services:</b>
				<xsl:for-each select="Services/Service">
					<xsl:sort select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>&#160;
					<xsl:value-of select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>
					<xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="Ports/Port">
				<b>Ports:</b>
				<xsl:for-each select="Ports/Port">
					<xsl:sort select="normalize-space(key('Ports', Name)/Number)" data-type="number"/>&#160;
					<xsl:value-of select="normalize-space(key('Ports', Name)/Number)"/>&#160;(<xsl:value-of select="normalize-space(key('PortLocalization', Name)/DisplayName)"/>&#x2014;<xsl:value-of select="normalize-space(Type)"/>)
					<xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>
			</xsl:if>
			</div>
			</td>
		</tr>
		</table>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="Services">
		<xsl:if test="$Display=1">
		<span id="shortServicesTitle" style="display: 'none'">
			<table class="kbsections" width="100%" marginheight="0" marginwidth="0" cellpadding="0" cellspacing="0">
			<tr class="kbsectionheaders">
				<td width="10"></td>
				<td width="17" style="cursor:hand;" onclick="shortServicesTitle.style.display='none'; longServicesTitle.style.display='inline';">
				<img src="../TransformFiles/View/RightArrow.gif"  onmouseout="this.src='../TransformFiles/View/RightArrow.gif';"/></td>
				<td>
					<table class="kbsectionheaders" cellpadding="0" cellspacing="0">
						<tr>
							<td style="cursor:hand;" onclick="shortServicesTitle.style.display='none'; longServicesTitle.style.display='inline';">Services</td>
						</tr>
					</table>
				</td>
			</tr>
			</table>
		</span>	
	
		<span id="longServicesTitle">
			<table class="kbsections" width="100%" marginheight="0" marginwidth="0" cellpadding="0" cellspacing="0">
			<tr class="kbsectionheaders">
				<td width="10"></td>
				<td width="10" style="cursor:hand;" onclick="shortServicesTitle.style.display='inline'; longServicesTitle.style.display='none';">
				<img src="../TransformFiles/View/DownArrow.gif"  onmouseout="this.src='../TransformFiles/View/DownArrow.gif';"/></td>
				<td>
					<table class="kbsectionheaders" cellpadding="0" cellspacing="0">
						<tr>
							<td width="5"></td>
							<td style="cursor:hand;" onclick="shortServicesTitle.style.display='inline'; longServicesTitle.style.display='none';">Services</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td><xsl:apply-templates>
				<xsl:sort select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>
				</xsl:apply-templates></td>
			</tr>
			</table>
		</span>
		</xsl:if>
		
		<xsl:if test="$Display=0">
			<h1>Services</h1>
			<xsl:apply-templates>
				<xsl:sort select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Service">
		<xsl:variable name="Name" select="translate(Name, '&#x20;&#x9;&#xA;&#xD;-', '')"/>
		<xsl:variable name="DisplayName" select="normalize-space(key('ServiceLocalization', Name)/DisplayName)"/>
		<xsl:variable name="Description" select="normalize-space(key('ServiceLocalization', Name)/Description)"/>
		
		<xsl:if test="$Display=1">
		<div>
		
		<span id="shortServices{$Name}">
		<table class="settingsheaderscollapsed" width="100%" >
		<tr>
			<td width="5" style="cursor:hand;" onclick="shortServices{$Name}.style.display='none'; longServices{$Name}.style.display='inline';" title="{$Description}&#13;&#13;Click the triangle to show more information.">
			<img src="../TransformFiles/View/RightArrow.gif"  onmouseout="this.src='../TransformFiles/View/RightArrow.gif';"/>
			</td>
			<td style="cursor:hand;" onclick="shortServices{$Name}.style.display='none'; longServices{$Name}.style.display='inline';" title="{$Description}&#13;&#13;Click the triangle to show more information.">
			<xsl:value-of select="$DisplayName"/> 
			</td>
		</tr>
		</table>
		</span>
		
		<span id="longServices{$Name}" style="display: none;">
		<table width="100%">
		<tr>
			<td valign="top" width="15" style="cursor:hand;" onclick="shortServices{$Name}.style.display='inline'; longServices{$Name}.style.display='none';">
				<img src="../TransformFiles/View/DownArrow.gif"  onmouseout="this.src='../TransformFiles/View/DownArrow.gif';"/>
			</td>
			
			<td>
			<table class="sectionsexpanded" width="95%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="settingsheadersexpanded" style="cursor:hand;" onclick="shortServices{$Name}.style.display='inline'; longServices{$Name}.style.display='none';">
					<xsl:value-of select="$DisplayName"/> 
					</td>
				</tr>
				
				<tr>
				<td>
					<table class="expanddescription" width="100%" cellpadding="0" cellspacing="0">
						<tr>
						<td width="5"></td>
						<td>
					
							<div class="descriptionsections">
							<xsl:if test="Satisfiable"><b>Status:</b>&#160;
							<xsl:choose>
								<xsl:when test="normalize-space(Satisfiable)='TRUE'">Installed</xsl:when>
								<xsl:otherwise>Not installed</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="normalize-space(Selected)='TRUE'">, Selected</xsl:if>
							<xsl:if test="normalize-space(Selected)='FALSE'">, not selected</xsl:if>
							</xsl:if>
							</div>

							<div class="descriptionsections">
							<xsl:if test="$Description">
							<b>Description:</b>&#160;
							<xsl:value-of select="$Description"/>
							</xsl:if>
							</div>
		
							<div class="descriptionsections">
							<xsl:if test="Optional">
							<b>Optional:</b>&#160;
							<xsl:value-of select="normalize-space(Optional)"/>
							</xsl:if>
							</div>

							<div class="descriptionsections">
							<xsl:if test="Startup_Default">
							<b>Startup Default:</b>&#160;
							<xsl:value-of select="normalize-space(Startup_Default)"/>
							</xsl:if>
							</div>
						</td>
						</tr>
					</table>
				</td>
				</tr>
			</table>
			</td>
			</tr>
			</table>
			</span>
		</div>
		</xsl:if>

		<xsl:if test="$Display=0">
		<table>
		<tr>
			<td>
			<div>
			<xsl:if test="$DisplayName">
				<b>Name:</b>&#160;
				<xsl:value-of select="$DisplayName"/>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="$Description">
				<b>Description:</b>&#160;
				<xsl:value-of select="$Description"/>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="Optional">
				<b>Optional:</b>&#160;
				<xsl:value-of select="normalize-space(Optional)"/>
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="Startup_Default">
				<b>Startup Default:</b>&#160;
				<xsl:value-of select="normalize-space(Startup_Default)"/>
			</xsl:if>
			</div>
			</td>
		</tr>
		</table>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="Ports">
		<xsl:if test="$Display=1">
		<span id="shortPortsTitle" style="display: 'none'">
			<table class="kbsections" width="100%" marginheight="0" marginwidth="0" cellpadding="0" cellspacing="0">
			<tr class="kbsectionheaders">
				<td width="10"></td>
				<td width="17" style="cursor:hand;" onclick="shortPortsTitle.style.display='none'; longPortsTitle.style.display='inline';">
				<img src="../TransformFiles/View/RightArrow.gif"  onmouseout="this.src='../TransformFiles/View/RightArrow.gif';"/></td>
				<td>
					<table class="kbsectionheaders" cellpadding="0" cellspacing="0">
						<tr>
							<td style="cursor:hand;" onclick="shortPortsTitle.style.display='none'; longPortsTitle.style.display='inline';">Ports</td>
						</tr>
					</table>
				</td>
			</tr>
			</table>
		</span>	
	
		<span id="longPortsTitle">
			<table class="kbsections" width="100%" marginheight="0" marginwidth="0" cellpadding="0" cellspacing="0">
			<tr class="kbsectionheaders">
				<td width="10"></td>
				<td width="10" style="cursor:hand;" onclick="shortPortsTitle.style.display='inline'; longPortsTitle.style.display='none';">
				<img src="../TransformFiles/View/DownArrow.gif"  onmouseout="this.src='../TransformFiles/View/DownArrow.gif';"/></td>
				<td>
					<table class="kbsectionheaders" cellpadding="0" cellspacing="0">
						<tr>
							<td width="5"></td>
							<td style="cursor:hand;" onclick="shortPortsTitle.style.display='inline'; longPortsTitle.style.display='none';">Ports</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td><xsl:apply-templates>
				<xsl:sort select="normalize-space(Number)" data-type="number"/>
				</xsl:apply-templates></td>
			</tr>
			</table>
		</span>	
		</xsl:if>
		
		<xsl:if test="$Display=0">
			<h1>Ports</h1>
			<xsl:apply-templates>
				<xsl:sort select="normalize-space(Number)" data-type="number"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Port">
		<xsl:variable name="Name" select="translate(Name, '&#x20;&#x9;&#xA;&#xD;-', '')"/>
		<xsl:variable name="DisplayName" select="normalize-space(key('PortLocalization', Name)/DisplayName)"/>
		<xsl:variable name="Description" select="normalize-space(key('PortLocalization', Name)/Description)"/>

		<xsl:if test="$Display=1">
			<div>
		
			<span id="shortPorts{$Name}">
			<table class="settingsheaderscollapsed" width="100%" >
			<tr>
				<td width="5" style="cursor:hand;" onclick="shortPorts{$Name}.style.display='none'; longPorts{$Name}.style.display='inline';" title="{$Description}&#13;&#13;Click the triangle to show more information.">
					<img src="../TransformFiles/View/RightArrow.gif"  onmouseout="this.src='../TransformFiles/View/RightArrow.gif';"/>
				</td>
				<td style="cursor:hand;" onclick="shortPorts{$Name}.style.display='none'; longPorts{$Name}.style.display='inline';" title="{$Description}&#13;&#13;Click the triangle to show more information.">
					<xsl:value-of select="normalize-space(Number)"/>&#160;(<xsl:value-of select="$DisplayName"/>)
				</td>
			</tr>
			</table>
			</span>
		
			<span id="longPorts{$Name}" style="display: none;">
			<table width="100%">
			<tr>
				<td valign="top" width="15" style="cursor:hand;" onclick="shortPorts{$Name}.style.display='inline'; longPorts{$Name}.style.display='none';">	
					<img src="../TransformFiles/View/DownArrow.gif" style="cursor:hand;" onclick="shortPorts{$Name}.style.display='inline'; longPorts{$Name}.style.display='none';"  onmouseout="this.src='../TransformFiles/View/DownArrow.gif';"/>
				</td>
			
				<td>
					<table class="sectionsexpanded" width="95%" cellpadding="0" cellspacing="0">
					<tr>
						<td class="settingsheadersexpanded" style="cursor:hand;" onclick="shortPorts{$Name}.style.display='inline'; longPorts{$Name}.style.display='none';">
							<xsl:value-of select="normalize-space(Number)"/>&#160;(<xsl:value-of select="$DisplayName"/>)
						</td>
					</tr>
	
				<tr>
				<td>
					<table class="expanddescription" width="100%" cellpadding="0" cellspacing="0">
						<tr>
						<td width="5"></td>
						<td>
							<div class="descriptionsections">
							<xsl:if test="$Description">
							<b>Description:</b>&#160;
								<xsl:value-of select="$Description"/>
							</xsl:if>
							</div>
					
							<div class="descriptionsections">
							<xsl:if test="Protocols/Protocol">
							<b>Protocols:</b>
							<xsl:for-each select="Protocols/Protocol">
								<xsl:sort/>&#160;<xsl:value-of select="normalize-space(Name)"/>
								<xsl:if test="position() != last()">,</xsl:if>
							</xsl:for-each>
							</xsl:if>
							</div>
							</td>
						</tr>
					</table>
				</td>
				</tr>
				</table>
			</td>
			</tr>
			</table>
			</span>
			</div>	
		</xsl:if>
		
		<xsl:if test="$Display=0">
		<table>
		<tr>
			<td>
			<div>
			<xsl:if test="$DisplayName">
				<b>Number:</b>&#160;
				<xsl:value-of select="normalize-space(Number)"/>&#160;(<xsl:value-of select="$DisplayName"/>)
			</xsl:if>
			</div>
			
			<div>
			<xsl:if test="$Description">
				<b>Description:</b>&#160;
				<xsl:value-of select="$Description"/>
			</xsl:if>
			</div>
	
			<div>
			<xsl:if test="Protocols/Protocol">
				<b>Protocols:</b>
				<xsl:for-each select="Protocols/Protocol">
					<xsl:sort/>&#160;<xsl:value-of select="normalize-space(Name)"/>
					<xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>
			</xsl:if>
			</div>
			</td>
		</tr>
		</table>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="*">
	</xsl:template>
	
</xsl:stylesheet>
