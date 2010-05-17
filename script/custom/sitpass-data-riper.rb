require 'rubygems'
require 'open-uri'
require 'net/http'
require 'uri'
require 'nokogiri'

url_base  = "http://www.sitpass.com.br/"
url       = "http://www.sitpass.com.br/listagem_de_linhas2.php"
req       = Net::HTTP.post_form(URI.parse(url), 'lista_todos' => 'lista_todos')
body      = req.body rescue nil

if body.nil?
  fail "Erro ao requisitar a página."
end

doc                 = Nokogiri::HTML(body)
linha_code_pattern  = /\d(?:\.\d+|-[A-Z]+)?$/i # apenas linhas com codigos do tipo 403, 403.1 ou 403-A
all_links = doc.css('table:nth-child(6) a').map {|e| e[:href]}.to_a.grep(linha_code_pattern)

links_fetched = 0
all_lines = []

all_links.each do |href|
  doc_link = Nokogiri::HTML(open("#{url_base}#{href}")) rescue nil
  next if doc_link.nil?
  links_fetched += 1

  els = doc_link.css('td[height="25"]')
  linha = {:places => []}

  fetch = doc_link.css('td[width="291"] b').first.inner_html.split('<br>')
  linha.merge!(:code => fetch.first[/: (.+)$/, 1], :name => fetch.last)

  el = els.first
  places = []
  fetch = el.css('font').first.inner_html.split('<br>').map {|e| e.strip}
  places = fetch.map {|e| [e]}
  fetch = el.next.next.css('font').first.inner_html.split('<br>').map {|e| e.strip}
  places.map {|e| e << fetch.shift}
  linha[:places].push(*places)

  el = els.last
  places = []
  fetch = el.css('font').first.inner_html.split('<br>').map {|e| e.strip}
  places = fetch.map {|e| [e]}
  fetch = el.next.next.css('font').first.inner_html.split('<br>').map {|e| e.strip}
  places.map {|e| e << fetch.shift}
  linha[:places].push(*places)

  all_lines << linha

  sleep(1)
end

File.open($*.first, 'w') {|f| f.puts all_lines.inspect}
