require 'spec_helper'
 
describe Item do
 
  describe "#initialize" do
    it "is an Item" do
      new_item = Item.new("item_name","item_sell_in","item_quality")
      expect(new_item).to be_an_instance_of Item
    end
  end

  describe "#to_s" do
    it "returns readable name sell_in and quality" do
      new_item = Item.new("item_name","item_sell_in","item_quality")
      expect(new_item.to_s).to eq("item_name, item_sell_in, item_quality")
    end
  end

end