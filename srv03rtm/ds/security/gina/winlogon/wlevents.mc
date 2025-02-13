;/*++ BUILD Version: 0001    // Increment this if a change has global effects
;
;Copyright (c) 1992  Microsoft Corporation
;
;Module Name:
;
;    wlevents.h
;
;Abstract:
;
;    Definitions for User Profiles Events
;
;Author:
;
;    Johannec 12-08-93
;
;Revision History:
;
;Notes:
;
;    This file is generated by the MC tool from the wlevents.mc file.
;
;--*/
;
;
;#ifndef _PROFEVT_
;#define _PROFEVT_
;


SeverityNames=(Success=0x0:STATUS_SEVERITY_SUCCESS
               Informational=0x1:STATUS_SEVERITY_INFORMATIONAL
               Warning=0x2:STATUS_SEVERITY_WARNING
               Error=0x3:STATUS_SEVERITY_ERROR
              )
	
;
;/////////////////////////////////////////////////////////////////////////
;//
;// Winlogon Events (1000 - 1999)
;//
;/////////////////////////////////////////////////////////////////////////
;

MessageId=1000 Severity=Error SymbolicName=EVENT_SET_HOME_DIRECTORY_FAILED
Language=English
Failed to set the user's home directory %1.
.

MessageId=1001 Severity=Informational SymbolicName=EVENT_AUTOCHK_DATA
Language=English
%1
.

MessageId=1002 Severity=Informational SymbolicName=EVENT_SHELL_RESTARTED
Language=English
The shell stopped unexpectedly and %1 was restarted.
.


MessageId=1003 Severity=Error SymbolicName=EVENT_AE_INITIALIZATION_FAILED
Language=English
Initialization of automatic certificate enrollment has failed.  There is possible corruption
of system DLL's required for auto-enrollment.  (%1) %2
.

MessageId=1004 Severity=Error SymbolicName=EVENT_UAE_VERIFICATION_FAILURE
Language=English
Verification of an automatically enrolled certificate has failed. (%1) %2
.

MessageId=1005 Severity=Error SymbolicName=EVENT_UAE_UNKNOWN_CERT_TYPE
Language=English
Unknown or unavailable cert type, %3, requested for automatic certificate enrollment.
This enrollment will not be performed. (%1) %2
.

MessageId=1006 Severity=Informational SymbolicName=EVENT_OLD_CERT_VERIFY_RENEW_WARNING
Language=English

The automatically enrolled certificate of type %1 is being renewed for the following reason(s):
%2
.

MessageId=1007 Severity=Informational SymbolicName=EVENT_OLD_CERT_VERIFY_REENROLL_WARNING
Language=English
The automatically enrolled certificate of type %1 is being re-enrolled for the following reason(s):
%2
.

MessageId=1008 Severity=Error SymbolicName=EVENT_UPDATE_ENTERPRISE_ROOT_FAILURE
Language=English
The enterprise root certificate store could not be updated.
(%1) %2.
.

MessageId=1009 Severity=Error SymbolicName=EVENT_UPDATE_NTAUTH_FAILURE
Language=English
The NT Smartcard authentication certificate store could not be updated.
(%1) %2.
.

MessageId=1010 Severity=Warning SymbolicName=EVENT_AE_ENROLLMENT_FAILED
Language=English
Automatic enrollment against the certification authority %4 for a certificate of type %3 has
failed.  (%1) %2.   Another certification authority will be tried.
.


MessageId=1011 Severity=Warning SymbolicName=EVENT_ENROLLED_CERT_VERIFY_WARNING
Language=English
The certificate returned from an auto-enrollment is incorrect.  Subsequent auto-enrollment cycles
will ignore reasons for failure.  Please contact your system administrator.  The reasons for failure are
listed below:
%2
.

MessageId=1012 Severity=Error SymbolicName=EVENT_AE_LOCAL_CYCLE_INIT_FAILED
Language=English
The automatic certificate enrollment subsystem could not access local resources needed for enrollment.  
Enrollment will not be performed. (%1) %2
.

MessageId=1013 Severity=Error SymbolicName=EVENT_AE_NETWORK_CYCLE_INIT_FAILED
Language=English
The automatic certificate enrollment subsystem could not access network resources needed for enrollment.  
Enrollment will not be performed. (%1) %2
.

MessageId=1014 Severity=Error SymbolicName=EVENT_AE_SECURITY_INIT_FAILED
Language=English
A security failure is preventing automatic certificate enrollment.  
Enrollment will not be performed. (%1) %2
.

MessageId=1015 Severity=Error SymbolicName=XP_NEWMSG_1015
Language=English
A critical system process, %1, failed with status code %2.  The machine
must now be restarted.
.

;// %1 - domain, %2 - user
MessageId=1100 SymbolicName=MSG_MOVE_USER_QUESTION
Language=English
Welcome back to the %1 domain.  While you were offline, your settings were stored in a local account. Do you want to move them to your %1 account?%0
.

