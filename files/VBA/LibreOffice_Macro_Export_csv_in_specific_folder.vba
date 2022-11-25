Sub saveCSVwawi()
	' Source : https://forum.openoffice.org/en/forum/viewtopic.php?f=20&t=45425#p210008
	Dim sURL As String ' URL of current spreadsheet
	Dim FileN As String ' URL of target CSV-file
	Dim outP As String ' path of the export
	Dim oCurrentController As Object ' Before save - activate sheet sSheetName
	Dim storeParms(2) as new com.sun.star.beans.PropertyValue 
	outP = "file:///C:/Users/dorian.BSPM/Dropbox/Shared_Dorian/Firmen_Listen_EAN/Listen/csv/" ' you default path
	
	GlobalScope.BasicLibraries.LoadLibrary("Tools") ' Only for GetFileName
	sURL = thisComponent.getURL()
	FileN = outP &  GetFileNameWithoutExtension(FileNameoutofPath(sURL)) & ".csv" ' For Data.ods it will be Data.csv
	
	REM Options to StoreTo:
	storeParms(0).Name = "FilterName"
	storeParms(0).Value = "Text - txt - csv (StarCalc)"
	storeParms(1).Name = "FilterOptions"
	storeParms(1).Value = "59,34,UTF-8,1,,,true,,true" 
	REM About this string see https://wiki.openoffice.org/wiki/Documentation/DevGuide/Spreadsheets/Filter_Options
	storeParms(2).Name = "Overwrite"
	storeParms(2).Value = True
	REM Activate sheet for export - select "DataSheet"
	REM thisComponent.getCurrentController().setActiveSheet(thisComponent.getSheets().getByName(sSheetName))
	REM storeToURL can raises com.sun.star.io.IOException! Only now:
	
	On Error GoTo Errorhandle
	REM Export
	thisComponent.storeToURL(FileN,storeParms())
	REM MsgBox ("No Error Found,Upload file is saved : """ + ConvertFromUrl(FileN) + """.")
	Exit Sub

	Errorhandle:
	MsgBox ("Modifications Are Not Saved,Upload File Not Generated" & chr(13) _
	& "May be table " & FileN & " is open in another window? " &chr(13) _
	& "Original path is " & sURL)
	Exit Sub
    	
End Sub
