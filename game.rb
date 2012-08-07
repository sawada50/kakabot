# encoding: utf-8

require 'rubygems'
require 'rack'
require 'nkf'

class Game

  def call(env)
    req = Rack::Request.new(env)
    params = req.params()
    word = params["word"].to_s.encode("UTF-8","UTF-8").gsub(/\r/,"")
    char_ary = word.split(//)
    
    res = Rack::Response.new
#    session_data = req.env['rack.session']
#    session_data['counter'] ||= 0
#    session_data['counter'] += 1

    header = "<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><title>kakabot.</title></head><body>"
    html = "<h2>kakabot</h2>"
    html += "<div><img src=\"http://livedoor.blogimg.jp/laba_q/imgs/d/7/d7bc5f46.jpg\" /></div>"
    html += "<form action=\"/\" method=\"GET\" accept-charset=\"UTF-8\" enctype=\"UTF-8\">Please input words.<br><input type=\"text\" name=\"word\" size=\"40\"><input type=\"submit\" value=\"submit\"></form>"
    html += "<div>kakabot's answer.</div>"
    html += getBotAnswer(char_ary.pop.to_s)
    html += "<br><br><br>"
#    html += session_data['counter'].to_s()
    html += "<div><b>Follow as Session info.</b></div>"
    html += "<hr>"
    html += "<div><font size=1>"
    html += req.env.map {|key,value| 
      "#{key}: #{value}<br>"
    }.sort.join("\n")
    html += "</font></div>"
    footer = "</body></html>"
    res.write(header)
    res.write(html)
    res.write(footer)
    res.finish
#    test = "testtest";
#    html = createSampleHTML(test);
#    [200, {"Content-Type" => "text/html"}, [html]]
  end

#  def createSampleHTML(str) 
#    html = "<html><head><title>game</title></head><body><h1>#{str}</h1></body></html>"
#    puts html
#    return html
#  end

  def getBotAnswer(lastChar) 
    bot = {
      "あ"=>"あーそうだねー",
      "い"=>"いいと思うよ",
      "う"=>"うん、まぁまぁかな",
      "え"=>"えっとね、そうだね",
      "お"=>"おーさすがだね",
      "か"=>"元気ですよ",
      "き"=>"そうだよー",
      "く"=>"お肉たべる",
      "け"=>"元気ですよ",
      "こ"=>"元気ですよ",
      "さ"=>"またねー",
      "し"=>"しらす",
      "す"=>"すいか",
      "せ"=>"そーですかい",
      "そ"=>"そうなんだ",
      "た"=>"たまたまですよ",
      "ち"=>"ちょっとまってて",
      "つ"=>"つまんなーい",
      "て"=>"てんてん",
      "と"=>"あとまわし",
      "な"=>"なんだよ",
      "に"=>"にんにん",
      "ぬ"=>"ぬま",
      "ね"=>"ねー、だよねー",
      "の"=>"のんきなもんだな",
      "は"=>"はいはい",
      "ひ"=>"ひよわ",
      "ふ"=>"不意にはこまる",
      "へ"=>"へー",
      "ほ"=>"やったね",
      "ま"=>"またねー",
      "み"=>"みるなよ",
      "む"=>"むずかしいよね",
      "め"=>"めんどくさいなー",
      "も"=>"もーこまるわー",
      "や"=>"やるきあんのかよ",
      "ゆ"=>"ゆーよねー",
      "よ"=>"よろしくおねがいしまああああああああああああああああああああああああああああああああああああああああす",
      "わ"=>"こんにちわ",
      "ん"=>"まちがいない",
      "ー"=>"んーどうだろうね",
      "？"=>"ちょっとまってねー",
    }
    begin
      botAnswer = bot.fetch(lastChar).to_s
    rescue
      botAnswer = "･･･"
    end
    return botAnswer
  end
  
end

