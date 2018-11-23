#!/usr/local/bin/ruby

body = ""
ARGF.each{|line|
  if line =~ /<td>/
    body << line.sub("</table>","").sub("<table>","")
  end
}

header = <<'HEADER'
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>対話システムライブコンペティション</title>
<meta name="Description" content="対話システムライブコンペティションのページです" />
<meta name="Keywords" content="対話システムライブコンペティション,対話システムライブコンペ,ライブコンペ,対話システム,対話,雑談" />
<link rel="icon" href="http://saetl.net/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" type="img/x-icon" href="http://saetl.net/favicon.ico" />
<link rel="stylesheet" href="../css/style.css">
<link href='https://fonts.googleapis.com/css?family=Berkshire+Swash|Lobster' rel='stylesheet' type='text/css'><!--googlewebフォント-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"><!--アイコンwebフォント-->
<link rel="stylesheet" href="../css/vertical-responsive-menu.css" /><!--レスポンシブメニュー-->
<link rel="stylesheet" href="../css/twilight.css"><!--スライドショー-->
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
on<script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
<![endif]-->
</head>

<body>
<div class="floating">
<table>
HEADER

footer = <<'FOOTER'
</table>
</div>
</body>
</html>
FOOTER

puts header
puts body
puts footer


