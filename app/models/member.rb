class Member < ApplicationRecord

  GROUP_MEMBERS_NUM = 2

  def self.pairs
    members_mod = all.to_a.count % GROUP_MEMBERS_NUM
    pairs = pluck(:name).shuffle.each_slice(GROUP_MEMBERS_NUM).to_a

    if members_mod <= GROUP_MEMBERS_NUM - 2
      rest = pairs.pop
      rest.each_with_index do |elem, i|
        pairs[i] << elem
      end
    end
    '☆ ' + pairs.map{|a| a.join("、") }.join("\n☆ ")
  end

  def self.template
      "今週水曜日のシャッフル朝会の組み合わせです！\n☆ 付きの人が声がけや司会進行を行ってください。\n\n#{pairs}\n\n"
  end

  def self.deliver
    # %x{echo "#{template}" | mail -s 今週のシャッフル朝会です！ all@domain.jp}
      puts template
  end



  def self.sample_day
    Random.rand(Date.today.all_month)
  end

  def self.lunch_pairs
    pairs = pluck(:name, :status).shuffle.each_slice(4).to_a

    # 奇数の場合
    if pairs.last.length == 1
      last_one = pairs.pop[0]
      pairs.first.push(last_one)
    end

    pairs
  end

  def self.lunch_template
    pairs_str = lunch_pairs.inject('') do |str, pair|
                  str << "オススメ日: #{sample_day} ★y#{pair.sort{|a,b|a.last <=> b.last}.map{|i|"#{i.first}さん"}.join(' & ')}\n"
                end

    <<~EOS
      今月もやってまいりました！
      好評のワクワクランチの組み合わせです！

      #{pairs_str}

      ※ 日はあくまで候補となります。
      リーダー（★ ）を中心に都合の良い日を話し合って決定してください。
      リーダーがサポーターの場合は次の社員にお願いします。
    EOS
  end

  def self.lunch_deliver
    # `echo "#{template}" | mail -s 今月のランチペアです！ all@domain.jp`
    puts lunch_template
  end
end
