%dw 2.0
import p from Mule
var interval= p('default.date.interval')
var dateTimeFormat= p('default.datetime.format')

// To get the last updated date query parameter as previous day 
fun getPreviousDate(period)=
	{
		outDateTime: (now() - period)
	}
	
//To get Current time
fun getCurrentDate()=
{
	outDateTime: now()
}

// To Get Last Updated Date
fun getLastUpdatedDate(lastUpdatedOn)=
	if (lastUpdatedOn == null)
   		(getPreviousDate(interval).outDateTime) as String {format: dateTimeFormat}
    else 
    	lastUpdatedOn
    	
//To Get From Date
fun getFromDate(fromDate)=
	if (fromDate == null)
	
   		(getPreviousDate(interval).outDateTime) as String {format: dateTimeFormat}
    else 
    	fromDate


//To Get To Date
fun getToDate(toDate)=
	if (toDate == null)
	
   		(getCurrentDate().outDateTime) as String {format: dateTimeFormat}
    else 
    	toDate

//To get middleName field transformed for EMS DB
fun getEmsMiddleName(middleName)=
	if (middleName==null)
		""
		
	else if(sizeOf(middleName) > 40 ) 
		
		middleName[0 to 39]
		
	else 
		middleName
		 
//To get middleName field transformed for CEDS DB
fun getMiddleName(firstName, lastName, middleName)=
	if ((firstName == null) and (middleName) != (lastName))
            trim(middleName)
         
    else if ((lastName == null) and (middleName contains (firstName)))
            trim((middleName replace (firstName) with ("")))
         
    else if ((lastName == null))
           	trim(middleName)
         
    else if ((firstName == null) and (middleName contains  (lastName)))

            trim((middleName replace (lastName) with ("") ))
         
    else if ((middleName contains (firstName)) and (middleName contains(lastName)))
            trim((middleName replace (firstName) with ("") ) replace (lastName) with (""))
         
	else if (middleName contains(firstName))
            trim((middleName replace (firstName) with ("") ))
        
    else if (middleName contains(lastName))
            trim((middleName replace (lastName) with ("") ))
         
    else 	trim(middleName)
	
