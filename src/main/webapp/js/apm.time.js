var hour = {
	value : 0,
	min : 0,
	max : 23,
	step : 1,
	btn_up_class : 'btn-info',
	btn_down_class : 'btn-info'
};
var hour2 = {
	value : 23,
	min : 0,
	max : 23,
	step : 1,
	btn_up_class : 'btn-info',
	btn_down_class : 'btn-info'
};
var second = {
	value : 0,
	min : 0,
	max : 59,
	step : 1,
	btn_up_class : 'btn-info',
	btn_down_class : 'btn-info'
};
var second2 = {
	value : 59,
	min : 0,
	max : 59,
	step : 1,
	btn_up_class : 'btn-info',
	btn_down_class : 'btn-info'
};

var msgs = $("#messageStartTime").val().split(":");
var msge = $("#messageEndTime").val().split(":");
var emls = $("#emailStartTime").val().split(":");
var emle = $("#emailEndTime").val().split(":");
var phns = $("#phoneStartTime").val().split(":");
var phne = $("#phoneEndTime").val().split(":");
var msh = 0,msm = 0,mss = 0,esh = 0,esm = 0,ess = 0,psh = 0,psm = 0,pss = 0;
var meh = 23,eeh = 23,peh = 23;
var mem = 59,mes = 59,eem = 59,ees = 59,pem = 59,pes = 59;
if (msgs != "" && msge != "") {
	msh = Number(msgs[0]);
	msm = Number(msgs[1]);
	mss = Number(msgs[2]);
	meh = Number(msge[0]);
	mem = Number(msge[1]);
	mes = Number(msge[2]);
}
if (emls != "" && emle != "") {
	esh = Number(emls[0]);
	esm = Number(emls[1]);
	ess = Number(emls[2]);
	eeh = Number(emle[0]);
	eem = Number(emle[1]);
	ees = Number(emle[2]);
}
if (phns != "" && phne != "") {
	psh = Number(phns[0]);
	psm = Number(phns[1]);
	pss = Number(phns[2]);
	peh = Number(phne[0]);
	pem = Number(phne[1]);
	pes = Number(phne[2]);
}

function setSendValue(){
	if ($("#message").prop('checked')) {
		$("#messageStartTime").val($("#msgBeginHour").val()+":"+ $("#msgBeginMin").val()+":"+ $("#msgBeginSec").val());
		$("#messageEndTime").val($("#msgEndHour").val()+":"+ $("#msgEndMin").val()+":"+ $("#msgEndSec").val());
		$("#sendMessage").val(1);
	}else{
		$("#messageStartTime").val("");
		$("#messageEndTime").val("");
		$("#sendMessage").val(0);
	}
	
	if ($("#email").prop('checked')) {
		$("#emailStartTime").val($("#emlBeginHour").val()+":"+ $("#emlBeginMin").val()+":"+ $("#emlBeginSec").val());
		$("#emailEndTime").val($("#emlEndHour").val()+":"+ $("#emlEndMin").val()+":"+ $("#emlEndSec").val());
		$("#sendEmail").val(1);
	}else{
		$("#emailStartTime").val("");
		$("#emailEndTime").val("");
		$("#sendEmail").val(0);
	}
	
	if ($("#phone").prop('checked')) {
		$("#phoneStartTime").val($("#phnBeginHour").val()+":"+ $("#phnBeginMin").val()+":"+ $("#phnBeginSec").val());
		$("#phoneEndTime").val($("#phnEndHour").val()+":"+ $("#phnEndMin").val()+":"+ $("#phnEndSec").val());
		$("#sendPhone").val(1);
	}else{
		$("#phoneStartTime").val("");
		$("#phoneEndTime").val("");
		$("#sendPhone").val(0);
	}
}

