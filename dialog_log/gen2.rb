#!/usr/bin/ruby
# coding: utf-8

log = Hash::new()

ARGF.each{|line|
  next if line =~ /^system/
  elems = line.chomp.split("\t")
  system_name = elems[0]
  log[system_name] = [] if log[system_name] == nil
  log[system_name].push(elems)
}

target_list = [
  "mariko1",
  "mariko2",
  "trip1",
  "trip2",
  "zunko1",
  "zunko2"
]

name_set = {
  "mariko1" => "NTTdocomo 1回目",
  "mariko2" => "NTTdocomo 2回目",
  "trip1" => "NTTCS 1回目",
  "trip2" => "NTTCS 2回目",
  "zunko1" => "teamzunko 1回目",
  "zunko2" => "teamzunko 1回目"
}




header = <<'HEADER'
<!DOCTYPE html>
<html lang="ja">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>対話システムライブコンペティション</title>
    <meta name="Description" content="対話システムライブコンペティションのページです" />
    <meta name="Keywords" content="対話システムライブコンペティション,対話システムライブコンペ,ライブコンペ,対話システム,対話,雑談" />
    <link href='https://fonts.googleapis.com/css?family=Berkshire+Swash|Lobster' rel='stylesheet' type='text/css'><!--googlewebフォント-->
    <!-- BootstrapのCSS読み込み -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery読み込み -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- BootstrapのJS読み込み -->
    <script src="js/bootstrap.min.js"></script>
    <link href="../css/chart.css" rel="stylesheet">
  </head>
<body>
<h1>__system_name__</h1>

<table class="table table-striped table-bordered">
HEADER

footer = <<'FOOTER'
</table>
</div>
</body>
</html>
FOOTER


def bar_header(d1,d2,d3)
  val = ""
val << "<div class=\"graph\">"
val << "    <span class=\"bar_good\" style=\"width: 33.3%;\">#{d1}</span>"
val << "    <span class=\"bar_middle\" style=\"width: 33.3%;\">#{d2}</span>"
val << "    <span class=\"bar_bad\" style=\"width: 33.3%;\">#{d3}</span>"
val << "</div>"

return val
end

def bar(d1,d2,d3)
  val = ""
val << "<div class=\"graph\">"
val << "    <span class=\"bar_good\" style=\"width: #{d1}%;\">#{d1}%</span>"
val << "    <span class=\"bar_middle\" style=\"width: #{d2}%;\">#{d2}%</span>"
val << "    <span class=\"bar_bad\" style=\"width: #{d3}%;\">#{d3}%</span>"
val << "</div>"

return val
end



target_list.each{|target|
  body = ""
  
  body << "<tr><th>発話者</th><th>発話</th><th>評価#{bar_header("Good", "△", "Bad")}</th></tr>"

  log[target].each{|u|
    side = u[1]
    id = u[2]
    utterance = u[3]
    good_r = sprintf("%.1f",u[8].to_f * 100)
    bad_r = sprintf("%.1f",u[9].to_f * 100)
    middle_r = sprintf("%.1f", (100 - good_r.to_f - bad_r.to_f))
    
    if side == "U"
      body << "<tr><td>#{side}</td><td>#{utterance}</td><td></td></tr>\n"
    else
      body << "<tr><td>#{side}</td><td>#{utterance}</td><td>#{bar(good_r,middle_r,bad_r)}</td></tr>\n"
    end
  }


  wfp = File.open("#{target}.html", "w")
  wfp.puts header.gsub("__system_name__", name_set[target])
  wfp.puts body
  wfp.puts footer
  wfp.close

}

