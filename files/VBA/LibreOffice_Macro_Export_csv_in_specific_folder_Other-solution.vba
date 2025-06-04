Sub ExportActiveSheetAsCSV
    Dim oDoc As Object
    Dim oSheet As Object
    Dim sSheetName As String
    Dim sDocURL As String
    Dim sFolderURL As String
    Dim sCSVFileURL As String
    Dim args(1) As New com.sun.star.beans.PropertyValue
    Dim pos As Integer

    oDoc = ThisComponent

    If Not oDoc.hasLocation Then
        MsgBox "Please save the document first.", 48, "Export Error"
        Exit Sub
    End If

    sDocURL = oDoc.URL
    pos = LastInstr(sDocURL, "/")
    If pos > 0 Then
        sFolderURL = Left(sDocURL, pos)
    Else
        MsgBox "Cannot find folder path.", 48, "Error"
        Exit Sub
    End If

    oSheet = oDoc.CurrentController.ActiveSheet
    sSheetName = oSheet.Name

    sCSVFileURL = sFolderURL & sSheetName & ".csv"

    args(0).Name = "FilterName"
    args(0).Value = "Text - txt - csv (StarCalc)"

    args(1).Name = "FilterOptions"
    args(1).Value = "44,34,0,1" ' comma=44, quote=34, UTF-8

    oDoc.storeToURL(sCSVFileURL, args())

    'MsgBox "Sheet '" & sSheetName & "' exported as CSV to:" & Chr(10) & sCSVFileURL, 64, "Export Successful"
End Sub

Function LastInstr(s As String, ch As String) As Integer
    Dim i As Integer
    LastInstr = 0
    For i = Len(s) To 1 Step -1
        If Mid(s, i, 1) = ch Then
            LastInstr = i
            Exit For
        End If
    Next i
End Function



