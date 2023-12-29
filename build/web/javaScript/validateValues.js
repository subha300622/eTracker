  function trim(str)  {
  		while (str.charAt(str.length - 1)==" ")
    	str = str.substring(0, str.length - 1);
  		while (str.charAt(0)==" ")
    	str = str.substring(1, str.length);
  		return str;
	}

function isNumber(str)
{
	var pattern = "0123456789";
	var i = 0;
	do
    {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                {
					pos = 1;
       				break;
      			}
    			i++;
 	}
 	while (pos==1 && i<str.length)
        if (pos==0){
    		return false;
        }
        return true;

}

function fun(theForm)
{

    if (trim(theForm.unconfirmedp1s1.value)=='')
    {
            alert('Please enter the Unconfirmed P1 S1 Value');
            document.theForm.unconfirmedp1s1.value="";
            theForm.unconfirmedp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P1 S1 Value ');
		document.theForm.unconfirmedp1s1.value="";
        theForm.unconfirmedp1s1.focus();
        return false;
  	}

    if (trim(theForm.unconfirmedp1s2.value)=='')
    {
            alert('Please enter the Unconfirmed P1 S2 Value');
            document.theForm.unconfirmedp1s2.value="";
            theForm.unconfirmedp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P1 S2 Value ');
		document.theForm.unconfirmedp1s2.value="";
        theForm.unconfirmedp1s2.focus();
        return false;
  	}
    if (trim(theForm.unconfirmedp1s3.value)=='')
    {
            alert('Please enter the Unconfirmed P1 S3 Value');
            document.theForm.unconfirmedp1s3.value="";
            theForm.unconfirmedp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P1 S3 Value ');
		document.theForm.unconfirmedp1s3.value="";
        theForm.unconfirmedp1s3.focus();
        return false;
  	}
    if (trim(theForm.unconfirmedp1s4.value)=='')
    {
            alert('Please enter the Unconfirmed P1 S4 Value');
            document.theForm.unconfirmedp1s4.value="";
            theForm.unconfirmedp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P1 S4 Value ');
		document.theForm.unconfirmedp1s4.value="";
        theForm.unconfirmedp1s4.focus();
        return false;
  	}

     if (trim(theForm.unconfirmedp2s1.value)=='')
    {
            alert('Please enter the Unconfirmed P2 S1 Value');
            document.theForm.unconfirmedp2s1.value="";
            theForm.unconfirmedp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P2 S1 Value ');
		document.theForm.unconfirmedp2s1.value="";
        theForm.unconfirmedp2s1.focus();
        return false;
  	}
    if (trim(theForm.unconfirmedp2s2.value)=='')
    {
            alert('Please enter the Unconfirmed P2 S2 Value');
            document.theForm.unconfirmedp2s2.value="";
            theForm.unconfirmedp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P2 S2 Value ');
		document.theForm.unconfirmedp2s2.value="";
        theForm.unconfirmedp2s2.focus();
        return false;
  	}
    if (trim(theForm.unconfirmedp2s3.value)=='')
    {
            alert('Please enter the Unconfirmed P2 S3 Value');
            document.theForm.unconfirmedp2s3.value="";
            theForm.unconfirmedp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P2 S3 Value ');
		document.theForm.unconfirmedp2s3.value="";
        theForm.unconfirmedp2s3.focus();
        return false;
  	}
    if (trim(theForm.unconfirmedp2s4.value)=='')
    {
            alert('Please enter the Unconfirmed P2 S4 Value');
            document.theForm.unconfirmedp2s4.value="";
            theForm.unconfirmedp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P2 S4 Value ');
		document.theForm.unconfirmedp2s4.value="";
        theForm.unconfirmedp2s4.focus();
        return false;
  	}

     if (trim(theForm.unconfirmedp3s1.value)=='')
    {
            alert('Please enter the Unconfirmed P3 S1 Value');
            document.theForm.unconfirmedp3s1.value="";
            theForm.unconfirmedp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P3 S1 Value ');
		document.theForm.unconfirmedp3s1.value="";
        theForm.unconfirmedp3s1.focus();
        return false;
  	}

    if (trim(theForm.unconfirmedp3s2.value)=='')
    {
            alert('Please enter the Unconfirmed P3 S2 Value');
            document.theForm.unconfirmedp3s2.value="";
            theForm.unconfirmedp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P3 S2 Value ');
		document.theForm.unconfirmedp3s2.value="";
        theForm.unconfirmedp3s2.focus();
        return false;
  	}
    if (trim(theForm.unconfirmedp3s3.value)=='')
    {
            alert('Please enter the Unconfirmed P3 S3 Value');
            document.theForm.unconfirmedp3s3.value="";
            theForm.unconfirmedp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P3 S3 Value ');
		document.theForm.unconfirmedp3s3.value="";
        theForm.unconfirmedp3s3.focus();
        return false;
  	}
    if (trim(theForm.unconfirmedp3s4.value)=='')
    {
            alert('Please enter the Unconfirmed P3 S4 Value');
            document.theForm.unconfirmedp3s4.value="";
            theForm.unconfirmedp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P3 S4 Value ');
		document.theForm.unconfirmedp3s4.value="";
        theForm.unconfirmedp3s4.focus();
        return false;
  	}

     if (trim(theForm.unconfirmedp4s1.value)=='')
    {
            alert('Please enter the Unconfirmed P4 S1 Value');
            document.theForm.unconfirmedp4s1.value="";
            theForm.unconfirmedp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P4 S1 Value ');
		document.theForm.unconfirmedp4s1.value="";
        theForm.unconfirmedp4s1.focus();
        return false;
  	}

    if (trim(theForm.unconfirmedp4s2.value)=='')
    {
            alert('Please enter the Unconfirmed P4 S2 Value');
            document.theForm.unconfirmedp4s2.value="";
            theForm.unconfirmedp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P4 S2 Value ');
		document.theForm.unconfirmedp4s2.value="";
        theForm.unconfirmedp4s2.focus();
        return false;
  	}
    if (trim(theForm.unconfirmedp4s3.value)=='')
    {
            alert('Please enter the Unconfirmed P4 S3 Value');
            document.theForm.unconfirmedp4s3.value="";
            theForm.unconfirmedp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P4 S3 Value ');
		document.theForm.unconfirmedp4s3.value="";
        theForm.unconfirmedp4s3.focus();
        return false;
  	}
    if (trim(theForm.unconfirmedp4s4.value)=='')
    {
            alert('Please enter the Unconfirmed P4 S4 Value');
            document.theForm.unconfirmedp4s4.value="";
            theForm.unconfirmedp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.unconfirmedp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Unconfirmed P4 S4 Value ');
		document.theForm.unconfirmedp4s4.value="";
        theForm.unconfirmedp4s4.focus();
        return false;
  	}
    if (trim(theForm.rejectedp1s1.value)=='')
    {
            alert('Please enter the Rejected P1 S1 Value');
            document.theForm.rejectedp1s1.value="";
            theForm.rejectedp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P1 S1 Value ');
		document.theForm.rejectedp1s1.value="";
        theForm.rejectedp1s1.focus();
        return false;
  	}

    if (trim(theForm.rejectedp1s2.value)=='')
    {
            alert('Please enter the Rejected P1 S2 Value');
            document.theForm.rejectedp1s2.value="";
            theForm.rejectedp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P1 S2 Value ');
		document.theForm.rejectedp1s2.value="";
        theForm.rejectedp1s2.focus();
        return false;
  	}
    if (trim(theForm.rejectedp1s3.value)=='')
    {
            alert('Please enter the Rejected P1 S3 Value');
            document.theForm.rejectedp1s3.value="";
            theForm.rejectedp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P1 S3 Value ');
		document.theForm.rejectedp1s3.value="";
        theForm.rejectedp1s3.focus();
        return false;
  	}
    if (trim(theForm.rejectedp1s4.value)=='')
    {
            alert('Please enter the Rejected P1 S4 Value');
            document.theForm.rejectedp1s4.value="";
            theForm.rejectedp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P1 S4 Value ');
		document.theForm.rejectedp1s4.value="";
        theForm.rejectedp1s4.focus();
        return false;
  	}

     if (trim(theForm.rejectedp2s1.value)=='')
    {
            alert('Please enter the Rejected P2 S1 Value');
            document.theForm.rejectedp2s1.value="";
            theForm.rejectedp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P2 S1 Value ');
		document.theForm.rejectedp2s1.value="";
        theForm.rejectedp2s1.focus();
        return false;
  	}

    if (trim(theForm.rejectedp2s2.value)=='')
    {
            alert('Please enter the Rejected P2 S2 Value');
            document.theForm.rejectedp2s2.value="";
            theForm.rejectedp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P2 S2 Value ');
		document.theForm.rejectedp2s2.value="";
        theForm.rejectedp2s2.focus();
        return false;
  	}
    if (trim(theForm.rejectedp2s3.value)=='')
    {
            alert('Please enter the Rejected P2 S3 Value');
            document.theForm.rejectedp2s3.value="";
            theForm.rejectedp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P2 S3 Value ');
		document.theForm.rejectedp2s3.value="";
        theForm.rejectedp2s3.focus();
        return false;
  	}
    if (trim(theForm.rejectedp2s4.value)=='')
    {
            alert('Please enter the Rejected P2 S4 Value');
            document.theForm.rejectedp2s4.value="";
            theForm.rejectedp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P2 S4 Value ');
		document.theForm.rejectedp2s4.value="";
        theForm.rejectedp2s4.focus();
        return false;
  	}

     if (trim(theForm.rejectedp3s1.value)=='')
    {
            alert('Please enter the Rejected P3 S1 Value');
            document.theForm.rejectedp3s1.value="";
            theForm.rejectedp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P3 S1 Value ');
		document.theForm.rejectedp3s1.value="";
        theForm.rejectedp3s1.focus();
        return false;
  	}

    if (trim(theForm.rejectedp3s2.value)=='')
    {
            alert('Please enter the Rejected P3 S2 Value');
            document.theForm.rejectedp3s2.value="";
            theForm.rejectedp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P3 S2 Value ');
		document.theForm.rejectedp3s2.value="";
        theForm.rejectedp3s2.focus();
        return false;
  	}
    if (trim(theForm.rejectedp3s3.value)=='')
    {
            alert('Please enter the Rejected P3 S3 Value');
            document.theForm.rejectedp3s3.value="";
            theForm.rejectedp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P3 S3 Value ');
		document.theForm.rejectedp3s3.value="";
        theForm.rejectedp3s3.focus();
        return false;
  	}
    if (trim(theForm.rejectedp3s4.value)=='')
    {
            alert('Please enter the Rejected P3 S4 Value');
            document.theForm.rejectedp3s4.value="";
            theForm.rejectedp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P3 S4 Value ');
		document.theForm.rejectedp3s4.value="";
        theForm.rejectedp3s4.focus();
        return false;
  	}

     if (trim(theForm.rejectedp4s1.value)=='')
    {
            alert('Please enter the Rejected P4 S1 Value');
            document.theForm.rejectedp4s1.value="";
            theForm.rejectedp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P4 S1 Value ');
		document.theForm.rejectedp4s1.value="";
        theForm.rejectedp4s1.focus();
        return false;
  	}

    if (trim(theForm.rejectedp4s2.value)=='')
    {
            alert('Please enter the Rejected P4 S2 Value');
            document.theForm.rejectedp4s2.value="";
            theForm.rejectedp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P4 S2 Value ');
		document.theForm.rejectedp4s2.value="";
        theForm.rejectedp4s2.focus();
        return false;
  	}
    if (trim(theForm.rejectedp4s3.value)=='')
    {
            alert('Please enter the Rejected P4 S3 Value');
            document.theForm.rejectedp4s3.value="";
            theForm.rejectedp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P4 S3 Value ');
		document.theForm.rejectedp4s3.value="";
        theForm.rejectedp4s3.focus();
        return false;
  	}
    if (trim(theForm.rejectedp4s4.value)=='')
    {
            alert('Please enter the Rejected P4 S4 Value');
            document.theForm.rejectedp4s4.value="";
            theForm.rejectedp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.rejectedp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Rejected P4 S4 Value ');
		document.theForm.rejectedp4s4.value="";
        theForm.rejectedp4s4.focus();
        return false;
  	}
    if (trim(theForm.duplicatep1s1.value)=='')
    {
            alert('Please enter the Duplicate P1 S1 Value');
            document.theForm.duplicatep1s1.value="";
            theForm.duplicatep1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep1s1.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P1 S1 Value ');
		document.theForm.duplicatep1s1.value="";
        theForm.duplicatep1s1.focus();
        return false;
  	}

    if (trim(theForm.duplicatep1s2.value)=='')
    {
            alert('Please enter the Duplicate P1 S2 Value');
            document.theForm.duplicatep1s2.value="";
            theForm.duplicatep1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep1s2.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P1 S2 Value ');
		document.theForm.duplicatep1s2.value="";
        theForm.duplicatep1s2.focus();
        return false;
  	}
    if (trim(theForm.duplicatep1s3.value)=='')
    {
            alert('Please enter the Duplicate P1 S3 Value');
            document.theForm.duplicatep1s3.value="";
            theForm.duplicatep1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep1s3.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P1 S3 Value ');
		document.theForm.duplicatep1s3.value="";
        theForm.duplicatep1s3.focus();
        return false;
  	}
    if (trim(theForm.duplicatep1s4.value)=='')
    {
            alert('Please enter the Duplicate P1 S4 Value');
            document.theForm.duplicatep1s4.value="";
            theForm.duplicatep1s4.focus();
            return false;
  	}

	if (!isNumber(trim(theForm.duplicatep1s4.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P1 S4 Value ');
		document.theForm.duplicatep1s4.value="";
        theForm.duplicatep1s4.focus();
        return false;
  	}

     if (trim(theForm.duplicatep2s1.value)=='')
    {
            alert('Please enter the Duplicate P2 S1 Value');
            document.theForm.duplicatep2s1.value="";
            theForm.duplicatep2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep2s1.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P2 S1 Value ');
		document.theForm.duplicatep2s1.value="";
        theForm.duplicatep2s1.focus();
        return false;
  	}

    if (trim(theForm.duplicatep2s2.value)=='')
    {
            alert('Please enter the Duplicate P2 S2 Value');
            document.theForm.duplicatep2s2.value="";
            theForm.duplicatep2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep2s2.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P2 S2 Value ');
		document.theForm.duplicatep2s2.value="";
        theForm.duplicatep2s2.focus();
        return false;
  	}
    if (trim(theForm.duplicatep2s3.value)=='')
    {
            alert('Please enter the Duplicate P2 S3 Value');
            document.theForm.duplicatep2s3.value="";
            theForm.duplicatep2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep2s3.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P2 S3 Value ');
		document.theForm.duplicatep2s3.value="";
        theForm.duplicatep2s3.focus();
        return false;
  	}
    if (trim(theForm.duplicatep2s4.value)=='')
    {
            alert('Please enter the Duplicate P2 S4 Value');
            document.theForm.duplicatep2s4.value="";
            theForm.duplicatep2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep2s4.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P2 S4 Value ');
		document.theForm.duplicatep2s4.value="";
        theForm.duplicatep2s4.focus();
        return false;
  	}

     if (trim(theForm.duplicatep3s1.value)=='')
    {
            alert('Please enter the Duplicate P3 S1 Value');
            document.theForm.duplicatep3s1.value="";
            theForm.duplicatep3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep3s1.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P3 S1 Value ');
		document.theForm.duplicatep3s1.value="";
        theForm.duplicatep3s1.focus();
        return false;
  	}

    if (trim(theForm.duplicatep3s2.value)=='')
    {
            alert('Please enter the Duplicate P3 S2 Value');
            document.theForm.duplicatep3s2.value="";
            theForm.duplicatep3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep3s2.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P3 S2 Value ');
		document.theForm.duplicatep3s2.value="";
        theForm.duplicatep3s2.focus();
        return false;
  	}
    if (trim(theForm.duplicatep3s3.value)=='')
    {
            alert('Please enter the Duplicate P3 S3 Value');
            document.theForm.duplicatep3s3.value="";
            theForm.duplicatep3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep3s3.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P3 S3 Value ');
		document.theForm.duplicatep3s3.value="";
        theForm.duplicatep3s3.focus();
        return false;
  	}
    if (trim(theForm.duplicatep3s4.value)=='')
    {
            alert('Please enter the Duplicate P3 S4 Value');
            document.theForm.duplicatep3s4.value="";
            theForm.duplicatep3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep3s4.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P3 S4 Value ');
		document.theForm.duplicatep3s4.value="";
        theForm.duplicatep3s4.focus();
        return false;
  	}

     if (trim(theForm.duplicatep4s1.value)=='')
    {
            alert('Please enter the Duplicate P4 S1 Value');
            document.theForm.duplicatep4s1.value="";
            theForm.duplicatep4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep4s1.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P4 S1 Value ');
		document.theForm.duplicatep4s1.value="";
        theForm.duplicatep4s1.focus();
        return false;
  	}

    if (trim(theForm.duplicatep4s2.value)=='')
    {
            alert('Please enter the Duplicate P4 S2 Value');
            document.theForm.duplicatep4s2.value="";
            theForm.duplicatep4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep4s2.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P4 S2 Value ');
		document.theForm.duplicatep4s2.value="";
        theForm.duplicatep4s2.focus();
        return false;
  	}
    if (trim(theForm.duplicatep4s3.value)=='')
    {
            alert('Please enter the Duplicate P4 S3 Value');
            document.theForm.duplicatep4s3.value="";
            theForm.duplicatep4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep4s3.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P4 S3 Value ');
		document.theForm.duplicatep4s3.value="";
        theForm.duplicatep4s3.focus();
        return false;
  	}
    if (trim(theForm.duplicatep4s4.value)=='')
    {
            alert('Please enter the Duplicate P4 S4 Value');
            document.theForm.duplicatep4s4.value="";
            theForm.duplicatep4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.duplicatep4s4.value)))
        {
   		alert('Please enter the Numericals only in the Duplicate P4 S4 Value ');
		document.theForm.duplicatep4s4.value="";
        theForm.duplicatep4s4.focus();
        return false;
  	}
     if (trim(theForm.investigationp1s1.value)=='')
    {
            alert('Please enter the Investigation P1 S1 Value');
            document.theForm.investigationp1s1.value="";
            theForm.investigationp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P1 S1 Value ');
		document.theForm.investigationp1s1.value="";
        theForm.investigationp1s1.focus();
        return false;
  	}

    if (trim(theForm.investigationp1s2.value)=='')
    {
            alert('Please enter the Investigation P1 S2 Value');
            document.theForm.investigationp1s2.value="";
            theForm.investigationp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P1 S2 Value ');
		document.theForm.investigationp1s2.value="";
        theForm.investigationp1s2.focus();
        return false;
  	}
    if (trim(theForm.investigationp1s3.value)=='')
    {
            alert('Please enter the Investigation P1 S3 Value');
            document.theForm.investigationp1s3.value="";
            theForm.investigationp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P1 S3 Value ');
		document.theForm.investigationp1s3.value="";
        theForm.investigationp1s3.focus();
        return false;
  	}
    if (trim(theForm.investigationp1s4.value)=='')
    {
            alert('Please enter the Investigation P1 S4 Value');
            document.theForm.investigationp1s4.value="";
            theForm.investigationp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P1 S4 Value ');
		document.theForm.investigationp1s4.value="";
        theForm.investigationp1s4.focus();
        return false;
  	}

     if (trim(theForm.investigationp2s1.value)=='')
    {
            alert('Please enter the Investigation P2 S1 Value');
            document.theForm.investigationp2s1.value="";
            theForm.investigationp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P2 S1 Value ');
		document.theForm.investigationp2s1.value="";
        theForm.investigationp2s1.focus();
        return false;
  	}

    if (trim(theForm.investigationp2s2.value)=='')
    {
            alert('Please enter the Investigation P2 S2 Value');
            document.theForm.investigationp2s2.value="";
            theForm.investigationp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P2 S2 Value ');
		document.theForm.investigationp2s2.value="";
        theForm.investigationp2s2.focus();
        return false;
  	}
    if (trim(theForm.investigationp2s3.value)=='')
    {
            alert('Please enter the Investigation P2 S3 Value');
            document.theForm.investigationp2s3.value="";
            theForm.investigationp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P2 S3 Value ');
		document.theForm.investigationp2s3.value="";
        theForm.investigationp2s3.focus();
        return false;
  	}
    if (trim(theForm.investigationp2s4.value)=='')
    {
            alert('Please enter the Investigation P2 S4 Value');
            document.theForm.investigationp2s4.value="";
            theForm.investigationp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P2 S4 Value ');
		document.theForm.investigationp2s4.value="";
        theForm.investigationp2s4.focus();
        return false;
  	}

     if (trim(theForm.investigationp3s1.value)=='')
    {
            alert('Please enter the Investigation P3 S1 Value');
            document.theForm.investigationp3s1.value="";
            theForm.investigationp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P3 S1 Value ');
		document.theForm.investigationp3s1.value="";
        theForm.investigationp3s1.focus();
        return false;
  	}

    if (trim(theForm.investigationp3s2.value)=='')
    {
            alert('Please enter the Investigation P3 S2 Value');
            document.theForm.investigationp3s2.value="";
            theForm.investigationp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P3 S2 Value ');
		document.theForm.investigationp3s2.value="";
        theForm.investigationp3s2.focus();
        return false;
  	}
    if (trim(theForm.investigationp3s3.value)=='')
    {
            alert('Please enter the Investigation P3 S3 Value');
            document.theForm.investigationp3s3.value="";
            theForm.investigationp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P3 S3 Value ');
		document.theForm.investigationp3s3.value="";
        theForm.investigationp3s3.focus();
        return false;
  	}
    if (trim(theForm.investigationp3s4.value)=='')
    {
            alert('Please enter the Investigation P3 S4 Value');
            document.theForm.investigationp3s4.value="";
            theForm.investigationp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P3 S4 Value ');
		document.theForm.investigationp3s4.value="";
        theForm.investigationp3s4.focus();
        return false;
  	}

     if (trim(theForm.investigationp4s1.value)=='')
    {
            alert('Please enter the Investigation P4 S1 Value');
            document.theForm.investigationp4s1.value="";
            theForm.investigationp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P4 S1 Value ');
		document.theForm.investigationp4s1.value="";
        theForm.investigationp4s1.focus();
        return false;
  	}

    if (trim(theForm.investigationp4s2.value)=='')
    {
            alert('Please enter the Investigation P4 S2 Value');
            document.theForm.investigationp4s2.value="";
            theForm.investigationp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P4 S2 Value ');
		document.theForm.investigationp4s2.value="";
        theForm.investigationp4s2.focus();
        return false;
  	}
    if (trim(theForm.investigationp4s3.value)=='')
    {
            alert('Please enter the Investigation P4 S3 Value');
            document.theForm.investigationp4s3.value="";
            theForm.investigationp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P4 S3 Value ');
		document.theForm.investigationp4s3.value="";
        theForm.investigationp4s3.focus();
        return false;
  	}
    if (trim(theForm.investigationp4s4.value)=='')
    {
            alert('Please enter the Investigation P4 S4 Value');
            document.theForm.investigationp4s4.value="";
            theForm.investigationp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.investigationp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Investigation P4 S4 Value ');
		document.theForm.investigationp4s4.value="";
        theForm.investigationp4s4.focus();
        return false;
  	}
  if (trim(theForm.confirmedp1s1.value)=='')
    {
            alert('Please enter the Confirmed P1 S1 Value');
            document.theForm.confirmedp1s1.value="";
            theForm.confirmedp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P1 S1 Value ');
		document.theForm.confirmedp1s1.value="";
        theForm.confirmedp1s1.focus();
        return false;
  	}

    if (trim(theForm.confirmedp1s2.value)=='')
    {
            alert('Please enter the Confirmed P1 S2 Value');
            document.theForm.confirmedp1s2.value="";
            theForm.confirmedp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P1 S2 Value ');
		document.theForm.confirmedp1s2.value="";
        theForm.confirmedp1s2.focus();
        return false;
  	}
    if (trim(theForm.confirmedp1s3.value)=='')
    {
            alert('Please enter the Confirmed P1 S3 Value');
            document.theForm.confirmedp1s3.value="";
            theForm.confirmedp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P1 S3 Value ');
		document.theForm.confirmedp1s3.value="";
        theForm.confirmedp1s3.focus();
        return false;
  	}
    if (trim(theForm.confirmedp1s4.value)=='')
    {
            alert('Please enter the Confirmed P1 S4 Value');
            document.theForm.confirmedp1s4.value="";
            theForm.confirmedp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P1 S4 Value ');
		document.theForm.confirmedp1s4.value="";
        theForm.confirmedp1s4.focus();
        return false;
  	}

     if (trim(theForm.confirmedp2s1.value)=='')
    {
            alert('Please enter the Confirmed P2 S1 Value');
            document.theForm.confirmedp2s1.value="";
            theForm.confirmedp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P2 S1 Value ');
		document.theForm.confirmedp2s1.value="";
        theForm.confirmedp2s1.focus();
        return false;
  	}

    if (trim(theForm.confirmedp2s2.value)=='')
    {
            alert('Please enter the Confirmed P2 S2 Value');
            document.theForm.confirmedp2s2.value="";
            theForm.confirmedp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P2 S2 Value ');
		document.theForm.confirmedp2s2.value="";
        theForm.confirmedp2s2.focus();
        return false;
  	}
    if (trim(theForm.confirmedp2s3.value)=='')
    {
            alert('Please enter the Confirmed P2 S3 Value');
            document.theForm.confirmedp2s3.value="";
            theForm.confirmedp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P2 S3 Value ');
		document.theForm.confirmedp2s3.value="";
        theForm.confirmedp2s3.focus();
        return false;
  	}
    if (trim(theForm.confirmedp2s4.value)=='')
    {
            alert('Please enter the Confirmed P2 S4 Value');
            document.theForm.confirmedp2s4.value="";
            theForm.confirmedp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P2 S4 Value ');
		document.theForm.confirmedp2s4.value="";
        theForm.confirmedp2s4.focus();
        return false;
  	}
    if (trim(theForm.confirmedp3s1.value)=='')
    {
            alert('Please enter the Confirmed P3 S1 Value');
            document.theForm.confirmedp3s1.value="";
            theForm.confirmedp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P3 S1 Value ');
		document.theForm.confirmedp3s1.value="";
        theForm.confirmedp3s1.focus();
        return false;
  	}
    if (trim(theForm.confirmedp3s2.value)=='')
    {
            alert('Please enter the Confirmed P3 S2 Value');
            document.theForm.confirmedp3s2.value="";
            theForm.confirmedp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P3 S2 Value ');
		document.theForm.confirmedp3s2.value="";
        theForm.confirmedp3s2.focus();
        return false;
  	}
    if (trim(theForm.confirmedp3s3.value)=='')
    {
            alert('Please enter the Confirmed P3 S3 Value');
            document.theForm.confirmedp3s3.value="";
            theForm.confirmedp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P3 S3 Value ');
		document.theForm.confirmedp3s3.value="";
        theForm.confirmedp3s3.focus();
        return false;
  	}
    if (trim(theForm.confirmedp3s4.value)=='')
    {
            alert('Please enter the Confirmed P3 S4 Value');
            document.theForm.confirmedp3s4.value="";
            theForm.confirmedp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P3 S4 Value ');
		document.theForm.confirmedp3s4.value="";
        theForm.confirmedp3s4.focus();
        return false;
  	}

     if (trim(theForm.confirmedp4s1.value)=='')
    {
            alert('Please enter the Confirmed P4 S1 Value');
            document.theForm.confirmedp4s1.value="";
            theForm.confirmedp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P4 S1 Value ');
		document.theForm.confirmedp4s1.value="";
        theForm.confirmedp4s1.focus();
        return false;
  	}

    if (trim(theForm.confirmedp4s2.value)=='')
    {
            alert('Please enter the Confirmed P4 S2 Value');
            document.theForm.confirmedp4s2.value="";
            theForm.confirmedp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P4 S2 Value ');
		document.theForm.confirmedp4s2.value="";
        theForm.confirmedp4s2.focus();
        return false;
  	}
    if (trim(theForm.confirmedp4s3.value)=='')
    {
            alert('Please enter the Confirmed P4 S3 Value');
            document.theForm.confirmedp4s3.value="";
            theForm.confirmedp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P4 S3 Value ');
		document.theForm.confirmedp4s3.value="";
        theForm.confirmedp4s3.focus();
        return false;
  	}
    if (trim(theForm.confirmedp4s4.value)=='')
    {
            alert('Please enter the Confirmed P4 S4 Value');
            document.theForm.confirmedp4s4.value="";
            theForm.confirmedp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.confirmedp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Confirmed P4 S4 Value ');
		document.theForm.confirmedp4s4.value="";
        theForm.confirmedp4s4.focus();
        return false;
  	}
    if (trim(theForm.developmentp1s1.value)=='')
    {
            alert('Please enter the Development P1 S1 Value');
            document.theForm.developmentp1s1.value="";
            theForm.developmentp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Development P1 S1 Value ');
		document.theForm.developmentp1s1.value="";
        theForm.developmentp1s1.focus();
        return false;
  	}

    if (trim(theForm.developmentp1s2.value)=='')
    {
            alert('Please enter the Development P1 S2 Value');
            document.theForm.developmentp1s2.value="";
            theForm.developmentp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Development P1 S2 Value ');
		document.theForm.developmentp1s2.value="";
        theForm.developmentp1s2.focus();
        return false;
  	}
    if (trim(theForm.developmentp1s3.value)=='')
    {
            alert('Please enter the Development P1 S3 Value');
            document.theForm.developmentp1s3.value="";
            theForm.developmentp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Development P1 S3 Value ');
		document.theForm.developmentp1s3.value="";
        theForm.developmentp1s3.focus();
        return false;
  	}
    if (trim(theForm.developmentp1s4.value)=='')
    {
            alert('Please enter the Development P1 S4 Value');
            document.theForm.developmentp1s4.value="";
            theForm.developmentp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Development P1 S4 Value ');
		document.theForm.developmentp1s4.value="";
        theForm.developmentp1s4.focus();
        return false;
  	}

     if (trim(theForm.developmentp2s1.value)=='')
    {
            alert('Please enter the Development P2 S1 Value');
            document.theForm.developmentp2s1.value="";
            theForm.developmentp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Development P2 S1 Value ');
		document.theForm.developmentp2s1.value="";
        theForm.developmentp2s1.focus();
        return false;
  	}

    if (trim(theForm.developmentp2s2.value)=='')
    {
            alert('Please enter the Development P2 S2 Value');
            document.theForm.developmentp2s2.value="";
            theForm.developmentp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Development P2 S2 Value ');
		document.theForm.developmentp2s2.value="";
        theForm.developmentp2s2.focus();
        return false;
  	}
    if (trim(theForm.developmentp2s3.value)=='')
    {
            alert('Please enter the Development P2 S3 Value');
            document.theForm.developmentp2s3.value="";
            theForm.developmentp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Development P2 S3 Value ');
		document.theForm.developmentp2s3.value="";
        theForm.developmentp2s3.focus();
        return false;
  	}
    if (trim(theForm.developmentp2s4.value)=='')
    {
            alert('Please enter the Development P2 S4 Value');
            document.theForm.developmentp2s4.value="";
            theForm.developmentp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Development P2 S4 Value ');
		document.theForm.developmentp2s4.value="";
        theForm.developmentp2s4.focus();
        return false;
  	}

     if (trim(theForm.developmentp3s1.value)=='')
    {
            alert('Please enter the Development P3 S1 Value');
            document.theForm.developmentp3s1.value="";
            theForm.developmentp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Development P3 S1 Value ');
		document.theForm.developmentp3s1.value="";
        theForm.developmentp3s1.focus();
        return false;
  	}

    if (trim(theForm.developmentp3s2.value)=='')
    {
            alert('Please enter the Development P3 S2 Value');
            document.theForm.developmentp3s2.value="";
            theForm.developmentp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Development P3 S2 Value ');
		document.theForm.developmentp3s2.value="";
        theForm.developmentp3s2.focus();
        return false;
  	}
    if (trim(theForm.developmentp3s3.value)=='')
    {
            alert('Please enter the Development P3 S3 Value');
            document.theForm.developmentp3s3.value="";
            theForm.developmentp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Development P3 S3 Value ');
		document.theForm.developmentp3s3.value="";
        theForm.developmentp3s3.focus();
        return false;
  	}
    if (trim(theForm.developmentp3s4.value)=='')
    {
            alert('Please enter the Development P3 S4 Value');
            document.theForm.developmentp3s4.value="";
            theForm.developmentp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Development P3 S4 Value ');
		document.theForm.developmentp3s4.value="";
        theForm.developmentp3s4.focus();
        return false;
  	}

     if (trim(theForm.developmentp4s1.value)=='')
    {
            alert('Please enter the Development P4 S1 Value');
            document.theForm.developmentp4s1.value="";
            theForm.developmentp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Development P4 S1 Value ');
		document.theForm.developmentp4s1.value="";
        theForm.developmentp4s1.focus();
        return false;
  	}

    if (trim(theForm.developmentp4s2.value)=='')
    {
            alert('Please enter the Development P4 S2 Value');
            document.theForm.developmentp4s2.value="";
            theForm.developmentp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Development P4 S2 Value ');
		document.theForm.developmentp4s2.value="";
        theForm.developmentp4s2.focus();
        return false;
  	}
    if (trim(theForm.developmentp4s3.value)=='')
    {
            alert('Please enter the Development P4 S3 Value');
            document.theForm.developmentp4s3.value="";
            theForm.developmentp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Development P4 S3 Value ');
		document.theForm.developmentp4s3.value="";
        theForm.developmentp4s3.focus();
        return false;
  	}
    if (trim(theForm.developmentp4s4.value)=='')
    {
            alert('Please enter the Development P4 S4 Value');
            document.theForm.developmentp4s4.value="";
            theForm.developmentp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.developmentp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Development P4 S4 Value ');
		document.theForm.developmentp4s4.value="";
        theForm.developmentp4s4.focus();
        return false;
  	}


    if (trim(theForm.workinprogressp1s1.value)=='')
    {
            alert('Please enter the Workinprogress P1 S1 Value');
            document.theForm.workinprogressp1s1.value="";
            theForm.workinprogressp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P1 S1 Value ');
		document.theForm.workinprogressp1s1.value="";
        theForm.workinprogressp1s1.focus();
        return false;
  	}

    if (trim(theForm.workinprogressp1s2.value)=='')
    {
            alert('Please enter the Workinprogress P1 S2 Value');
            document.theForm.workinprogressp1s2.value="";
            theForm.workinprogressp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P1 S2 Value ');
		document.theForm.workinprogressp1s2.value="";
        theForm.workinprogressp1s2.focus();
        return false;
  	}
    if (trim(theForm.workinprogressp1s3.value)=='')
    {
            alert('Please enter the Workinprogress P1 S3 Value');
            document.theForm.workinprogressp1s3.value="";
            theForm.workinprogressp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P1 S3 Value ');
		document.theForm.workinprogressp1s3.value="";
        theForm.workinprogressp1s3.focus();
        return false;
  	}
    if (trim(theForm.workinprogressp1s4.value)=='')
    {
            alert('Please enter the Workinprogress P1 S4 Value');
            document.theForm.workinprogressp1s4.value="";
            theForm.workinprogressp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P1 S4 Value ');
		document.theForm.workinprogressp1s4.value="";
        theForm.workinprogressp1s4.focus();
        return false;
  	}

     if (trim(theForm.workinprogressp2s1.value)=='')
    {
            alert('Please enter the Workinprogress P2 S1 Value');
            document.theForm.workinprogressp2s1.value="";
            theForm.workinprogressp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P2 S1 Value ');
		document.theForm.workinprogressp2s1.value="";
        theForm.workinprogressp2s1.focus();
        return false;
  	}

    if (trim(theForm.workinprogressp2s2.value)=='')
    {
            alert('Please enter the Workinprogress P2 S2 Value');
            document.theForm.workinprogressp2s2.value="";
            theForm.workinprogressp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P2 S2 Value ');
		document.theForm.workinprogressp2s2.value="";
        theForm.workinprogressp2s2.focus();
        return false;
  	}
    if (trim(theForm.workinprogressp2s3.value)=='')
    {
            alert('Please enter the Workinprogress P2 S3 Value');
            document.theForm.workinprogressp2s3.value="";
            theForm.workinprogressp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P2 S3 Value ');
		document.theForm.workinprogressp2s3.value="";
        theForm.workinprogressp2s3.focus();
        return false;
  	}
    if (trim(theForm.workinprogressp2s4.value)=='')
    {
            alert('Please enter the Workinprogress P2 S4 Value');
            document.theForm.workinprogressp2s4.value="";
            theForm.workinprogressp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P2 S4 Value ');
		document.theForm.workinprogressp2s4.value="";
        theForm.workinprogressp2s4.focus();
        return false;
  	}

     if (trim(theForm.workinprogressp3s1.value)=='')
    {
            alert('Please enter the Workinprogress P3 S1 Value');
            document.theForm.workinprogressp3s1.value="";
            theForm.workinprogressp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P3 S1 Value ');
		document.theForm.workinprogressp3s1.value="";
        theForm.workinprogressp3s1.focus();
        return false;
  	}

    if (trim(theForm.workinprogressp3s2.value)=='')
    {
            alert('Please enter the Workinprogress P3 S2 Value');
            document.theForm.workinprogressp3s2.value="";
            theForm.workinprogressp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P3 S2 Value ');
		document.theForm.workinprogressp3s2.value="";
        theForm.workinprogressp3s2.focus();
        return false;
  	}
    if (trim(theForm.workinprogressp3s3.value)=='')
    {
            alert('Please enter the Workinprogress P3 S3 Value');
            document.theForm.workinprogressp3s3.value="";
            theForm.workinprogressp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P3 S3 Value ');
		document.theForm.workinprogressp3s3.value="";
        theForm.workinprogressp3s3.focus();
        return false;
  	}
    if (trim(theForm.workinprogressp3s4.value)=='')
    {
            alert('Please enter the Workinprogress P3 S4 Value');
            document.theForm.workinprogressp3s4.value="";
            theForm.workinprogressp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P3 S4 Value ');
		document.theForm.workinprogressp3s4.value="";
        theForm.workinprogressp3s4.focus();
        return false;
  	}

     if (trim(theForm.workinprogressp4s1.value)=='')
    {
            alert('Please enter the Workinprogress P4 S1 Value');
            document.theForm.workinprogressp4s1.value="";
            theForm.workinprogressp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P4 S1 Value ');
		document.theForm.workinprogressp4s1.value="";
        theForm.workinprogressp4s1.focus();
        return false;
  	}

    if (trim(theForm.workinprogressp4s2.value)=='')
    {
            alert('Please enter the Workinprogress P4 S2 Value');
            document.theForm.workinprogressp4s2.value="";
            theForm.workinprogressp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P4 S2 Value ');
		document.theForm.workinprogressp4s2.value="";
        theForm.workinprogressp4s2.focus();
        return false;
  	}
    if (trim(theForm.workinprogressp4s3.value)=='')
    {
            alert('Please enter the Workinprogress P4 S3 Value');
            document.theForm.workinprogressp4s3.value="";
            theForm.workinprogressp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P4 S3 Value ');
		document.theForm.workinprogressp4s3.value="";
        theForm.workinprogressp4s3.focus();
        return false;
  	}
    if (trim(theForm.workinprogressp4s4.value)=='')
    {
            alert('Please enter the Workinprogress P4 S4 Value');
            document.theForm.workinprogressp4s4.value="";
            theForm.workinprogressp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.workinprogressp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Workinprogress P4 S4 Value ');
		document.theForm.workinprogressp4s4.value="";
        theForm.workinprogressp4s4.focus();
        return false;
  	}
    if (trim(theForm.codereviewp1s1.value)=='')
    {
            alert('Please enter the Code Review P1 S1 Value');
            document.theForm.codereviewp1s1.value="";
            theForm.codereviewp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P1 S1 Value ');
		document.theForm.codereviewp1s1.value="";
        theForm.codereviewp1s1.focus();
        return false;
  	}
    if (trim(theForm.codereviewp1s2.value)=='')
    {
            alert('Please enter the Code Review P1 S2 Value');
            document.theForm.codereviewp1s2.value="";
            theForm.codereviewp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P1 S2 Value ');
		document.theForm.codereviewp1s2.value="";
        theForm.codereviewp1s2.focus();
        return false;
  	}
    if (trim(theForm.codereviewp1s3.value)=='')
    {
            alert('Please enter the Code Review P1 S3 Value');
            document.theForm.codereviewp1s3.value="";
            theForm.codereviewp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P1 S3 Value ');
		document.theForm.codereviewp1s3.value="";
        theForm.codereviewp1s3.focus();
        return false;
  	}
    if (trim(theForm.codereviewp1s4.value)=='')
    {
            alert('Please enter the Code Review P1 S4 Value');
            document.theForm.codereviewp1s4.value="";
            theForm.codereviewp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P1 S4 Value ');
		document.theForm.codereviewp1s4.value="";
        theForm.codereviewp1s4.focus();
        return false;
  	}
    if (trim(theForm.codereviewp2s1.value)=='')
    {
            alert('Please enter the Code Review P2 S1 Value');
            document.theForm.codereviewp2s1.value="";
            theForm.codereviewp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P2 S1 Value ');
		document.theForm.codereviewp2s1.value="";
        theForm.codereviewp2s1.focus();
        return false;
  	}
    if (trim(theForm.codereviewp2s2.value)=='')
    {
            alert('Please enter the Code Review P2 S2 Value');
            document.theForm.codereviewp2s2.value="";
            theForm.codereviewp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P2 S2 Value ');
		document.theForm.codereviewp2s2.value="";
        theForm.codereviewp2s2.focus();
        return false;
  	}
    if (trim(theForm.codereviewp2s3.value)=='')
    {
            alert('Please enter the Code Review P2 S3 Value');
            document.theForm.codereviewp2s3.value="";
            theForm.codereviewp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P2 S3 Value ');
		document.theForm.codereviewp2s3.value="";
        theForm.codereviewp2s3.focus();
        return false;
  	}
    if (trim(theForm.codereviewp2s4.value)=='')
    {
            alert('Please enter the Code Review P2 S4 Value');
            document.theForm.codereviewp2s4.value="";
            theForm.codereviewp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P2 S4 Value ');
		document.theForm.codereviewp2s4.value="";
        theForm.codereviewp2s4.focus();
        return false;
  	}
    if (trim(theForm.codereviewp3s1.value)=='')
    {
            alert('Please enter the Code Review P3 S1 Value');
            document.theForm.codereviewp3s1.value="";
            theForm.codereviewp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P3 S1 Value ');
		document.theForm.codereviewp3s1.value="";
        theForm.codereviewp3s1.focus();
        return false;
  	}
    if (trim(theForm.codereviewp3s2.value)=='')
    {
            alert('Please enter the Code Review P3 S2 Value');
            document.theForm.codereviewp3s2.value="";
            theForm.codereviewp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P3 S2 Value ');
		document.theForm.codereviewp3s2.value="";
        theForm.codereviewp3s2.focus();
        return false;
  	}
    if (trim(theForm.codereviewp3s3.value)=='')
    {
            alert('Please enter the Code Review P3 S3 Value');
            document.theForm.codereviewp3s3.value="";
            theForm.codereviewp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P3 S3 Value ');
		document.theForm.codereviewp3s3.value="";
        theForm.codereviewp3s3.focus();
        return false;
  	}
    if (trim(theForm.codereviewp3s4.value)=='')
    {
            alert('Please enter the Code Review P3 S4 Value');
            document.theForm.codereviewp3s4.value="";
            theForm.codereviewp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P3 S4 Value ');
		document.theForm.codereviewp3s4.value="";
        theForm.codereviewp3s4.focus();
        return false;
  	}
    if (trim(theForm.codereviewp4s1.value)=='')
    {
            alert('Please enter the Code Review P4 S1 Value');
            document.theForm.codereviewp4s1.value="";
            theForm.codereviewp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P4 S1 Value ');
		document.theForm.codereviewp4s1.value="";
        theForm.codereviewp4s1.focus();
        return false;
  	}
    if (trim(theForm.codereviewp4s2.value)=='')
    {
            alert('Please enter the Code Review P4 S2 Value');
            document.theForm.codereviewp4s2.value="";
            theForm.codereviewp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P4 S2 Value ');
		document.theForm.codereviewp4s2.value="";
        theForm.codereviewp4s2.focus();
        return false;
  	}
    if (trim(theForm.codereviewp4s3.value)=='')
    {
            alert('Please enter the Code Review P4 S3 Value');
            document.theForm.codereviewp4s3.value="";
            theForm.codereviewp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P4 S3 Value ');
		document.theForm.codereviewp4s3.value="";
        theForm.codereviewp4s3.focus();
        return false;
  	}
    if (trim(theForm.codereviewp4s4.value)=='')
    {
            alert('Please enter the Code Review P4 S4 Value');
            document.theForm.codereviewp4s4.value="";
            theForm.codereviewp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.codereviewp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Code Review P4 S4 Value ');
		document.theForm.codereviewp4s4.value="";
        theForm.codereviewp4s4.focus();
        return false;
  	}
    if (trim(theForm.readytobuildp1s1.value)=='')
    {
            alert('Please enter the Ready to Build P1 S1 Value');
            document.theForm.readytobuildp1s1.value="";
            theForm.readytobuildp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P1 S1 Value ');
		document.theForm.readytobuildp1s1.value="";
        theForm.readytobuildp1s1.focus();
        return false;
  	}

    if (trim(theForm.readytobuildp1s2.value)=='')
    {
            alert('Please enter the Ready to Build P1 S2 Value');
            document.theForm.readytobuildp1s2.value="";
            theForm.readytobuildp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P1 S2 Value ');
		document.theForm.readytobuildp1s2.value="";
        theForm.readytobuildp1s2.focus();
        return false;
  	}
    if (trim(theForm.readytobuildp1s3.value)=='')
    {
            alert('Please enter the Ready to Build P1 S3 Value');
            document.theForm.readytobuildp1s3.value="";
            theForm.readytobuildp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P1 S3 Value ');
		document.theForm.readytobuildp1s3.value="";
        theForm.readytobuildp1s3.focus();
        return false;
  	}
    if (trim(theForm.readytobuildp1s4.value)=='')
    {
            alert('Please enter the Ready to Build P1 S4 Value');
            document.theForm.readytobuildp1s4.value="";
            theForm.readytobuildp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P1 S4 Value ');
		document.theForm.readytobuildp1s4.value="";
        theForm.readytobuildp1s4.focus();
        return false;
  	}

     if (trim(theForm.readytobuildp2s1.value)=='')
    {
            alert('Please enter the Ready to Build P2 S1 Value');
            document.theForm.readytobuildp2s1.value="";
            theForm.readytobuildp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P2 S1 Value ');
		document.theForm.readytobuildp2s1.value="";
        theForm.readytobuildp2s1.focus();
        return false;
  	}

    if (trim(theForm.readytobuildp2s2.value)=='')
    {
            alert('Please enter the Ready to Build P2 S2 Value');
            document.theForm.readytobuildp2s2.value="";
            theForm.readytobuildp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P2 S2 Value ');
		document.theForm.readytobuildp2s2.value="";
        theForm.readytobuildp2s2.focus();
        return false;
  	}
    if (trim(theForm.readytobuildp2s3.value)=='')
    {
            alert('Please enter the Ready to Build P2 S3 Value');
            document.theForm.readytobuildp2s3.value="";
            theForm.readytobuildp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P2 S3 Value ');
		document.theForm.readytobuildp2s3.value="";
        theForm.readytobuildp2s3.focus();
        return false;
  	}
    if (trim(theForm.readytobuildp2s4.value)=='')
    {
            alert('Please enter the Ready to Build P2 S4 Value');
            document.theForm.readytobuildp2s4.value="";
            theForm.readytobuildp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P2 S4 Value ');
		document.theForm.readytobuildp2s4.value="";
        theForm.readytobuildp2s4.focus();
        return false;
  	}

     if (trim(theForm.readytobuildp3s1.value)=='')
    {
            alert('Please enter the Ready to Build P3 S1 Value');
            document.theForm.readytobuildp3s1.value="";
            theForm.readytobuildp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P3 S1 Value ');
		document.theForm.readytobuildp3s1.value="";
        theForm.readytobuildp3s1.focus();
        return false;
  	}

    if (trim(theForm.readytobuildp3s2.value)=='')
    {
            alert('Please enter the Ready to Build P3 S2 Value');
            document.theForm.readytobuildp3s2.value="";
            theForm.readytobuildp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P3 S2 Value ');
		document.theForm.readytobuildp3s2.value="";
        theForm.readytobuildp3s2.focus();
        return false;
  	}
    if (trim(theForm.readytobuildp3s3.value)=='')
    {
            alert('Please enter the Ready to Build P3 S3 Value');
            document.theForm.readytobuildp3s3.value="";
            theForm.readytobuildp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P3 S3 Value ');
		document.theForm.readytobuildp3s3.value="";
        theForm.readytobuildp3s3.focus();
        return false;
  	}
    if (trim(theForm.readytobuildp3s4.value)=='')
    {
            alert('Please enter the Ready to Build P3 S4 Value');
            document.theForm.readytobuildp3s4.value="";
            theForm.readytobuildp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P3 S4 Value ');
		document.theForm.readytobuildp3s4.value="";
        theForm.readytobuildp3s4.focus();
        return false;
  	}

     if (trim(theForm.readytobuildp4s1.value)=='')
    {
            alert('Please enter the Ready to Build P4 S1 Value');
            document.theForm.readytobuildp4s1.value="";
            theForm.readytobuildp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P4 S1 Value ');
		document.theForm.readytobuildp4s1.value="";
        theForm.readytobuildp4s1.focus();
        return false;
  	}

    if (trim(theForm.readytobuildp4s2.value)=='')
    {
            alert('Please enter the Ready to Build P4 S2 Value');
            document.theForm.readytobuildp4s2.value="";
            theForm.readytobuildp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P4 S2 Value ');
		document.theForm.readytobuildp4s2.value="";
        theForm.readytobuildp4s2.focus();
        return false;
  	}
    if (trim(theForm.readytobuildp4s3.value)=='')
    {
            alert('Please enter the Ready to Build P4 S3 Value');
            document.theForm.readytobuildp4s3.value="";
            theForm.readytobuildp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P4 S3 Value ');
		document.theForm.readytobuildp4s3.value="";
        theForm.readytobuildp4s3.focus();
        return false;
  	}
    if (trim(theForm.readytobuildp4s4.value)=='')
    {
            alert('Please enter the Ready to Build P4 S4 Value');
            document.theForm.readytobuildp4s4.value="";
            theForm.readytobuildp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.readytobuildp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Ready to Build P4 S4 Value ');
		document.theForm.readytobuildp4s4.value="";
        theForm.readytobuildp4s4.focus();
        return false;
  	}


    if (trim(theForm.qap1s1.value)=='')
    {
            alert('Please enter the QA P1 S1 Value');
            document.theForm.qap1s1.value="";
            theForm.qap1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap1s1.value)))
        {
   		alert('Please enter the Numericals only in the QA P1 S1 Value ');
		document.theForm.qap1s1.value="";
        theForm.qap1s1.focus();
        return false;
  	}

    if (trim(theForm.qap1s2.value)=='')
    {
            alert('Please enter the QA P1 S2 Value');
            document.theForm.qap1s2.value="";
            theForm.qap1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap1s2.value)))
        {
   		alert('Please enter the Numericals only in the QA P1 S2 Value ');
		document.theForm.qap1s2.value="";
        theForm.qap1s2.focus();
        return false;
  	}
    if (trim(theForm.qap1s3.value)=='')
    {
            alert('Please enter the QA P1 S3 Value');
            document.theForm.qap1s3.value="";
            theForm.qap1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap1s3.value)))
        {
   		alert('Please enter the Numericals only in the QA P1 S3 Value ');
		document.theForm.qap1s3.value="";
        theForm.qap1s3.focus();
        return false;
  	}
    if (trim(theForm.qap1s4.value)=='')
    {
            alert('Please enter the QA P1 S4 Value');
            document.theForm.qap1s4.value="";
            theForm.qap1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap1s4.value)))
        {
   		alert('Please enter the Numericals only in the QA P1 S4 Value ');
		document.theForm.qap1s4.value="";
        theForm.qap1s4.focus();
        return false;
  	}

     if (trim(theForm.qap2s1.value)=='')
    {
            alert('Please enter the QA P2 S1 Value');
            document.theForm.qap2s1.value="";
            theForm.qap2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap2s1.value)))
        {
   		alert('Please enter the Numericals only in the QA P2 S1 Value ');
		document.theForm.qap2s1.value="";
        theForm.qap2s1.focus();
        return false;
  	}

    if (trim(theForm.qap2s2.value)=='')
    {
            alert('Please enter the QA P2 S2 Value');
            document.theForm.qap2s2.value="";
            theForm.qap2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap2s2.value)))
        {
   		alert('Please enter the Numericals only in the QA P2 S2 Value ');
		document.theForm.qap2s2.value="";
        theForm.qap2s2.focus();
        return false;
  	}
    if (trim(theForm.qap2s3.value)=='')
    {
            alert('Please enter the QA P2 S3 Value');
            document.theForm.qap2s3.value="";
            theForm.qap2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap2s3.value)))
        {
   		alert('Please enter the Numericals only in the QA P2 S3 Value ');
		document.theForm.qap2s3.value="";
        theForm.qap2s3.focus();
        return false;
  	}
    if (trim(theForm.qap2s4.value)=='')
    {
            alert('Please enter the QA P2 S4 Value');
            document.theForm.qap2s4.value="";
            theForm.qap2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap2s4.value)))
        {
   		alert('Please enter the Numericals only in the QA P2 S4 Value ');
		document.theForm.qap2s4.value="";
        theForm.qap2s4.focus();
        return false;
  	}

     if (trim(theForm.qap3s1.value)=='')
    {
            alert('Please enter the QA P3 S1 Value');
            document.theForm.qap3s1.value="";
            theForm.qap3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap3s1.value)))
        {
   		alert('Please enter the Numericals only in the QA P3 S1 Value ');
		document.theForm.qap3s1.value="";
        theForm.qap3s1.focus();
        return false;
  	}

    if (trim(theForm.qap3s2.value)=='')
    {
            alert('Please enter the QA P3 S2 Value');
            document.theForm.qap3s2.value="";
            theForm.qap3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap3s2.value)))
        {
   		alert('Please enter the Numericals only in the QA P3 S2 Value ');
		document.theForm.qap3s2.value="";
        theForm.qap3s2.focus();
        return false;
  	}
    if (trim(theForm.qap3s3.value)=='')
    {
            alert('Please enter the QA P3 S3 Value');
            document.theForm.qap3s3.value="";
            theForm.qap3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap3s3.value)))
        {
   		alert('Please enter the Numericals only in the QA P3 S3 Value ');
		document.theForm.qap3s3.value="";
        theForm.qap3s3.focus();
        return false;
  	}
    if (trim(theForm.qap3s4.value)=='')
    {
            alert('Please enter the QA P3 S4 Value');
            document.theForm.qap3s4.value="";
            theForm.qap3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap3s4.value)))
        {
   		alert('Please enter the Numericals only in the QA P3 S4 Value ');
		document.theForm.qap3s4.value="";
        theForm.qap3s4.focus();
        return false;
  	}

     if (trim(theForm.qap4s1.value)=='')
    {
            alert('Please enter the QA P4 S1 Value');
            document.theForm.qap4s1.value="";
            theForm.qap4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap4s1.value)))
        {
   		alert('Please enter the Numericals only in the QA P4 S1 Value ');
		document.theForm.qap4s1.value="";
        theForm.qap4s1.focus();
        return false;
  	}

    if (trim(theForm.qap4s2.value)=='')
    {
            alert('Please enter the QA P4 S2 Value');
            document.theForm.qap4s2.value="";
            theForm.qap4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap4s2.value)))
        {
   		alert('Please enter the Numericals only in the QA P4 S2 Value ');
		document.theForm.qap4s2.value="";
        theForm.qap4s2.focus();
        return false;
  	}
    if (trim(theForm.qap4s3.value)=='')
    {
            alert('Please enter the QA P4 S3 Value');
            document.theForm.qap4s3.value="";
            theForm.qap4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap4s3.value)))
        {
   		alert('Please enter the Numericals only in the QA P4 S3 Value ');
		document.theForm.qap4s3.value="";
        theForm.qap4s3.focus();
        return false;
  	}
    if (trim(theForm.qap4s4.value)=='')
    {
            alert('Please enter the QA P4 S4 Value');
            document.theForm.qap4s4.value="";
            theForm.qap4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.qap4s4.value)))
        {
   		alert('Please enter the Numericals only in the QA P4 S4 Value ');
		document.theForm.qap4s4.value="";
        theForm.qap4s4.focus();
        return false;
  	}


    if (trim(theForm.performancetestingp1s1.value)=='')
    {
            alert('Please enter the Performance Testing P1 S1 Value');
            document.theForm.performancetestingp1s1.value="";
            theForm.performancetestingp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P1 S1 Value ');
		document.theForm.performancetestingp1s1.value="";
        theForm.performancetestingp1s1.focus();
        return false;
  	}

    if (trim(theForm.performancetestingp1s2.value)=='')
    {
            alert('Please enter the Performance Testing P1 S2 Value');
            document.theForm.performancetestingp1s2.value="";
            theForm.performancetestingp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P1 S2 Value ');
		document.theForm.performancetestingp1s2.value="";
        theForm.performancetestingp1s2.focus();
        return false;
  	}
    if (trim(theForm.performancetestingp1s3.value)=='')
    {
            alert('Please enter the Performance Testing P1 S3 Value');
            document.theForm.performancetestingp1s3.value="";
            theForm.performancetestingp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P1 S3 Value ');
		document.theForm.performancetestingp1s3.value="";
        theForm.performancetestingp1s3.focus();
        return false;
  	}
    if (trim(theForm.performancetestingp1s4.value)=='')
    {
            alert('Please enter the Performance Testing P1 S4 Value');
            document.theForm.performancetestingp1s4.value="";
            theForm.performancetestingp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P1 S4 Value ');
		document.theForm.performancetestingp1s4.value="";
        theForm.performancetestingp1s4.focus();
        return false;
  	}

     if (trim(theForm.performancetestingp2s1.value)=='')
    {
            alert('Please enter the Performance Testing P2 S1 Value');
            document.theForm.performancetestingp2s1.value="";
            theForm.performancetestingp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P2 S1 Value ');
		document.theForm.performancetestingp2s1.value="";
        theForm.performancetestingp2s1.focus();
        return false;
  	}

    if (trim(theForm.performancetestingp2s2.value)=='')
    {
            alert('Please enter the Performance Testing P2 S2 Value');
            document.theForm.performancetestingp2s2.value="";
            theForm.performancetestingp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P2 S2 Value ');
		document.theForm.performancetestingp2s2.value="";
        theForm.performancetestingp2s2.focus();
        return false;
  	}
    if (trim(theForm.performancetestingp2s3.value)=='')
    {
            alert('Please enter the Performance Testing P2 S3 Value');
            document.theForm.performancetestingp2s3.value="";
            theForm.performancetestingp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P2 S3 Value ');
		document.theForm.performancetestingp2s3.value="";
        theForm.performancetestingp2s3.focus();
        return false;
  	}
    if (trim(theForm.performancetestingp2s4.value)=='')
    {
            alert('Please enter the Performance Testing P2 S4 Value');
            document.theForm.performancetestingp2s4.value="";
            theForm.performancetestingp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P2 S4 Value ');
		document.theForm.performancetestingp2s4.value="";
        theForm.performancetestingp2s4.focus();
        return false;
  	}

     if (trim(theForm.performancetestingp3s1.value)=='')
    {
            alert('Please enter the Performance Testing P3 S1 Value');
            document.theForm.performancetestingp3s1.value="";
            theForm.performancetestingp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P3 S1 Value ');
		document.theForm.performancetestingp3s1.value="";
        theForm.performancetestingp3s1.focus();
        return false;
  	}

    if (trim(theForm.performancetestingp3s2.value)=='')
    {
            alert('Please enter the Performance Testing P3 S2 Value');
            document.theForm.performancetestingp3s2.value="";
            theForm.performancetestingp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P3 S2 Value ');
		document.theForm.performancetestingp3s2.value="";
        theForm.performancetestingp3s2.focus();
        return false;
  	}
    if (trim(theForm.performancetestingp3s3.value)=='')
    {
            alert('Please enter the Performance Testing P3 S3 Value');
            document.theForm.performancetestingp3s3.value="";
            theForm.performancetestingp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P3 S3 Value ');
		document.theForm.performancetestingp3s3.value="";
        theForm.performancetestingp3s3.focus();
        return false;
  	}
    if (trim(theForm.performancetestingp3s4.value)=='')
    {
            alert('Please enter the Performance Testing P3 S4 Value');
            document.theForm.performancetestingp3s4.value="";
            theForm.performancetestingp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P3 S4 Value ');
		document.theForm.performancetestingp3s4.value="";
        theForm.performancetestingp3s4.focus();
        return false;
  	}

     if (trim(theForm.performancetestingp4s1.value)=='')
    {
            alert('Please enter the Performance Testing P4 S1 Value');
            document.theForm.performancetestingp4s1.value="";
            theForm.performancetestingp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P4 S1 Value ');
		document.theForm.performancetestingp4s1.value="";
        theForm.performancetestingp4s1.focus();
        return false;
  	}

    if (trim(theForm.performancetestingp4s2.value)=='')
    {
            alert('Please enter the Performance Testing P4 S2 Value');
            document.theForm.performancetestingp4s2.value="";
            theForm.performancetestingp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P4 S2 Value ');
		document.theForm.performancetestingp4s2.value="";
        theForm.performancetestingp4s2.focus();
        return false;
  	}
    if (trim(theForm.performancetestingp4s3.value)=='')
    {
            alert('Please enter the Performance Testing P4 S3 Value');
            document.theForm.performancetestingp4s3.value="";
            theForm.performancetestingp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P4 S3 Value ');
		document.theForm.performancetestingp4s3.value="";
        theForm.performancetestingp4s3.focus();
        return false;
  	}
    if (trim(theForm.performancetestingp4s4.value)=='')
    {
            alert('Please enter the Performance Testing P4 S4 Value');
            document.theForm.performancetestingp4s4.value="";
            theForm.performancetestingp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.performancetestingp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Performance Testing P4 S4 Value ');
		document.theForm.performancetestingp4s4.value="";
        theForm.performancetestingp4s4.focus();
        return false;
  	}


    if (trim(theForm.verifiedp1s1.value)=='')
    {
            alert('Please enter the Verified P1 S1 Value');
            document.theForm.verifiedp1s1.value="";
            theForm.verifiedp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Verified P1 S1 Value ');
		document.theForm.verifiedp1s1.value="";
        theForm.verifiedp1s1.focus();
        return false;
  	}

    if (trim(theForm.verifiedp1s2.value)=='')
    {
            alert('Please enter the Verified P1 S2 Value');
            document.theForm.verifiedp1s2.value="";
            theForm.verifiedp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Verified P1 S2 Value ');
		document.theForm.verifiedp1s2.value="";
        theForm.verifiedp1s2.focus();
        return false;
  	}
    if (trim(theForm.verifiedp1s3.value)=='')
    {
            alert('Please enter the Verified P1 S3 Value');
            document.theForm.verifiedp1s3.value="";
            theForm.verifiedp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Verified P1 S3 Value ');
		document.theForm.verifiedp1s3.value="";
        theForm.verifiedp1s3.focus();
        return false;
  	}
    if (trim(theForm.verifiedp1s4.value)=='')
    {
            alert('Please enter the Verified P1 S4 Value');
            document.theForm.verifiedp1s4.value="";
            theForm.verifiedp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Verified P1 S4 Value ');
		document.theForm.verifiedp1s4.value="";
        theForm.verifiedp1s4.focus();
        return false;
  	}

     if (trim(theForm.verifiedp2s1.value)=='')
    {
            alert('Please enter the Verified P2 S1 Value');
            document.theForm.verifiedp2s1.value="";
            theForm.verifiedp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Verified P2 S1 Value ');
		document.theForm.verifiedp2s1.value="";
        theForm.verifiedp2s1.focus();
        return false;
  	}

    if (trim(theForm.verifiedp2s2.value)=='')
    {
            alert('Please enter the Verified P2 S2 Value');
            document.theForm.verifiedp2s2.value="";
            theForm.verifiedp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Verified P2 S2 Value ');
		document.theForm.verifiedp2s2.value="";
        theForm.verifiedp2s2.focus();
        return false;
  	}
    if (trim(theForm.verifiedp2s3.value)=='')
    {
            alert('Please enter the Verified P2 S3 Value');
            document.theForm.verifiedp2s3.value="";
            theForm.verifiedp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Verified P2 S3 Value ');
		document.theForm.verifiedp2s3.value="";
        theForm.verifiedp2s3.focus();
        return false;
  	}
    if (trim(theForm.verifiedp2s4.value)=='')
    {
            alert('Please enter the Verified P2 S4 Value');
            document.theForm.verifiedp2s4.value="";
            theForm.verifiedp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Verified P2 S4 Value ');
		document.theForm.verifiedp2s4.value="";
        theForm.verifiedp2s4.focus();
        return false;
  	}

     if (trim(theForm.verifiedp3s1.value)=='')
    {
            alert('Please enter the Verified P3 S1 Value');
            document.theForm.verifiedp3s1.value="";
            theForm.verifiedp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Verified P3 S1 Value ');
		document.theForm.verifiedp3s1.value="";
        theForm.verifiedp3s1.focus();
        return false;
  	}

    if (trim(theForm.verifiedp3s2.value)=='')
    {
            alert('Please enter the Verified P3 S2 Value');
            document.theForm.verifiedp3s2.value="";
            theForm.verifiedp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Verified P3 S2 Value ');
		document.theForm.verifiedp3s2.value="";
        theForm.verifiedp3s2.focus();
        return false;
  	}
    if (trim(theForm.verifiedp3s3.value)=='')
    {
            alert('Please enter the Verified P3 S3 Value');
            document.theForm.verifiedp3s3.value="";
            theForm.verifiedp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Verified P3 S3 Value ');
		document.theForm.verifiedp3s3.value="";
        theForm.verifiedp3s3.focus();
        return false;
  	}
    if (trim(theForm.verifiedp3s4.value)=='')
    {
            alert('Please enter the Verified P3 S4 Value');
            document.theForm.verifiedp3s4.value="";
            theForm.verifiedp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Verified P3 S4 Value ');
		document.theForm.verifiedp3s4.value="";
        theForm.verifiedp3s4.focus();
        return false;
  	}

     if (trim(theForm.verifiedp4s1.value)=='')
    {
            alert('Please enter the Verified P4 S1 Value');
            document.theForm.verifiedp4s1.value="";
            theForm.verifiedp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Verified P4 S1 Value ');
		document.theForm.verifiedp4s1.value="";
        theForm.verifiedp4s1.focus();
        return false;
  	}

    if (trim(theForm.verifiedp4s2.value)=='')
    {
            alert('Please enter the Verified P4 S2 Value');
            document.theForm.verifiedp4s2.value="";
            theForm.verifiedp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Verified P4 S2 Value ');
		document.theForm.verifiedp4s2.value="";
        theForm.verifiedp4s2.focus();
        return false;
  	}
    if (trim(theForm.verifiedp4s3.value)=='')
    {
            alert('Please enter the Verified P4 S3 Value');
            document.theForm.verifiedp4s3.value="";
            theForm.verifiedp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Verified P4 S3 Value ');
		document.theForm.verifiedp4s3.value="";
        theForm.verifiedp4s3.focus();
        return false;
  	}
    if (trim(theForm.verifiedp4s4.value)=='')
    {
            alert('Please enter the Verified P4 S4 Value');
            document.theForm.verifiedp4s4.value="";
            theForm.verifiedp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.verifiedp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Verified P4 S4 Value ');
		document.theForm.verifiedp4s4.value="";
        theForm.verifiedp4s4.focus();
        return false;
  	}
        
    if (trim(theForm.closedp1s1.value)=='')
    {
            alert('Please enter the Closed P1 S1 Value');
            document.theForm.closedp1s1.value="";
            theForm.closedp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Closed P1 S1 Value ');
		document.theForm.closedp1s1.value="";
        theForm.closedp1s1.focus();
        return false;
  	}

    if (trim(theForm.closedp1s2.value)=='')
    {
            alert('Please enter the Closed P1 S2 Value');
            document.theForm.closedp1s2.value="";
            theForm.closedp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Closed P1 S2 Value ');
		document.theForm.closedp1s2.value="";
        theForm.closedp1s2.focus();
        return false;
  	}
    if (trim(theForm.closedp1s3.value)=='')
    {
            alert('Please enter the Closed P1 S3 Value');
            document.theForm.closedp1s3.value="";
            theForm.closedp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Closed P1 S3 Value ');
		document.theForm.closedp1s3.value="";
        theForm.closedp1s3.focus();
        return false;
  	}
    if (trim(theForm.closedp1s4.value)=='')
    {
            alert('Please enter the Closed P1 S4 Value');
            document.theForm.closedp1s4.value="";
            theForm.closedp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Closed P1 S4 Value ');
		document.theForm.closedp1s4.value="";
        theForm.closedp1s4.focus();
        return false;
  	}

     if (trim(theForm.closedp2s1.value)=='')
    {
            alert('Please enter the Closed P2 S1 Value');
            document.theForm.closedp2s1.value="";
            theForm.closedp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Closed P2 S1 Value ');
		document.theForm.closedp2s1.value="";
        theForm.closedp2s1.focus();
        return false;
  	}

    if (trim(theForm.closedp2s2.value)=='')
    {
            alert('Please enter the Closed P2 S2 Value');
            document.theForm.closedp2s2.value="";
            theForm.closedp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Closed P2 S2 Value ');
		document.theForm.closedp2s2.value="";
        theForm.closedp2s2.focus();
        return false;
  	}
    if (trim(theForm.closedp2s3.value)=='')
    {
            alert('Please enter the Closed P2 S3 Value');
            document.theForm.closedp2s3.value="";
            theForm.closedp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Closed P2 S3 Value ');
		document.theForm.closedp2s3.value="";
        theForm.closedp2s3.focus();
        return false;
  	}
    if (trim(theForm.closedp2s4.value)=='')
    {
            alert('Please enter the Closed P2 S4 Value');
            document.theForm.closedp2s4.value="";
            theForm.closedp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Closed P2 S4 Value ');
		document.theForm.closedp2s4.value="";
        theForm.closedp2s4.focus();
        return false;
  	}

     if (trim(theForm.closedp3s1.value)=='')
    {
            alert('Please enter the Closed P3 S1 Value');
            document.theForm.closedp3s1.value="";
            theForm.closedp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Closed P3 S1 Value ');
		document.theForm.closedp3s1.value="";
        theForm.closedp3s1.focus();
        return false;
  	}

    if (trim(theForm.closedp3s2.value)=='')
    {
            alert('Please enter the Closed P3 S2 Value');
            document.theForm.closedp3s2.value="";
            theForm.closedp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Closed P3 S2 Value ');
		document.theForm.closedp3s2.value="";
        theForm.closedp3s2.focus();
        return false;
  	}
    if (trim(theForm.closedp3s3.value)=='')
    {
            alert('Please enter the Closed P3 S3 Value');
            document.theForm.closedp3s3.value="";
            theForm.closedp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Closed P3 S3 Value ');
		document.theForm.closedp3s3.value="";
        theForm.closedp3s3.focus();
        return false;
  	}
    if (trim(theForm.closedp3s4.value)=='')
    {
            alert('Please enter the Closed P3 S4 Value');
            document.theForm.closedp3s4.value="";
            theForm.closedp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Closed P3 S4 Value ');
		document.theForm.closedp3s4.value="";
        theForm.closedp3s4.focus();
        return false;
  	}

     if (trim(theForm.closedp4s1.value)=='')
    {
            alert('Please enter the Closed P4 S1 Value');
            document.theForm.closedp4s1.value="";
            theForm.closedp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Closed P4 S1 Value ');
		document.theForm.closedp4s1.value="";
        theForm.closedp4s1.focus();
        return false;
  	}

    if (trim(theForm.closedp4s2.value)=='')
    {
            alert('Please enter the Closed P4 S2 Value');
            document.theForm.closedp4s2.value="";
            theForm.closedp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Closed P4 S2 Value ');
		document.theForm.closedp4s2.value="";
        theForm.closedp4s2.focus();
        return false;
  	}
    if (trim(theForm.closedp4s3.value)=='')
    {
            alert('Please enter the Closed P4 S3 Value');
            document.theForm.closedp4s3.value="";
            theForm.closedp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Closed P4 S3 Value ');
		document.theForm.closedp4s3.value="";
        theForm.closedp4s3.focus();
        return false;
  	}
    if (trim(theForm.closedp4s4.value)=='')
    {
            alert('Please enter the Closed P4 S4 Value');
            document.theForm.closedp4s4.value="";
            theForm.closedp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.closedp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Closed P4 S4 Value ');
		document.theForm.closedp4s4.value="";
        theForm.closedp4s4.focus();
        return false;
  	}

