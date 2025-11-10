@echo off
echo Your .lvs should be called input.lvs
pause
:: Export json in csv only the fields part
qsv json --jaq ".Fields" input.lvs  > temp_list.csv

echo Modify now the temp_list.csv and continue the script.
pause
:: now you have to modify it yourself

:: Tranform it back to json
qsv slice --json temp_list.csv > newFields.json
:: adapt the format from the fields for RR
jq "map({Expression: (.Expression // """"), Label: (.Label // """"), Label2: (.Label2 // """"), Alignment: ((.Alignment|tonumber) // 1), FontBold: ((.FontBold|tostring|ascii_downcase) == ""true""), FontItalic: ((.FontItalic|tostring|ascii_downcase) == ""true""), FontUnderlined: ((.FontUnderlined|tostring|ascii_downcase) == ""true""), Line: ((.Line|tonumber) // 1), Color: (.Color // """"), Link: (.Link // """"), ColSpan: ((.ColSpan|tonumber) // 0), ColOffset: ((.ColOffset|tonumber) // 0), Position: ((.Position|tonumber) // 0), DynamicFormat: (.DynamicFormat // """"), PreviewOnly: ((.PreviewOnly|tostring|ascii_downcase) == ""true""), ResponsiveHide: ((.ResponsiveHide|tonumber) // 0) })" newFields.json> newfields_good_format.json
:: Replace Fields in orginal file
jq --slurpfile new_fields newfields_good_format.json ".Fields = $new_fields[0]" input.lvs > output.lvs

