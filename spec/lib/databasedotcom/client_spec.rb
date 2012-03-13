require 'spec_helper'

describe Databasedotcom do
  let(:account) do
    Account.new(:Name => 'test', :OwnerId => User.first.Id).save
  end

  it "does something" do
    puts account
  end

  it "does it again" do
    puts account
  end
end
