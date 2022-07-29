$account = xxx
$password = xxx
$token = Invoke-RestMethod -Method Get -Uri "http://www.0531yun.com/api/getToken?loginName=$account&password=$password"

$headers = @{
    authorization=$token.data.token
}

$response = Invoke-RestMethod -Method Get -Uri "http://www.0531yun.com/api/data/getRealTimeDataByDeviceAddr?deviceAddrs=21043767" -Headers $headers

$dataItem = $response.data.dataItem | Where-Object {$_.nodeId -match "1"}

$data = $dataItem.registerItem | Where-Object {$_.registerID -match "1"}
$data2 = $dataItem.registerItem | Where-Object {$_.registerID -match "2"}


echo  "<?xml version=`"1.0`" encoding=`"UTF-8`" ?>"
echo  "<prtg>"
echo    "<result>"
echo        "<channel>Temperature</channel>"
echo        "<float>1</float>"
echo        "<DecimalMode>1</DecimalMode>"
echo        "<unit>Temperature</unit>"
echo        "<value>"$data.data"</value>"
echo        "<LimitMode>1</LimitMode>"
echo        "<LimitMaxError>40.0</LimitMaxError>"
echo        "<LimitMaxWarning>38.0</LimitMaxWarning>"
echo        "<LimitMinWarning>10.0</LimitMinWarning>"
echo        "<LimitMinError>0.0</LimitMinError>"
echo    "</result>"
echo    "<result>"
echo        "<channel>"$data2.registerName"</channel>"
echo        "<float>1</float>"
echo        "<DecimalMode>1</DecimalMode>"
echo        "<value>"$data2.data"</value>"
echo        "<LimitMode>1</LimitMode>"
echo        "<LimitMaxError>10.0</LimitMaxError>"
echo        "<LimitMaxWarning>9.0</LimitMaxWarning>"
echo        "<LimitMinWarning>6.0</LimitMinWarning>"
echo        "<LimitMinError>5.0</LimitMinError>"
echo    "</result>"
echo  "</prtg>"
