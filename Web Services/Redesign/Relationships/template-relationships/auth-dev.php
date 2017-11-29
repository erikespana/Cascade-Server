<?

$soapURL = "https://your.domain.gov/ws/services/AssetOperationService?wsdl";

$client = new SoapClient (
	$soapURL,
	array( 'trace' => 1,
    'proxy_host' => "192.208.90.19",
    'proxy_port' => "80",
    'stream_context' => stream_context_create(
      array('https' =>
        array ('proxy' => "tcp://192.208.90.19:80", 'request_fulluri' => true)
      )
    )
  )
	//array ('trace' => 1, 'location' => str_replace('?wsdl', '', $soapURL))
);
$auth = array ('username' => '', 'password' => '' );

?>
