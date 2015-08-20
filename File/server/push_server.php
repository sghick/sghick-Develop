<?php
$deviceToken= 'da6d8206503c8e62e68b5df1b36c3b58ced1588c6dabe0fc9e6828961aeb36d9'; //没有空格
$body = array("aps" => array("alert" => '推送的内容',"badge" => 1,"sound"=>'default'));  //推送方式，包含内容和声音
$ctx = stream_context_create();

//如果在Windows的服务器上，寻找pem路径会有问题，路径修改成这样的方法：
//$pem = dirname(__FILE__) . '/' . 'apns-dev.pem';
//linux 的服务器直接写pem的路径即可

stream_context_set_option($ctx,"ssl","local_cert","26ck.pem");
$pass = "123123";
stream_context_set_option($ctx, 'ssl', 'passphrase', $pass);

//此处有两个服务器需要选择，如果是开发测试用，选择第二名sandbox的服务器并使用Dev的pem证书，如果是正是发布，使用Product的pem并选用正式的服务器
// $fp = stream_socket_client("ssl://gateway.push.apple.com:2195", $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
$fp = stream_socket_client("ssl://gateway.sandbox.push.apple.com:2195", $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);

if (!$fp) {
    echo "Failed to connect $err $errstrn";
    return;
}

print "Connection OK\n";
$payload = json_encode($body);

//这边可以弄一个循环实现多个deviceToken 值,这里暂用一个token值得方法
$msg = chr(0) . pack("n",32) . pack("H*", str_replace(' ', '', $deviceToken)) . pack("n",strlen($payload)) . $payload;
echo "sending message :" . $payload ."\n";
fwrite($fp, $msg);
fclose($fp);
?>