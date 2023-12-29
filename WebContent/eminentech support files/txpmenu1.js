var tpressedFontColor = "#AA0000";
var tpathPrefix_img = "images/";

var tlevelDX = 20;
var ttoggleMode = 1;

var texpanded = 0;
var tcloseExpanded   = 1;
var tcloseExpandedXP = 0;

var tblankImage      = "images/blank.gif";
var tmenuWidth       = 163;
var tmenuHeight      = 0;

var tabsolute        = 1;
var tleft            = 10;
var ttop             = 120;

var tfloatable       = 0;
var tfloatIterations = 10;

var tmoveable        = 0;
var tmoveImage       = "images/movepic.gif";
var tmoveColor       = "transparent";
var tmoveImageHeight = 12;

var tfontStyle       = "normal 8pt Tahoma";
var tfontColor       = ["#3F3D3D","#7E7C7C"];
var tfontDecoration  = ["none","underline"];

var titemBackColor   = ["#F0F1F5","#F0F1F5"];
var titemAlign       = "left";
var titemBackImage   = ["",""];
var titemCursor      = "pointer";
var titemHeight      = 22;
var titemTarget      = "_blank";

var ticonWidth       = 16;
var ticonHeight      = 15;
var ticonAlign       = "left";

var tmenuBackImage   = "";
var tmenuBackColor   = "";
var tmenuBorderColor = "#FFFFFF";
var tmenuBorderStyle = "solid";
var tmenuBorderWidth = 0;

var texpandBtn       =["expandbtn2.gif","expandbtn2.gif","collapsebtn2.gif"];
var texpandBtnW      = 9;
var texpandBtnH      = 9;
var texpandBtnAlign  = "left"

var tpoints       = 0;
var tpointsImage  = "";
var tpointsVImage = "";
var tpointsCImage = "";

// XP-Style Parameters
var tXPStyle = 1;
var tXPIterations = 10;                  // expand/collapse speed
var tXPTitleTopBackColor = "";
var tXPTitleBackColor    = "#AFB1C3";
var tXPTitleLeft    = "xptitleleft_s.gif";
var tXPTitleLeftWidth = 4;
var tXPExpandBtn    = ["xpexpand1_s.gif","xpexpand1_s.gif","xpcollapse1_s.gif","xpcollapse1_s.gif"];
var tXPTitleBackImg = "xptitle_s.gif";

var tXPBtnWidth  = 25;
var tXPBtnHeight = 23;

var tXPIconWidth  = 20;
var tXPIconHeight = 20;

var tXPFilter=1;

var tXPBorderWidth = 1;
var tXPBorderColor = '#FFFFFF';



var tstyles =
[
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#FFFFFF,#E6E6E6", "tfontDecoration=none,none"],
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#3F3D3D,#7E7C7C", "tfontDecoration=none,none"],
    ["tfontDecoration=none,none"],
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#444444,#5555FF"],
];

var tXPStyles =
[
    ["tXPTitleBackColor=#D9DAE2", "tXPExpandBtn=xpexpand2_s.gif,xpexpand3_s.gif,xpcollapse2_s.gif,xpcollapse3_s.gif", "tXPTitleBackImg=xptitle2_s.gif"]
];

var tmenuItems =
[
    
    ["+E-Tracker", "", "","","", "",,"1","0"],
    ["|My Issues", "/etracker/MyIssues.jsp", "myissue.gif", "", "", "Issues Created by me","basefrm"],
    ["|My Assignment", "/etracker/MyAssignment.jsp", "myassign.gif", "", "", "Issue Assigned to me","basefrm"],
    ["|Create Issue", "/etracker/createissuenew.jsp", "create.gif", "", "", "New Issue Creation","basefrm"],
    ["|Update Issue", "/etracker/UpdateIssue.jsp", "update.gif", "", "", "Updation of Issue","basefrm"],
    ["|Issue Summary", "/etracker/IssueSummary.jsp", "summary.gif", "", "", "Searching an Issue","basefrm"],
    ["|My Queries", "/etracker/MyQuery.jsp", "myquery.gif", "", "", "Your Saved Search","basefrm"],
    
];



apy_tmenuInit();
