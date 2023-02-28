require "csv"

def border
  puts "----------------"
end

loop do 
  border
  puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"
  puts "番号を入力してください"
  memo_type = gets.chomp.to_i

  if memo_type == 1
    border
    puts "拡張子を除いたファイル名を入力してください"
    file_name = gets.chomp
    
    border
    puts "メモしたい内容を記入してください（複数行可）"
    puts "記入が完了したら「control + D」を入力してください"
    input_contents = STDIN.read.chomp

    CSV.open("#{file_name}.csv", "w") do |csv|
      csv << [input_contents]
    end
    
    border
    puts "実行フォルダ内にて、#{file_name}.csvが新規作成されました"
    break
    
  elsif memo_type == 2
    border
    puts "拡張子を除いたファイル名を入力してください"
    file_name = gets.chomp

    if File.exist?("#{file_name}.csv")
      border
      puts "前回までの入力内容："
      csv = CSV.read("#{file_name}.csv")
      csv.each do |content|
        puts content
      end

      border
      puts "追記内容を記入してください（複数行可）"
      puts "記入が完了したら「control + D」を入力してください"
      add_content = STDIN.read.chomp

      CSV.open("#{file_name}.csv", "a") do |csv|
        csv << [add_content]
      end

      border
      puts "#{file_name}.csvは正常に編集されました"
      break
      
    else
      border
      puts "ファイルが存在しません。最初からやり直してください"
    end
    
  else
    border
    puts "入力に誤りがあります。１または２で入力してください"
  end
end

