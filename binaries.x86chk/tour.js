var oTour	= new Tour;
function Scene(Title, Idx, Action, Dur, TimeoutID, ShowMeAction, SoundAction)
{
	this.title 		= Title;
	this.idx		= Idx;
	this.action		= Action;
	this.dur		= Dur;
	this.timeoutID	= TimeoutID;
	this.showMe		= ShowMeAction;
	this.sound		= SoundAction;
	this.tremaining	= 0;
	this.tstart		= 0;
	this.useremaining  = false;
}
function Tour()
{
	this.curScene 	= 0;
	this.nextScene	= false;
	this.setScene	= setScene;
	this.playNextScene = playNextScene;
	this.scenes 	= new Array();
	this.addScene 	= addScene;
	this.newScene 	= newScene;
	this.clearAllRuning = clearAllRuning;
	this.playScene	= playScene;
	this.play		= playTour;
	this.pause		= pauseTour;
	this.start		= startTour;
	this.stop		= stopTour;
	this.reset		= resetTour;
	this.setRemaining  = setRemaining;
	this.setTRemaining = setTRemaining;
	this.length		= this.scenes.length;
	this.clearAllSetRemaining = clearAllSetRemaining;
}
function newTour()
{
	return oTour;
}
function addScene(oScene)
{
	oTour.scenes[oTour.length++] = oScene;
}
function newScene(sTitle, nIdx, sAction, tDur, sSMAction, sSoundAction)
{
	var newScn = new Scene(sTitle, nIdx, sAction, tDur, 0, sSMAction, sSoundAction);
	oTour.addScene(newScn);
}
function getTime()
{
var d = new Date();
return (d.getTime());
}
function playScene()
{
	oTour.clearAllRuning();
	if(oTour.scenes[oTour.curScene]){
		oTour.scenes[oTour.curScene].tstart = getTime();
		if(oTour.scenes[oTour.curScene].tremaining == 0) oTour.scenes[oTour.curScene].tremaining = oTour.scenes[oTour.curScene].dur;
		eval(oTour.scenes[oTour.curScene].action);
		oTour.curScene++;
		
		if (oTour.nextScene)
		{
			oTour.playNextScene();
		}
	}
}
function clearAllRuning()
{
	for(i = 0; i<oTour.length; i++)
	{
		if(oTour.scenes[i].timeoutID)
		{
			clearInterval(oTour.scenes[i].timeoutID)
			oTour.scenes[i].timeoutID = 0;
		}
	}
}
function clearAllSetRemaining()
{
	for(i = 0; i<oTour.length; i++)
	{
		if(oTour.scenes[i].timeoutID)
		{
			clearInterval(oTour.scenes[i].timeoutID)
			oTour.scenes[i].tremaining = oTour.scenes[i].dur;
			oTour.scenes[i].timeoutID = 0;
		}
	}
}
function playNextScene()
{	
	if(oTour.curScene < oTour.length)
	{
		oTour.scenes[oTour.curScene].timeoutID = setInterval("oTour.play()", (oTour.scenes[oTour.curScene - 1].tremaining));
		
	}		
	else
	{
		oTour.nextScene = false;
	}
}
function playTour()
{
		oTour.setRemaining();
		oTour.playScene();
}
function setRemaining()
{
	oTour.scenes[oTour.curScene].tremaining = oTour.scenes[oTour.curScene].dur;
}
function pauseTour()
{
	oTour.clearAllRuning();
	oTour.setTRemaining();
	if (oTour.curScene > 0 ) oTour.curScene--;
}
function setTRemaining()
{
	oTour.scenes[oTour.curScene - 1].tremaining =  oTour.scenes[oTour.curScene - 1].dur - (getTime() - oTour.scenes[oTour.curScene - 1].tstart);
}
function stopTour()
{
	oTour.nextScene = false;
	oTour.clearAllRuning();
	oTour.reset();
}
function resetTour()
{
	oTour.curScene = 0;
}
function setScene(n)
{
	oTour.curScene = n;
}
function startTour()
{
	oTour.reset();
	TourPlayEVENTonclick(0, 0);
	
}