function setSendValueUpdate(){
	if ($("#message").prop('checked')) {
		$("#messageStartTime").val($("#msgBeginHourU").val()+":"+ $("#msgBeginMinU").val()+":"+ $("#msgBeginSecU").val());
		$("#messageEndTime").val($("#msgEndHourU").val()+":"+ $("#msgEndMinU").val()+":"+ $("#msgEndSecU").val());
		$("#sendMessage").val(1);
	}else{
		$("#messageStartTime").val("");
		$("#messageEndTime").val("");
		$("#sendMessage").val(0);
	}
	
	if ($("#email").prop('checked')) {
		$("#emailStartTime").val($("#emlBeginHourU").val()+":"+ $("#emlBeginMinU").val()+":"+ $("#emlBeginSecU").val());
		$("#emailEndTime").val($("#emlEndHourU").val()+":"+ $("#emlEndMinU").val()+":"+ $("#emlEndSecU").val());
		$("#sendEmail").val(1);
	}else{
		$("#emailStartTime").val("");
		$("#emailEndTime").val("");
		$("#sendEmail").val(0);
	}
	
	if ($("#phone").prop('checked')) {
		$("#phoneStartTime").val($("#phnBeginHourU").val()+":"+ $("#phnBeginMinU").val()+":"+ $("#phnBeginSecU").val());
		$("#phoneEndTime").val($("#phnEndHourU").val()+":"+ $("#phnEndMinU").val()+":"+ $("#phnEndSecU").val());
		$("#sendPhone").val(1);
	}else{
		$("#phoneStartTime").val("");
		$("#phoneEndTime").val("");
		$("#sendPhone").val(0);
	}
}

$('#msgBeginHour').ace_spinner(hour).on("change", function() {
});
$('#msgBeginMin').ace_spinner(second).on("change", function() {
});
$('#msgBeginSec').ace_spinner(second).on("change", function() {
});
$('#msgEndHour').ace_spinner(hour2).on("change", function() {
});
$('#msgEndMin').ace_spinner(second2).on("change", function() {
});
$('#msgEndSec').ace_spinner(second2).on("change", function() {
});
$('#emlBeginHour').ace_spinner(hour).on("change", function() {
});
$('#emlBeginMin').ace_spinner(second).on("change", function() {
});
$('#emlBeginSec').ace_spinner(second).on("change", function() {
});
$('#emlEndHour').ace_spinner(hour2).on("change", function() {
});
$('#emlEndMin').ace_spinner(second2).on("change", function() {
});
$('#emlEndSec').ace_spinner(second2).on("change", function() {
});
$('#phnBeginHour').ace_spinner(hour).on("change", function() {
});
$('#phnBeginMin').ace_spinner(second).on("change", function() {
});
$('#phnBeginSec').ace_spinner(second).on("change", function() {
});
$('#phnEndHour').ace_spinner(hour2).on("change", function() {
});
$('#phnEndMin').ace_spinner(second2).on("change", function() {
});
$('#phnEndSec').ace_spinner(second2).on("change", function() {
});


$('#msgBeginHourU').ace_spinner({value:msh,min:0,max:23,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#msgBeginMinU').ace_spinner({value:msm,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#msgBeginSecU').ace_spinner({value:mss,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#msgEndHourU').ace_spinner({value:meh,min:0,max:23,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#msgEndMinU').ace_spinner({value:mem,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#msgEndSecU').ace_spinner({value:mes,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#emlBeginHourU').ace_spinner({value:esh,min:0,max:23,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#emlBeginMinU').ace_spinner({value:esm,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#emlBeginSecU').ace_spinner({value:ess,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#emlEndHourU').ace_spinner({value:eeh,min:0,max:23,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#emlEndMinU').ace_spinner({value:eem,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#emlEndSecU').ace_spinner({value:ees,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#phnBeginHourU').ace_spinner({value:psh,min:0,max:23,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#phnBeginMinU').ace_spinner({value:psm,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#phnBeginSecU').ace_spinner({value:pss,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#phnEndHourU').ace_spinner({value:peh,min:0,max:23,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#phnEndMinU').ace_spinner({value:pem,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
$('#phnEndSecU').ace_spinner({value:pes,min:0,max:59,step:1,btn_up_class:'btn-info',btn_down_class:'btn-info'}).on("change", function(){
});
