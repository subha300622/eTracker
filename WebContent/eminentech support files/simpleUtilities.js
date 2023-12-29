function textCounter(field,cntfield,maxlimit) 
    {
		if (field.value.length > maxlimit) 
		{
			field.value = field.value.substring(0, maxlimit);
                    alert('Comments size is exceeding 4000 characters');
		}
		else
			cntfield.value = maxlimit - field.value.length;
	}