/*

    if (trim(theForm.reopenp1s1.value)=='')
    {
            alert('Please enter the Reopen P1 S1 Value');
            document.theForm.reopenp1s1.value="";
            theForm.reopenp1s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp1s1.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P1 S1 Value ');
		document.theForm.reopenp1s1.value="";
        theForm.reopenp1s1.focus();
        return false;
  	}

    if (trim(theForm.reopenp1s2.value)=='')
    {
            alert('Please enter the Reopen P1 S2 Value');
            document.theForm.reopenp1s2.value="";
            theForm.reopenp1s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp1s2.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P1 S2 Value ');
		document.theForm.reopenp1s2.value="";
        theForm.reopenp1s2.focus();
        return false;
  	}
    if (trim(theForm.reopenp1s3.value)=='')
    {
            alert('Please enter the Reopen P1 S3 Value');
            document.theForm.reopenp1s3.value="";
            theForm.reopenp1s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp1s3.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P1 S3 Value ');
		document.theForm.reopenp1s3.value="";
        theForm.reopenp1s3.focus();
        return false;
  	}
    if (trim(theForm.reopenp1s4.value)=='')
    {
            alert('Please enter the Reopen P1 S4 Value');
            document.theForm.reopenp1s4.value="";
            theForm.reopenp1s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp1s4.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P1 S4 Value ');
		document.theForm.reopenp1s4.value="";
        theForm.reopenp1s4.focus();
        return false;
  	}

     if (trim(theForm.reopenp2s1.value)=='')
    {
            alert('Please enter the Reopen P2 S1 Value');
            document.theForm.reopenp2s1.value="";
            theForm.reopenp2s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp2s1.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P2 S1 Value ');
		document.theForm.reopenp2s1.value="";
        theForm.reopenp2s1.focus();
        return false;
  	}

    if (trim(theForm.reopenp1s2.value)=='')
    {
            alert('Please enter the Reopen P2 S2 Value');
            document.theForm.reopenp2s2.value="";
            theForm.reopenp2s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp2s2.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P2 S2 Value ');
		document.theForm.reopenp2s2.value="";
        theForm.reopenp2s2.focus();
        return false;
  	}
    if (trim(theForm.reopenp2s3.value)=='')
    {
            alert('Please enter the Reopen P2 S3 Value');
            document.theForm.reopenp2s3.value="";
            theForm.reopenp2s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp2s3.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P2 S3 Value ');
		document.theForm.reopenp2s3.value="";
        theForm.reopenp2s3.focus();
        return false;
  	}
    if (trim(theForm.reopenp2s4.value)=='')
    {
            alert('Please enter the Reopen P2 S4 Value');
            document.theForm.reopenp2s4.value="";
            theForm.reopenp2s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp2s4.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P2 S4 Value ');
		document.theForm.reopenp2s4.value="";
        theForm.reopenp2s4.focus();
        return false;
  	}

     if (trim(theForm.reopenp3s1.value)=='')
    {
            alert('Please enter the Reopen P3 S1 Value');
            document.theForm.reopenp3s1.value="";
            theForm.reopenp3s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp3s1.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P3 S1 Value ');
		document.theForm.reopenp3s1.value="";
        theForm.reopenp3s1.focus();
        return false;
  	}

    if (trim(theForm.reopenp3s2.value)=='')
    {
            alert('Please enter the Reopen P3 S2 Value');
            document.theForm.reopenp3s2.value="";
            theForm.reopenp3s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp3s2.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P3 S2 Value ');
		document.theForm.reopenp3s2.value="";
        theForm.reopenp3s2.focus();
        return false;
  	}
    if (trim(theForm.reopenp3s3.value)=='')
    {
            alert('Please enter the Reopen P3 S3 Value');
            document.theForm.reopenp3s3.value="";
            theForm.reopenp3s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp3s3.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P3 S3 Value ');
		document.theForm.reopenp3s3.value="";
        theForm.reopenp3s3.focus();
        return false;
  	}
    if (trim(theForm.reopenp3s4.value)=='')
    {
            alert('Please enter the Reopen P3 S4 Value');
            document.theForm.reopenp3s4.value="";
            theForm.reopenp3s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp3s4.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P3 S4 Value ');
		document.theForm.reopenp3s4.value="";
        theForm.reopenp3s4.focus();
        return false;
  	}

     if (trim(theForm.reopenp4s1.value)=='')
    {
            alert('Please enter the Reopen P4 S1 Value');
            document.theForm.reopenp4s1.value="";
            theForm.reopenp4s1.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp4s1.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P4 S1 Value ');
		document.theForm.reopenp4s1.value="";
        theForm.reopenp4s1.focus();
        return false;
  	}

    if (trim(theForm.reopenp4s2.value)=='')
    {
            alert('Please enter the Reopen P4 S2 Value');
            document.theForm.reopenp4s2.value="";
            theForm.reopenp4s2.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp4s2.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P4 S2 Value ');
		document.theForm.reopenp4s2.value="";
        theForm.reopenp4s2.focus();
        return false;
  	}
    if (trim(theForm.reopenp4s3.value)=='')
    {
            alert('Please enter the Reopen P4 S3 Value');
            document.theForm.reopenp4s3.value="";
            theForm.reopenp4s3.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp4s3.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P4 S3 Value ');
		document.theForm.reopenp4s3.value="";
        theForm.reopenp4s3.focus();
        return false;
  	}
    if (trim(theForm.reopenp4s4.value)=='')
    {
            alert('Please enter the Reopen P4 S4 Value');
            document.theForm.reopenp4s4.value="";
            theForm.reopenp4s4.focus();
            return false;
  	}
	if (!isNumber(trim(theForm.reopenp4s4.value)))
        {
   		alert('Please enter the Numericals only in the Reopen P4 S4 Value ');
		document.theForm.reopenp4s4.value="";
        theForm.reopenp4s4.focus();
        return false;
  	}
*/



   return true;
}
function setFocus()  {
		document.theForm.unconfirmedp1s1.focus();
}
window.onload = setFocus;


function GetScript(){
    alert('Page Loaded');
}
