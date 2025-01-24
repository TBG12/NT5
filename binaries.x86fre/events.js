var g_CloseApp_normal = "img/btn/cloapp.gif";
var g_CloseApp_hover = "img/btn/cloapph.gif";
var g_MPLogo_normal = "img/mplogo.gif";
var g_MPLogo_hover = "img/mplogoh.gif";
var g_TopicButton_normal = "img/btn/cnt.gif";
var g_TopicButton_hover = "img/btn/cnth.gif";
var g_TopicButton_down = "img/btn/cntd.gif";
var g_TourAudioOn_normal = "img/btn/taon.gif";
var g_TourAudioOn_hover = "img/btn/taonh.gif";
var g_TourAudioOff_normal = "img/btn/taoff.gif";
var g_TourAudioOff_hover = "img/btn/taoffh.gif";
var g_TourPlay_normal = "img/btn/tplay.gif";
var g_TourPlay_hover = "img/btn/tplayh.gif";
var g_TourPause_normal = "img/btn/tpause.gif";
var g_TourPause_hover = "img/btn/tpauseh.gif";
var g_BackToTour_normal = "img/btn/bktr.gif";
var g_BackToTour_hover = "img/btn/bktrh.gif";
function TopicButtonEVENTonmouseover(nIDX)
{
	if(idTourTopics.CURCLICK != nIDX)
	{
		g_aTopicButtonsList.item(nIDX-1).firstChild.className = "clsTopicButtonCaptionMouseOver"; 		
		g_aTopicButtonsList.item(nIDX-1).firstChild.nextSibling.src = g_TopicButton_hover;
	}
}
function TopicButtonEVENTonmouseout(nIDX)
{	
	if(idTourTopics.CURCLICK != nIDX)
	{
		g_aTopicButtonsList.item(nIDX-1).firstChild.className = "clsTopicButtonCaption";
		g_aTopicButtonsList.item(nIDX-1).firstChild.nextSibling.src = g_TopicButton_normal;
	}
}
function TopicButtonEVENTonclick(nIDX)
{
	if (idTourTopics.CURCLICK == nIDX) return;
	
	if (idTourPlayImg.STAT == 0 || idTourPlayImg.STAT == 4 )
	{
		ClickTopicButton(nIDX);
		stopClock();
		clearClockDisplay();
	}
	else if (idTourPlayImg.STAT == 1)
	{
		MyTour.clearAllSetRemaining();
		MyTour.setScene(nIDX -1);
		MyTour.playScene();
	}
}
function PlayVideoEVENTonmouseover(oObj)
{
	oObj.title = getText("btnPlayVideo");
}
function PlayVideoEVENTonclick(oObj)
{	
	idTourContainer.style.visibility = "hidden";
	ShowVideoInfo(idTourTopics.CURCLICK);
	
	if (idTourPlayImg.STAT == 1)
	{
	 	idTourPlayImg.STAT = 3;
	 	MyTour.pause();
	}	
	fadeIn(idVideoContainer, 0);
	StartVideoSample();
}
function AudioPlayEVENTonmouseover(nSTAT)
{	
	var sText = ""
	if (nSTAT == 0)													
	{
		sText = getText("btnAudioPauseCaption");
		idTourAudioImg.title = sText;
		idTourAudioImg.alt = sText;
		idTourAudioImg.src = g_TourAudioOn_hover;
	}
	else if (nSTAT == 1)
	{
		sText = getText("btnAudioPlayCaption");
		idTourAudioImg.title = sText;
		idTourAudioImg.alt = sText;
		idTourAudioImg.src = g_TourAudioOff_hover;
	}
}
function AudioPlayEVENTonmouseout(nSTAT)
{	
	if (nSTAT == 0)
	{
		idTourAudioImg.src = g_TourAudioOn_normal;
	}
	else if (nSTAT == 1)
	{
		idTourAudioImg.src = g_TourAudioOff_normal;
	}
}
function AudioPlayEVENTonclick(nSTAT, nType)
{	
	if(nSTAT == 0)
	{
		idTourAudioImg.STAT = 1;
		MuteSound();
		if (nType == 0) {idTourAudioImg.src = g_TourAudioOff_normal}else{idTourAudioImg.src = g_TourAudioOff_hover};
		
		idTourAudioImg.title = getText("btnAudioPlayCaption");
	}
	else if(nSTAT == 1)
	{
		idTourAudioImg.STAT = 0;
		PlaySound();
		if (nType == 0) {idTourAudioImg.src = g_TourAudioOn_normal}else{idTourAudioImg.src = g_TourAudioOn_hover};
		
		idTourAudioImg.title = getText("btnAudioPauseCaption");
	}
}
function TourPlayEVENTonmouseover(nSTAT)
{
	var sText = ""
	if (nSTAT == 0 || nSTAT == 4)
	{
		sText = getText("btnTourPlayCaption");
		idTourPlayImg.title = sText;
		idTourPlayImg.alt = sText;
		idTourPlayImg.src = g_TourPlay_hover;
	}
	else if (nSTAT == 1)
	{
		sText = getText("btnTourPauseCaption");
		idTourPlayImg.title = sText;
		idTourPlayImg.alt = sText;
		idTourPlayImg.src = g_TourPause_hover;
	}
}
function TourPlayEVENTonmouseout(nSTAT)
{
	if (nSTAT == 0 || nSTAT == 4)
	{
		idTourPlayImg.src = g_TourPlay_normal;
	}
	else if (nSTAT == 1)
	{
		idTourPlayImg.src = g_TourPause_normal;
	}
}
function TourPlayEVENTonclick(nSTAT, nType)
{
	var sText = ""
	if (nSTAT == 0)
	{
		MyTour.nextScene = true;
		MyTour.playScene();
		SndFadeOut();
		sText = getText("btnTourPauseCaption");
		idTourPlayImg.title = sText;
		idTourPlayImg.alt = sText;
		if (nType == 0) {idTourPlayImg.src = g_TourPause_normal} else{idTourPlayImg.src = g_TourPause_hover};
			
		idTourPlayImg.STAT = 1;
		resumeClock();
	}
	else if (nSTAT == 1)
	{
		idTourPlayImg.STAT = 0;
		MyTour.pause();
		sText = getText("btnTourPlayCaption");
		idTourPlayImg.title = sText;
		idTourPlayImg.alt = sText;
		if (nType == 0) {idTourPlayImg.src = g_TourPlay_normal;}else{idTourPlayImg.src = g_TourPlay_hover};
		
		idAudioTrack.ClearTimedAction();
		pauseClock();
		clearClockDisplay();
	}
	else if(nSTAT == 2)
	{
		idTourPlayImg.STAT = 4;
		sText = getText("btnTourPlayCaption");
		idTourPlayImg.title = sText;
		idTourPlayImg.alt = sText;
		idTourPlayImg.src = g_TourPlay_normal;
	}
	else if(nSTAT == 4)
	{
		idTourPlayImg.STAT = 1;
		MyTour.start();
	}
}
function CloseAppEVENTonmouseover(oObj)
{
	oObj.src = g_CloseApp_hover;
}
function CloseAppEVENTonmouseout(oObj)
{
	oObj.src = g_CloseApp_normal;
}
function CloseAppEVENTonclick(oObj)
{	
	window.close();
}
function MPLogoEVENTonmouseover(oObj)
{
	oObj.src = g_MPLogo_hover;
}
function MPLogoEVENTonmouseout(oObj)
{
	oObj.src = g_MPLogo_normal;
}
function MPLogoEVENTonclick(oObj)
{
	oObj.src = g_MPLogo_normal;
}
function BackToTourEVENTonmouseover()
{
	idBackToTourImg.src = g_BackToTour_hover;
}
function BackToTourEVENTonmouseout()
{
	idBackToTourImg.src = g_BackToTour_normal;
}
function BackToTourEVENTonclick()
{
	stopVideo();
	idVideoContainer.style.visibility = "hidden";
	idTourContainer.style.visibility = "visible";
	
	if (idTourPlayImg.STAT == 3)
	{
		MyTour.playScene();
		idTourPlayImg.STAT = 1;
	}
	ShowTopic(idTourTopics.CURCLICK);
}
function CheckKeyCodes()
{
	switch (event.keyCode)
	{
		case 27 :
			CloseAppEVENTonclick();
		case 13 :
			
		default :
	}
}
