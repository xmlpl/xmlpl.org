<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <?php
    $back = getenv("HTTP_REFERER");
  ?>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Refresh" content="5; URL=<?php echo $back; ?>"/>
    <title>Send Email</title>
  </head>
  <body>

  <?php
    $myemail = $_POST['myemail'];
    $visitor = $_POST['visitor'];
    $visitormail = $_POST['visitormail'];
    $subject = $_POST['subject'];
    $msg = $_POST['msg'];

    if (empty($visitor) || empty($visitormail) || empty($msg)) {
      echo "<h2>Message was NOT submitted</h2>\n";
      echo "<h2>Please go back and fill in all fields</h2>\n";

    } else if (!strstr($visitormail, "@") || !strstr($visitormail, ".")) {
      echo "<h2>Message was NOT submitted</h2>\n";
      echo "<h2>Please go back and enter a valid email address</h2>\n";

    } else {

      $ip = getenv("REMOTE_ADDR");
      $httpagent = getenv ("HTTP_USER_AGENT");
      $todayis = date("l, F j, Y, g:i a") ;
      $msg = stripcslashes($msg);

      $message = "Sent: $todayis [EST]
From: $visitor ($visitormail)
IP: $ip\n\n
$msg";

      $from = "From: $visitormail\r\n";

      if ($myemail != "")
        mail($myemail, $subject, $message, $from);
  ?>

  <div style="font-size:200%">
    Thanks for the message. . .<br/>
    <br/>

    <table border="1" cellspacing="5">
      <tr><td>Date</td><td><?php echo $todayis ?></td></tr>
      <tr>
        <td>Name</td>
        <td><?php echo $visitor ?> (<?php echo $visitormail ?>)</td>
      </tr>
      <tr><td>Your IP address</td><td><?php echo $ip?></td></tr>
    </table>

    <br/>
    <a href="<?php echo $back; ?>">Back to the website</a>
  </div>

  <?php } ?>
  </body>
</html>
