require 'spec_helper'

describe Spree::Address do
  context "validations" do
    describe "zipcode" do
      context "valid values" do
        it { should allow_value('12345-678').for(:zipcode) }
        it { should allow_value('54321-876').for(:zipcode) }
      end

      context "invalid values" do
        it { should_not allow_value('a12345-678').for(:zipcode) }
        it { should_not allow_value('abcde-fgh').for(:zipcode) }
        it { should_not allow_value('12345-678a').for(:zipcode) }
      end
    end
  end
end