;// %1 - error code (DWORD)
MessageId=1101 SymbolicName=MSG_MOVE_USER_ERROR
Language=English
Your settings cannot be moved because of an error.  (Error code %1!u!)%0
.

;// %1 - computer name
MessageId=1102 SymbolicName=MSG_MY_COMPUTER
Language=English
%1 (this computer)%0
.

;// %1 - user name
MessageId=1103 SymbolicName=MSG_LOCAL_BAD_PASSWORD
Language=English
The system could not validate %1. Check your account name, and type your password again. Letters in passwords must be typed using the correct case. Make sure that Caps Lock is not accidentially on.%0
.

;// %1 = user name, %2 - domain name
MessageId=1104 SymbolicName=MSG_DOMAIN_BAD_PASSWORD
Language=English
The system could not validate %1 on %2. Check your account name, and type your password again. Letters in passwords must be typed using the correct case. Make sure that Caps Lock is not accidentially on.%0
.

;// %1 - error code (DWORD)
MessageId=1105 SymbolicName=MSG_NOT_ADMINISTRATOR
Language=English
The user account you just entered does not have the authority to move settings. Please try another account, such as Administrator.%0
.


; //
; // Autoenrollment test events
; //

MessageId=1200 Severity=Warning SymbolicName=AE_TEST_EXTENSION_EKU
Language=English
The certificate does not fulfill the intended usage requirements specified by the certificate template:
Certificate: %1
Certificate Template: %2

.

MessageId=1201 Severity=Warning SymbolicName=AE_TEST_EXTENSION_KU
Language=English
The certificate does not fulfill the key usage requirements specified by the certificate template:
Certificate: %1
Certificate Template: %2

.

MessageId=1202 Severity=Warning SymbolicName=AE_TEST_EXTENSION_BC
Language=English
The certificate does not fulfill the basic constraints requirements specified by the certificate template:
Certificate: %1
Certificate Template: %2

.

MessageId=1203 Severity=Warning SymbolicName=AE_TEST_EXTENSION_TEMPLATE
Language=English
The certificate does not contain the template name specified by the certificate template:\n
Certificate: %1\n
Certificate Template: %2

.

MessageId=1204 Severity=Warning SymbolicName=AE_TEST_NAME_UPN
Language=English
The certificate does not contain the any of the principal names specified for this user:
Principal Name(s): %1

.

MessageId=1205 Severity=Warning SymbolicName=AE_TEST_NAME_SUBJECT_EMAIL
Language=English
The subject name of this certificate does not contain the e-mail name for this user:
User e-mail name(s): %1

.

MessageId=1206 Severity=Warning SymbolicName=AE_TEST_NAME_ALT_SUBJECT_EMAIL
Language=English
The alternate subject name of this certificate does not contain the e-mail name for this user:
User e-mail name(s): %1

.

MessageId=1207 Severity=Warning SymbolicName=AE_TEST_NAME_BOTH_SUBJECT_EMAIL
Language=English
This certificate does not contain the e-mail name for this user:
User e-mail name(s): %1

.

MessageId=1208 Severity=Warning SymbolicName=AE_TEST_NAME_SUBJECT_DNS
Language=English
The certificate does not contain the DNS name of the machine:
DNS Name(s): %1

.

MessageId=1209 Severity=Warning SymbolicName=AE_TEST_NAME_DIRECTORY_NAME
Language=English
This certificate does not contain the Directory Name of the user or machine:
Directory Name(s): %1

.

MessageId=1210 Severity=Warning SymbolicName=AE_TEST_NAME_NO_OBJID
Language=English
This certificate does not contain the Active Directory object identifier of the user or machine.

.

MessageId=1211 Severity=Warning SymbolicName=AE_TEST_NAME_OBJID
Language=English
This certificate contains an Active Directory object identifier, but should not.

.

MessageId=1212 Severity=Warning SymbolicName=AE_TEST_CHAIN_FAIL
Language=English
The certificate is no longer trusted for the following reason (0x%1!lx!) %2.

.

MessageId=1213 Severity=Warning SymbolicName=AE_TEST_ISSUER_FAIL
Language=English
The certificate's issuer is no longer allowed by the autoenrollment object.

.

MessageId=1214 Severity=Warning SymbolicName=AT_TEST_PENDING_EXPIRATION
Language=English
The certificate will expire soon.

.

MessageId=1215 Severity=Informational SymbolicName=AT_TEST_SUBJECT_NAME
Language=English
Subject Name:%1

.

MessageId=1216 Severity=Informational SymbolicName=AT_TEST_ALT_SUBJECT_NAME
Language=English
Alternate Subject Name:%1

.

MessageId=1217 Severity=Warning SymbolicName=XP_NEWMSG_1217
Language=English
Execution of GPO scripts has timed out and have been terminated.

.

;
;#endif // _PROFEVT_
;
