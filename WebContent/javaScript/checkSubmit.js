/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

//This is to make sure that the form has been sumitted only once

function monitorSubmit() {
    document.getElementById('submit').value = 'Processing';
    document.getElementById('submit').disabled = true;
    document.getElementById('reset').disabled = true;
    return true;
}
function monitorTestcase() {
    document.getElementById('Update').value = 'Processing';
    document.getElementById('submit').disabled = true;
    document.getElementById('reset').disabled = true;
    return true;
}
function disableSubmit() {
    document.getElementById('submit').value = 'Processing';
    document.getElementById('submit').disabled = true;
    return true;
}
function disableMomSubmit() {
    document.getElementById('btnSubmit').value = 'Processing';
    document.getElementById('btnSubmit').disabled = true;
    return true;
}
function disableIssueSubmit() {
    document.getElementById('searchIssue').value = 'Processing';
    document.getElementById('searchIssue').disabled = true;
    return true;
}
function disableSearchSubmit() {
    document.getElementById('search').value = 'Processing';
    document.getElementById('search').disabled = true;
    return true;
}
function disableWRMSearchSubmit() {
    document.getElementById('wrmSearch').value = 'Processing';
    document.getElementById('wrmSearch').disabled = true;
    return true;
}

function disableTimesheetSubmit() {
    document.getElementById('timeSheet').value = 'Processing';
    document.getElementById('timeSheet').disabled = true;
    return true;
}
function leaveSubmit() {
    if(!(document.getElementById('submit1').value==null)){
        document.getElementById('submit1').value = 'Processing';
        document.getElementById('submit1').disabled = true;
    }
     if(!(document.getElementById('reset').value==null)){
            document.getElementById('reset').disabled = true;
     }
    return true;
}
function leaveCancelSubmit() {
    if(!(document.getElementById('submit1').value==null)){
        document.getElementById('submit1').value = 'Processing';
        document.getElementById('submit1').disabled = true;
    }
     
    return true;
}
function leaveRejectSubmit() {
    if(!(document.getElementById('submit1').value==null)){
        document.getElementById('submit1').value = 'Processing';
        document.getElementById('submit1').disabled = true;
         document.getElementById('reject').disabled = true;
    }

    return true;
}



