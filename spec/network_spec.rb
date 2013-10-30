require_relative 'spec_helper'

describe Network do
  let(:network) { Network.new }

  it "has data attributes" do
    nbc = Network.create(:channel => 4, :call_letters => "NBC")
    nbc.channel.should eq(4)
    nbc.call_letters.should eq("NBC")
  end

  it "has many shows" do
    network.call_letters = "NBC"
    network.shows << Show.new(:name => "Community")
    network.save
    network.shows.count.should eq(1)
  end

  it "stops cancelling great shows" do
    network.call_letters = "NBC"
    pending "if anyone has contacts at NBC tell them to get their act together please"
  end

  it "should have picked up John Mullaney's Pilot" do
    network.call_letters == "NBC"
    network.sorry.should eq("We're sorry about passing on John Mullaney's pilot")
  end

end
