require 'rspec'
require_relative '../market'

describe Market do
    before {@checkout = Market.new}

    it "Should scan items accurately" do
        expect(@checkout.scan('CH1')).to eq 1
        expect(@checkout.scan('AP1')).to eq 1
        expect(@checkout.scan('CF1')).to eq 1
        expect(@checkout.scan('MK1')).to eq 1
        expect(@checkout.scan('MT1')).to eq nil
        expect(@checkout.scan('uighiu3g')).to eq nil
       @checkout.reset
    end
    it "On reset receipt array should be reset from default index 0" do
        expect(@checkout.reset).to eq "\nShopping Cart Receipt \n_____________________\nItem            Price\n----            -----"
    end
    it "Should add with discounts items using register method correctly" do
        basket_test1 = ['CH1', 'AP1', 'CF1', 'MK1']
        basket_test1.each do |item|
           @checkout.scan item 
        end
        expect(@checkout.register).to eq 20.34
       @checkout.reset
        
        basket_test2 = ['MK1', 'AP1']
        basket_test2.each do |item|
           @checkout.scan item 
        end
        expect(@checkout.register).to eq 10.75
       @checkout.reset

        basket_test3 = ['CF1', 'CF1']
        basket_test3.each do |item|
           @checkout.scan item 
        end
        expect(@checkout.register).to eq 11.23
       @checkout.reset

        basket_test4 =  ['AP1', 'AP1', 'CH1', 'AP1']
        basket_test4.each do |item|
           @checkout.scan item 
        end
        expect(@checkout.register).to eq 16.61
       @checkout.reset

        basket_test5 = ['CH1', 'AP1', 'AP1', 'AP1', 'MK1']
        basket_test5.each do |item|
           @checkout.scan item 
        end
        expect(@checkout.register).to eq 16.61
       @checkout.reset
    end
end