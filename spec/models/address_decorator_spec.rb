require 'spec_helper'

describe Spree::Address do
  describe "mass assignment" do
    context "allowed values" do
      [:address_number, :district].each do |attribute|
        it { should allow_mass_assignment_of(attribute) }
      end
    end
  end

  context "validations" do
    describe "requireds" do
      [:address_number, :district].each do |attribute|
        it { should validate_presence_of(attribute) }
      end
    end

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

    describe "phone" do
      context "valid values" do
        it { should allow_value('(12)3456-7890').for(:phone) }
        it { should allow_value('(11)3456-78909').for(:phone) }
      end

      context "invalid values" do
        it { should_not allow_value('(12)345612-7890').for(:phone) }
        it { should_not allow_value('a(12)3456-7890').for(:phone) }
        it { should_not allow_value('(ab)cdef-ghij').for(:phone) }
        it { should_not allow_value('(12)3456-7890a').for(:phone) }
      end
    end
  end
end