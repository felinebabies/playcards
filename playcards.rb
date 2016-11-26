# coding: utf-8
require 'json'

#トランプの山を表すクラス
class Playcards
  def initialize(initobj = nil, initpointer = 0)
    if initobj == nil || !checkconsistency(initobj) then
      @cardarray = (0..52).to_a.shuffle
    else
      @cardarray = initobj
    end
    @pointer = initpointer
    @carddef = getcarddef()
  end

  #山札配列の整合性を調べる
  def checkconsistency(cardarr)
    if cardarr.length != 53 then
      return false
    end

    sortedarr = cardarr.sort

    sortedarr.each_with_index do |item, index|
      if item != index then
        return false
      end
    end
    return true
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

  #山札の情報をjsonで取得する
  def getjson
    JSON::dump(@cardarray)
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

  #山札の並びを得る
  puts cards.getjson()

  #既存の配列で初期化
  objarr = [25,45,27,15,39,49,32,14,48,0,2,12,30,23,52,40,36,26,28,33,41,13,11,1,37,8,22,47,20,10,7,51,9,21,3,29,6,42,24,16,50,19,4,18,35,31,44,17,43,34,46,38,5]
  altcards = Playcards.new(objarr)
  puts altcards.getcardinfo(altcards.draw)
end
