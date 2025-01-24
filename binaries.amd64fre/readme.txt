Microsoft Security Configuration Wizard Beta
(c) 2003 Microsoft Corporation
All Rights Reserved.

Table of Contents
=================
1. Introduction
2. Overview
3. Security Coverage (RTM)
4. Operational Coverage (RTM)
5. Operating System Coverage (RTM)
6. Non-Supported Scenarios
7. Beta Functionality
8. Installing SCW
9. Runtime Requirements
10. Helpful Hints
11. Known Issues
12. Upward Compatibility
13. Getting Support and Providing Feedback


1. Introduction
===============
Welcome to the Security Configuration Wizard (SCW) Beta. This readme is designed to give you a brief overview of SCW, describe the functionality that is and is not implemented yet and 


2. Overview
===========
The Security Configuration Wizard (SCW) is a tool to help customers improve the security of their Windows Servers. SCW asks the user a series of questions designed to solicit the functionality required by a given server and disables the remaining functionality.  In short, SCW can be thought of as providing guided attack surface reduction for Windows Servers operating in various roles (e.g. File Server, Web Server, Domain Controller, etc.) and in various deployment scenarios (DMZ, Internet, intranet, etc.).


3. Security Coverage (RTM)
==========================
The goal for the final, "release to manufacturing" (RTM) version of SCWv1 is to provide security coverage for the following areas:

o Services - SCW can be used to disable unnecessary services.
o Packet Filtering - SCW can be used to block and permit specific types of network traffic.
o IP Security - SCW can be used to secure network traffic.
o Registry Values - SCW can be used to configure the following registry values based on downlevel interoperability requirements:
	- LanmanCompatibilityLevel
	- SMB Security Signatures
	- NoLMHash
	- LDAPServerIntegrity
o Audit Policy - SCW can be used to create a high signal to noise ratio audit policy based on auditing objectives.
o IIS Settings - SCW can configure settings for Web Extensions and legacy VDIRs.
o Security Configuration Editor (SCE) templates - SCW can import SCE INF templates to configure settings that are not covered by the wizard.
o .Net Enterprise Server Roles:
	- Exchange 2003
	- SQL Server 2000
	- ISA Server 2004 (Stingray)
	- Sharepoint Portal Server
	- Sharepoint Team Services
	- Operations Manager 2000

4. Operational Coverage (RTM)
=============================
The goal for the RTM version of SCWv1 is to support the following operational features:

o Compliance Analysis - Verify that a server is in compliance with an SCW generated security policy.
o Hotfix Analysis - Uses forthcomming Windows Update API's to identify critical hotfixes that are missing.
o Rollback - Undo previously applied security settings.
o Remotability - Remotely Configure, Analyze or Rollback a system
o Extensibility - Allows customers to declaratively extend the SCW "Knowledge Base" with custom roles.
o Group Policy Integration - Allows customers to transform SCW generated XML security policies into files (INF and .IPSec) that can be imported into local or Group policy.
o Command Line Tool Support - for configuration, analysis, transform, and rollback.
o Edit - Allows modification of an existing policy.
o View Policy - Allows the user to view the wizard's recommendations without having to deploy them.
o View Knowledge Base - Allows the wizard's knowledge base to be viewed for educational purposes.
o Centralized Knowledge Base Repository.
o Localization into SP1 Languages.


5. Operating System Coverage (RTM)
==================================
The target platform for SCW v1 is Windows Server 2003 SP1. Using SCW v1 to configure or create policies for earlier versions of Windows will not be tested nor supported.

6. Non-Supported Scenarios
==========================
There are no plans to support the following scenarios in the RTM version of SCW v1.
o UI Extensibility - Specifically, additional pages cannot be added to the wizard.
o Analysis Consolidation - While XML result files can be collected into a single location, there are no plans to summarize or "roll up" individual analysis results into a single cummulative report.
o IPSec Compliance Analysis
o MUI (Multi-Language User Interface).  A separate out of band release is being considered to add MUI support.
o Installation of SCW v1 on Operating Systems prior to Windows Server 2003 SP1 will not be tested nor supported.
o Policy files created using the SCW Beta will not be supported on the RTM version.

7. Beta Functionality
=====================
The Beta release of SCW provides support for the following subset of aforementioned features:
o Service Configuration
o Packet Filtering
o IP Security
o Registry Values
o Windows and .NES Roles
o Single Level Rollback
o Remotability
o Declarative Extensibility
o Edit
o View Knowledge Base
o Localization into SP1 Languages

8. Installing SCW
=================
- Installing Service Pack 1 does NOT install SCW.
- After installing SP1, the SCW tool is available for installation via Add\Remove Windows Components.
- The SCW Optional Component installation process copies the following binaries into system32:
	o ActiveSockets.dll
	o ComplianceExtensions.dll
	o SCW.exe
	o scwcmd.exe
	o scwengb.dll
	o scwengf.dll
	o scwhlp.dll
	o ScwIPSecExt.dll
	o ScwRegistryExt.dll
	o ScwServiceExt.dll
	o SeVA.dll
	o SMEF.dll
