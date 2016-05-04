require 'spec_helper'

describe GildedRose do
  let(:backstage_passes) { Item.new("Backstage passes for wat", 10, 20) }
  let(:aged_brie) { Item.new("Aged Brie", 20, 20) }
  let(:sulfuras) { Item.new("Sulfuras, Hand of wat", 20, 20) }
  let(:conjured) { Item.new("Conjured of wat", 20, 20) }
  let(:normal_item) { Item.new("Book", 20, 20) }

  describe "#update_quality" do
    context "Sulfuras" do
      it "Quality should be equal to 80[<]" do
        item = sulfuras
        item.quality = 79
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(80)
      end

      it "Quality should be equal to 80[=]" do
        item = sulfuras
        item.quality = 80
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(80)
      end

      it "Quality should be equal to 80[>]" do
        item = sulfuras
        item.quality = 81
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(80)
      end
    end

    context "Aged Brie" do
      it "Quality increses as it gets older[<]" do
        item = aged_brie
        item.sell_in = -1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(21)
      end

      it "Quality increses as it gets older[=]" do
        item = aged_brie
        item.sell_in = 0
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(21)
      end

      it "Quality increses as it gets older[>]" do
        item = aged_brie
        item.sell_in = 1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(21)
      end

      it "Quality should not be over 50[<]" do
        item = aged_brie
        item.quality = 49
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(50)
      end

      it "Quality should not be over 50[=]" do
        item = aged_brie
        item.quality = 50
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(50)
      end

      it "Quality should not be over 50[>]" do
        item = aged_brie
        item.quality = 51
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(50)
      end

      it "Quality should not contain a negative value[<]" do
        item = aged_brie
        item.quality = -2
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality should not contain a negative value[=]" do
        item = aged_brie
        item.quality = -1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality should not contain a negative value[>]" do
        item = aged_brie
        item.quality = 0
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(1)
      end
    end

    context "Backstage passes" do
      it "Quality should not be over 50[<]" do
        item = backstage_passes
        item.quality = 49
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(50)
      end

      it "Quality should not be over 50[=]" do
        item = backstage_passes
        item.quality = 50
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(50)
      end

      it "Quality should not be over 50[>]" do
        item = backstage_passes
        item.quality = 51
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(50)
      end

      it "Quality must increase by 2 when sell in is less than 10days[<]" do
        item = backstage_passes
        item.sell_in = 9
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(22)
      end

      it "Quality must increase by 2 when sell in is less than 10days[=]" do
        item = backstage_passes
        item.sell_in = 10
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(22)
      end

      it "Quality must increase by 2 when sell in is less than 10days[>]" do
        item = backstage_passes
        item.sell_in = 11
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(21)
      end

      it "Quality must increase by 3 when sell in is less than 5days[<]" do
        item = backstage_passes
        item.sell_in = 4
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(23)
      end

      it "Quality must increase by 3 when sell in is less than 5days[=]" do
        item = backstage_passes
        item.sell_in = 5
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(23)
      end

      it "Quality must increase by 3 when sell in is less than 5days[>]" do
        item = backstage_passes
        item.sell_in = 6
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(22)
      end

      it "Quality must be equal to 0 after the concert[<]" do
        item = backstage_passes
        item.sell_in = -1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality must be equal to 0 after the concert[=]" do
        item = backstage_passes
        item.sell_in = 0
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality must be equal to 0 after the concert[>]" do
        item = backstage_passes
        item.sell_in = 1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(23)
      end

      it "Quality should not contain a negative value[<]" do
        item = backstage_passes
        item.quality = -2
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality should not contain a negative value[=]" do
        item = backstage_passes
        item.quality = -1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality should not contain a negative value[>]" do
        item = backstage_passes
        item.quality = 0
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(2)
      end
    end

    context "Conjured Item" do
      it "Quality should not be over 50[<]" do
        item = conjured
        item.quality = 50
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(48)
      end

      it "Quality should not be over 50[=]" do
        item = conjured
        item.quality = 51
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(48)
      end

      it "Quality should not be over 50[>]" do
        item = conjured
        item.quality = 52
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(48)
      end

      it "Quality degrades twice after sellin[<]" do
        item = conjured
        item.sell_in = -1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(16)
      end

      it "Quality degrades twice after sellin[=]" do
        item = conjured
        item.sell_in = 0
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(16)
      end

      it "Quality degrades twice after sellin[>]" do
        item = conjured
        item.sell_in = 1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(18)
      end

      it "Quality should not contain a negative value[<]" do
        item = conjured
        item.quality = -2
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality should not contain a negative value[=]" do
        item = conjured
        item.quality = -1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality should not contain a negative value[>]" do
        item = conjured
        item.quality = 0
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end
    end

    context "Normal Item" do
      it "Quality should not be over 50[<]" do
        item = normal_item
        item.quality = 50
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(49)
      end

      it "Quality should not be over 50[=]" do
        item = normal_item
        item.quality = 51
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(49)
      end

      it "Quality should not be over 50[>]" do
        item = normal_item
        item.quality = 52
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(49)
      end

      it "Quality degrades twice after sellin[<]" do
        item = normal_item
        item.sell_in = -1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(18)
      end

      it "Quality degrades twice after sellin[=]" do
        item = normal_item
        item.sell_in = 0
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(18)
      end

      it "Quality degrades twice after sellin[>]" do
        item = normal_item
        item.sell_in = 1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(19)
      end

      it "Quality should not contain a negative value[<]" do
        item = normal_item
        item.quality = -2
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality should not contain a negative value[=]" do
        item = normal_item
        item.quality = -1
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end

      it "Quality should not contain a negative value[>]" do
        item = normal_item
        item.quality = 0
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(0)
      end
    end
  end
end