# coding: utf-8

#トランプの山を表すクラス
class Playcards
  def initialize
    @cardarray = (0..52).to_a.shuffle
    @pointer = 0
    @carddef = getcarddef()
  end

  #カードの定義配列を作って返す
  def getcarddef
    defarr = []

    ["heart", "diamond", "club", "spade"].each do |type|
      13.times do |i|
        defarr << {type: type, num: i + 1}
      end
    end

    defarr << {type: "joker", num: 0}
  end

  #山をシャッフルする
  def shuffle
    @cardarray.shuffle
    @pointer = 0
  end

  #一枚カードを引く
  def draw
    if @pointer >= @cardarray.length then
      return nil
    end

    card = @cardarray[@pointer]
    @pointer += 1
    return card
  end

  #カードの定義を取得する
  def getcardinfo(index)
    if index >= @cardarray.length || @cardarray.length < 0 then
      return nil
    end

    return @carddef[index]
  end

  #山札の残枚数を返す
  def remaining
    return @cardarray.length - @pointer
  end
end

if __FILE__ == $0
  cards = Playcards.new

  puts "カードを一枚引きます"
  puts cards.getcardinfo(cards.draw)

  puts "カードを続けて五枚引きます"
  5.times do
    puts cards.getcardinfo(cards.draw)
  end

  puts cards.remaining

  #最後までカードを引く
  until (card = cards.draw) == nil do
    puts cards.getcardinfo(card)
    puts cards.remaining
  end
end