- SCW also creates a directory structure and copies data files under %windir%\security\msscw.
- The SCW Knowledge Base Files are maintained under %windir%\security\msscw\kbs.


9. Runtime Requirements
=======================
- To run SCW, Start/Run/SCW.exe or Start/Programs/Administrative Tools/Microsoft Security Configuration Wizard
- In order to create a security policy, you must select a target server to base the policy on.
- For Beta, the selected target server must be running Windows Server 2003 or higher.
	- For RTM, only Windows Server 2003 SP1 or higher will be supported.
- SCW does not have to be installed on the selected target server to create a security policy based on that server.
- SCW does have to be installed on the selected target server to configure that server with the SCW generated XML policy.
	- For RTM, you can "transform" the SCW XML policies into files that can be natively applied to a target server via local or group policy.
- You must have administrative privileges on the target server to perform SCW operations against it (e.g. Create Policy, Configure, Rollback).


10. Helpful Hints
================
- SCW policies must end with a .xml extension.
- By default, SCW policies are saved in %windir%\security\msscw\policies.
- SCW log files are stored in %windir%\security\msscw\logs.
	- When creating a policy, the log file is stored on the machine running the UI.
	- When configuring or rolling back a machine, the log file is stored on the machine being configured or rolled back.
- SCW knowledge base files are stored in %windir%\security\msscw\kbs
	- The core knowledge base for Windows Server 2003 is called W2k3.xml
- You can extend the knowledge base by creating a schema compliant xml file and editing the %windir%\security\msscw\kbs\kbreg.xml file.
- See %windir%\security\msscw\kbs\SQLServer2000.xml for an example of a declarative knowledge base extension.
- After configuring a machine with an SCW generated IPSec policy, you can view the instantiated IPSec policy using the IPSec Security Policy Management Snap-in.


11. Known Issues
================
a. MICROSOFT CLUSTER SERVER NOT SUPPORTED
The SCW Beta does not set service startup modes properly for SQL, Exchange and other services running in a clustered environment. SCW should not be used to secure such an environment. Cluster support is expected RTM.

b. SQL NAMED INSTANCE PORTS NOT DETERMINED PROPERLY
The beta release of SCW does not automatically detect the ports being used by named instances of SQL Server. Such ports have to be manually added.

c. DYNAMIC EXEMPTIONS NOT RECORDED FOR 2ND ADDRESS OR SUBNET
When filtering IP traffic on more than one address or subnet, Dynamic Exemptions (e.g. Domain Controllers, DHCP Servers, DNS Servers, etc.) for filters established over the second address or subnet are not saved in the policy even though they are displayed properly on the IPSec summary page.

d. NON-DETERMINISTIC BEHAVIOR WHEN MULTIPLE COPIES OF THE WIZARD ARE RUN.
The beta release allows the wizard to be launched multiple times.  However, you should only run one instance of the wizard at a time.

e. CANNOT CONNECT TO A REMOTE SERVER AFTER APPLYING A SECURITY POLICY.
It is possible to create a security policy that prevents subsequent remote management of the machine.  In this case, you may need to visit the target machine and manage it (e.g. roll it back) locally.

f. INACCURATE PROGRESS BAR FEEDBACK
Configuring or rolling back a server may take several minutes. During this time, progress feedback may be inaccurate, appear to "hang", or fail to complete even when the operation has completed successfully.  This will be fixed for RTM.

g. ONLY ONE LEVEL OF ROLLBACK CAN BE PERFORMED
For the beta, SCW only supports one level of Rollback. Thus, if you perform two configurations in a row, you can only rollback the last configuration. You can manually workaround this by making a backup of the rollback directory (created during the first configuration) prior to performing the second configuration. Then, after rolling back the second configuration, restore the rollback created during the first configuration and rollback again.  By default, the rollback directory is located at %windir%\security\msscw\rollbackfiles.

For RTM, SCW will generate XML rollback files that are compliant with the policy schema allowing them to be deployed and analyzed just like any other configuration file.

h. IPSEC: CANNOT ADD PORTS FROM THE KNOWLEDGE BASE
This will be supported for RTM. For the preview release, you can type in the desired port number if it is not already available for selection.

i. UNINSTALLING SP1 REMOVES POLICY FILES
Uninstalling SP1 will remove all of SCW including any policy files that were created and saved in the %windir%\security\msscw tree.


12. Upward Compatibility
========================
The schema definitions for the knowledge base and the output security policy will change between this beta and future releases. Therefore knowledge base extensions and security policies created using the beta release will not work with future releases.


13. Getting Support and Providing Feedback
==========================================
We encourage and welcome your feedback. Newsgroups are the primary support and feedback vehicle for the beta. Please see the SP1 Beta Site for information on SCW-specific newsgroups.
Bug reports can also be filed via the SP1 Beta Site.
 
Thank you for your support of the Security Configuration Wizard and your objective feedback.

Sincerely,
The SCW Development Team
