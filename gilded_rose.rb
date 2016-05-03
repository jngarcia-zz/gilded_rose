class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name.downcase
      when /aged brie/
        item.quality += 1 if item.quality < 50
      when /backstage passes/
        item.quality += 1 if item.quality < 50 && item.sell_in < 11
        item.quality += 1 if item.quality < 50 && item.sell_in < 6
        item.quality += 1 if item.quality < 50
        item.quality = 0 if item.sell_in <= 0
      when /sulfuras/
      when /conjured/
        if item.sell_in <= 0
          4.times { item.quality -= 1 if item.quality > 0 }
        else
          2.times { item.quality -= 1 if item.quality > 0 }
        end
      else
        if item.sell_in <= 0
          2.times { item.quality -= 1 if item.quality > 0 }
        else
          item.quality -= 1 if item.quality > 0
        end
      end
      item.sell_in -= 1 unless item.name.downcase.include?("sulfuras")
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
