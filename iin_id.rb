#input
#ruby kai01.rb
#edit in sep07th
require 'csv'
argfname = ARGV[0]

#Dir.glob("./*.csv".encode('utf-8')).each{ |fname|	#ディレクトリ内を巡回、fnameにファイル名が入る。
#	file2 = File.open(fname.gsub(/.csv/,".html"),"a")
File.open("next/" + argfname, 'w') do |file|

	flg = 0
	giin_con = ""	#議員発言を格納
	ans_con = ""	#答弁者発言を格納
	
	#lineが発言、line2が名簿
	CSV.foreach(argfname, headers: false) do |line|
		CSV.foreach("ref/mori.csv", headers: false) do |line2|
			if line2[4].to_s.include?(line[0].to_s) == true || line2[5].to_s.include?(line[0].to_s) == true \
				|| line2[6].to_s.include?(line[0].to_s) == true then
				giin_con = line2[4].to_s + (",") + line[1].to_s + (",") + line2[0].to_s + ("\n")
				flg = 1
			else
				ans_con = line[0].to_s + (",") + line[1].to_s + (",0\n")
			end
		
			#ans_con = line[0] + (",") + line[1] + (",0\n")
		end
		
		if line[0] == nil && line[1] == nil then
			flg = 2
			print "空行検出\n"
		end
		
		if flg == 1 then
			file.write (giin_con)
			flg = 0
		elsif flg == 0 then
			file.write (ans_con)
		elsif flg == 2 then
			#空白行の処理。何もしない
			flg = 0
		end
		
		
		
	end
	
end

print "---終了---\n"
