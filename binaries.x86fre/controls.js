var L_WARN800x600 				= "Your screen resolution is less than 800 x 600 pixels. Windows Media Player Tour cannot continue unless the screen resolution is set to 800 x 600 or greater.";
var g_aTopicButtonsList;
var g_sAudioPath				= "../audio/wav/";
var g_sMediaPath 				= "video\\";
var g_sImgWatermarks			= "img/wmarks/";
var g_sLocalPath				= getLocalPath("wmptour.hta");
var g_ClockInterval					= 0;
var g_CurTime						= 0;
var g_CurTick						= 0;
function getHTML(sID)
{
	return eval("idContents." + sID + ".innerHTML");
}
function getText(sID)
{
	return eval("idContents." + sID + ".innerText");
}
function PositionContainers()
{
	var nClientHeight = parseInt(screen.availHeight);
	var nClientWidth = parseInt(screen.availWidth);
	if ((screen.height < 600) || (screen.width < 800))
	{
		alert(L_WARN800x600);
		window.close();
	}
	idTourContainer.style.top = nClientHeight/2 - 277;
	idTourContainer.style.left = nClientWidth/2 - 400;
	idVideoContainer.style.top = nClientHeight/2 - 278;
	idVideoContainer.style.left = nClientWidth/2 - 400;
	idTourContainer.style.visibility = "visible";
	idVideoContainer.style.visibility = "hidden";
}
function getLocalPath(sProjRoot)
{
	var sLocation 		= unescape(window.location.href.toLowerCase());
	sProjRoot 			= sProjRoot.toLowerCase();
	var sRootLoc		= "file:///";
	var nAt 			= sLocation.indexOf(sRootLoc) + sRootLoc.length;
	var nTo 			= sLocation.indexOf(sProjRoot);
	var sPath 			= sLocation.substring(nAt, nTo);
	var s = ""; var ch= "";
	
	for(i = 0; i< sPath.length; i++)
	{
		ch = sPath.charAt(i);
		ch == "/" ? (s = s + "\\") : (s = s + ch);
	}
	return s;
}
function cleanString(sStr)
{
	sStr = escape(sStr);
	sStr = sStr.replace(/%0D/g, "%20");
	sStr = sStr.replace(/%20%20/g, "%20");
	sStr = sStr.replace(/\%0A/g, "");
	sStr = unescape(sStr);
	return sStr;
}
function fixHyphen(sStr)
{
	sStr = escape(sStr);
	sStr = sStr.replace(/%3CHYPHEN%3E/g, "-<BR>");
	sStr = unescape(sStr);
	return sStr;
}
function WriteTopicButtonsCaption()
{
	var sText = "";
	g_aTopicButtonsList = idTourTopics.childNodes;
	for(i=0; i < g_aTopicButtonsList.length; i++)
	{
		sText = fixHyphen(getHTML("txtTopic" + (i + 1) + "Title"));
		g_aTopicButtonsList.item(i).firstChild.innerHTML = sText;
		sText = cleanString(getText("txtTopic" + (i + 1) + "Title"));
		g_aTopicButtonsList.item(i).firstChild.title = sText;
		g_aTopicButtonsList.item(i).title = sText;
	}
}
function ClickTopicButton(nIDX)
{	
	var nClicked = idTourTopics.CURCLICK;
	idTourTopics.CURCLICK = nIDX;
	
	if(nClicked > 0) {
		g_aTopicButtonsList.item(nClicked -1).firstChild.nextSibling.src = g_TopicButton_normal;
		g_aTopicButtonsList.item(nClicked -1).firstChild.className = "clsTopicButtonCaption";
	}
	
	idTourContents.style.background = getWMKImg(nIDX);
	
	g_aTopicButtonsList.item(nIDX -1).firstChild.nextSibling.src = g_TopicButton_down;
	
	g_aTopicButtonsList.item(nIDX-1).firstChild.className = "clsTopicButtonCaptionClicked";
	
	ShowTopic(nIDX);
	if (MyTour.scenes[idTourTopics.CURCLICK -1].showMe) loadMedia(MyTour.scenes[idTourTopics.CURCLICK -1].showMe);
	
	if (idTourAudioImg.STAT == 0 && idTourPlayImg.STAT != 3) PlaySound();
	
	SndFadeOut();
	
	if (MyTour.curScene == (MyTour.length -1))
	{
		TourPlayEVENTonclick(2,0);
	}
	startClock();
}
function ShowTopic(nIDX)
{
	fadeIn(idContentsTitle, 1);
	fadeIn(idContentsBody, 1);
	idContentsTitle.innerHTML 	= getText("txtTopic" + nIDX + "Title");
	idContentsBody.innerHTML 	= getHTML("txtTopic" + nIDX + "Text");
					
}
function ShowVideoInfo(nIDX)
{
	idVideoInfoTitle.innerText 	= cleanString(getText("txtTopic" + nIDX + "Title"));
	idVideoInfoBody.innerHTML 	= getHTML("txtVideInfo" + nIDX);
}
function StartVideoSample()
{
	idAudioTrack.ClearTimedAction();
	playVideo();
	idVideoTitle.innerHTML = getText("txtNowPlaying") + ' " ' + getText("txtTopic" + idTourTopics.CURCLICK + "Title") + '"';
}
function PlaySound()
{
	if (idTourTopics.CURCLICK == 0) return;
	
	idAudioTrack.SndPlay(g_sAudioPath + MyTour.scenes[idTourTopics.CURCLICK - 1].sound);
	
	idAudioTrack.SndFadeIn(250);
	SndFadeOut();
}
function SndFadeOut()
{
	idAudioTrack.TimedAction("SndFadeOut(125)", (MyTour.scenes[idTourTopics.CURCLICK - 1].tremaining - 4000));
}
function MuteSound()
{
	idAudioTrack.sound.src = "";
}
function playVideo()
{
	idVideo.controls.play();
}
function stopVideo()
{
	idVideo.controls.stop();
	idVideo.URL = "";
}
function loadMedia(sMedia)
{
	var sFullPath = g_sLocalPath + g_sMediaPath + sMedia;
	idVideo.URL = sFullPath;
}
function getWMKImg(nIDX)
{
	return "white url('" + g_sImgWatermarks + "/wm" + nIDX +".gif') no-repeat bottom right";
}
function fadeIn(oObj, tDur)
{
	if (tDur == 0)
	{
		oObj.style.visibility="visible";
	}
	else
	{
	    oObj.style.filter="revealTrans(DURATION=" + tDur + ", TRANSITION=7)";
	    if (oObj.filters.revealTrans.status != 2)
	    {
	    	oObj.style.visibility="hidden";
	        oObj.filters.revealTrans.apply();
	        oObj.style.visibility="visible";
	        oObj.filters.revealTrans.play();
	    }
}
}
function startClock()
{
	pauseClock();
	if(MyTour.scenes[MyTour.curScene])
	{
		g_CurTime = (MyTour.scenes[MyTour.curScene].tremaining /1000);
		g_ClockInterval = setInterval("getElapsedTime()", 1000);
		g_CurTick = 0;
		getElapsedTime();
	}
}
function stopClock()
{
	if (g_ClockInterval) clearInterval(g_ClockInterval);
	g_ClockInterval = 0;
	g_CurTick = 0;
	
}
function pauseClock()
{
	clearInterval(g_ClockInterval);
	g_ClockInterval = 0;
}
function resumeClock()
{
	pauseClock();
	
	g_ClockInterval = setInterval("getElapsedTime()", 1000);
}
function getElapsedTime()
{
	var time 	= Math.ceil(g_CurTime - (++g_CurTick));
	var s	= "";
	if (time > 9)
	{
		s = "00:";	/* LOCALIZATION, if required to localize numerals displayed this variable should also be localized */
	}
	else
	{
		s = "00:0";	/* LOCALIZATION, if required to localize numerals displayed this variable should also be localized */		
	}
	if(time >= 0)
	{
		idTimeElapsed.innerText = s + time;
	}
}
function clearClockDisplay()
{
	idTimeElapsed.innerText = "" ;
}
function setTitles()
{
	var sBackToTour		= getText("btnBackToTourCaption");
	var sTourTitle		= getText("txtApplicationTitle");
	var sCloseCaption 	= getText("btnCloseCaption");
	var sMPLogoCaption 	= getText("titleWMPLogo");
	
	idCloseTourAppImg.title 	= sCloseCaption;
	idCloseTourAppImg.alt 		= sCloseCaption;
	idCloseVideoAppImg.title 	= sCloseCaption;
	idCloseVideoAppImg.alt 		= sCloseCaption;
	idBackToTourImg.title		= sBackToTour;
	idBackToTourImg.alt			= sBackToTour;
	idMPLogoImg.title 			= sMPLogoCaption;
	idMPLogoImg.alt 			= sMPLogoCaption;
	idTourTitle.innerText		= sTourTitle;
		
}
