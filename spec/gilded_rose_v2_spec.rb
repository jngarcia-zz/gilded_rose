require 'spec_helper'

describe GildedRose do
  let(:aged_brie)         { Item.new("Aged Brie", 10, 10) }
  let(:sulfuras)          { Item.new("Sulfuras, Hand of wat", 10, 10) }

  let(:backstage_passes)  { Item.new("Backstage passes to wat land", 20, 20) }

  let(:conjured)          { Item.new("Conjured wat", 10, 10) }
  let(:expired_conjured)  { Item.new("Conjured wat", -1, 10) }

  let(:item)              { Item.new("Milk", 10, 10) }
  let(:expired_item)      { Item.new("Milk", -1, 10) }

  describe "#update_quality" do
    context "Aged Brie" do
      it "does decrease sell-in" do
        GildedRose.new([aged_brie]).update_quality
        expect(aged_brie.sell_in).to eq 9
      end

      it "does increase quality" do
        GildedRose.new([aged_brie]).update_quality
        expect(aged_brie.quality).to eq 11
      end
    end

    context "Sulfuras" do
      it "does not change sell-in" do
        GildedRose.new([sulfuras]).update_quality
        expect(sulfuras.sell_in).to eq 10
      end

      it "does not change quality" do
        GildedRose.new([sulfuras]).update_quality
        expect(sulfuras.quality).to eq 10
      end
    end

    context "Backstage passes" do
      it "does not change sell-in" do
        GildedRose.new([backstage_passes]).update_quality
        expect(backstage_passes.sell_in).to eq 19
      end

      it "does not change quality" do
        GildedRose.new([backstage_passes]).update_quality
        expect(backstage_passes.quality).to eq 21
      end
    end

    context "Conjured" do
      context "Not expired conjured" do
        it "does decrease sell-in" do
          GildedRose.new([conjured]).update_quality
          expect(conjured.sell_in).to eq 9
        end

        it "does increase quality" do
          GildedRose.new([conjured]).update_quality
          expect(conjured.quality).to eq 8
        end
      end

      context "Expired conjured" do
        it "does decrease sell-in" do
          GildedRose.new([expired_conjured]).update_quality
          expect(expired_conjured.sell_in).to eq(-2)
        end

        it "does increase quality" do
          GildedRose.new([expired_conjured]).update_quality
          expect(expired_conjured.quality).to eq 6
        end

      end
    end

    context "Item" do
      context "Not expired item" do
        it "does decrease sell-in" do
          GildedRose.new([item]).update_quality
          expect(item.sell_in).to eq 9
        end

        it "does decrease quality" do
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 9
        end
      end

      context "Expired item" do
        it "does decrease sell-in" do
          GildedRose.new([expired_item]).update_quality
          expect(expired_item.sell_in).to eq(-2)
        end

        it "does decrease quality" do
          GildedRose.new([expired_item]).update_quality
          expect(expired_item.quality).to eq 8
        end
      end
    end

  end

end
