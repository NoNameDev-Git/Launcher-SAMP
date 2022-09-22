<?php require_once "SampQueryAPI.php"; // подключаем класс 
$ip = $_GET["ip"];
$port = $_GET["port"];
if (!$_GET["ip"]){
exit("error");
}
if (!$_GET["port"]){
exit("error");
}
if (!empty($_GET["ip"])&&!empty($_GET["port"]))
{
	$server = new SampQueryAPI($ip, $port); // подключаемся к серверу 
	if ($server->isOnline()) { 
	  $info = $server->getInfo(); 
	  $rules = $server->getRules(); 
	  $playerinfo = $server->getDetailedPlayers(); 

	  
	  
	  echo "|status|'Online|/status|";
	  echo "|hostname|" . $info['hostname'] . "|/hostname|";
	  echo "|players|" . $info['players'] . " / " . $info['maxplayers'] . "|/players|";
	  echo "|version|" . $rules['version'] . "|/version|";
	  echo "|weburl|" . $rules['weburl'] . "|/weburl|";
	  echo "|worldtime|" . $rules['worldtime'] . "|/worldtime|";
	  for($i = 0; $i <= 1000; $i++){
		echo "|playerid|" . $playerinfo[$i]['playerid'] . "|/playerid|"; 
		echo "|nickname|" . $playerinfo[$i]['nickname'] . "|/nickname|"; 
		echo "|score|" . $playerinfo[$i]['score'] . "|/score|"; 
		echo "|ping|" . $playerinfo[$i]['ping'] . "|/ping|"; 		
	  }
      	  
	}
	else
	{
	  echo "|status|Offline|/status|";	
	}
}