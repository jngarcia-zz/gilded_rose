class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      validate(item)
      case item.name.downcase
      when /aged brie/
        upgrade(item, 1)
      when /backstage passes/
        item.quality += 1 if item.quality < 50 && item.sell_in < 11
        item.quality += 1 if item.quality < 50 && item.sell_in < 6
        item.quality += 1 if item.quality < 50
        item.quality = 0 if item.sell_in <= 0
      when /sulfuras/
        item.quality = 80
      when /conjured/
        degrade(item, 2)
      else
        degrade(item, 1)
      end
      item.sell_in -= 1 unless item.name.downcase.include?("sulfuras")
    end
  end

  private

  def validate(item)
    if item.quality < 0
      item.quality = 0
    elsif item.quality > 50
      item.quality = 50
    end
  end

  def upgrade(item, rate)
    if item.sell_in < 0
      (rate*2).times { item.quality += 1 if item.quality < 50 }
    else
      rate.times { item.quality += 1 if item.quality < 50 }
    end
  end

  def degrade(item, rate)
    if item.sell_in <= 0
      (rate*2).times { item.quality -= 1 if item.quality > 0 }
    else
      rate.times { item.quality -= 1 if item.quality > 0 }
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
