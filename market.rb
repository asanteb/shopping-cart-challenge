
class Market
    @@cart = {
        "CH1" => 0,
        "AP1" => 0,
        "CF1" => 0,
        "MK1" => 0
    }
    DEFAULT_RECEIPT = "\nShopping Cart Receipt \n_____________________\nItem            Price\n----            -----"
    @@receipt = [DEFAULT_RECEIPT]

    def scan item 
        case item
            when 'CH1'
                @@cart['CH1'] += 1    
            when 'AP1'
                @@cart['AP1'] += 1
            when 'CF1'
                @@cart['CF1'] += 1
            when 'MK1'
                @@cart['MK1'] += 1
        end
    end
    def register
        total = 0        
        if @@cart['CF1'] >= 2 && @@cart['CF1'] % 2 == 0
            cf1 = 11.23 * (@@cart['CF1']/2)
            discount = @@cart['CF1']*11.23 - cf1
            total += cf1
            @@receipt << "CF1 x#{@@cart['CF1']}          #{'%.2f'%(@@cart['CF1']*11.23)}"
            @@receipt << "      BOGO      -#{'%.2f'%discount}"
        end
        if @@cart['CF1'] != 0 && @@cart['CF1']%2  != 0
            if @@cart['CF1']  > 1
                cf1 = 11.23 * (@@cart['CF1']-1)/2 
                discount = ((@@cart['CF1']-1)/2 + 11.23)  - cf1
                total += cf1
                @@receipt << "CF1 x#{@@cart['CF1']}          #{'%.2f'%(@@cart['CF1']*11.23)}"
                @@receipt << "      BOGO      -#{'%.2f'%discount}"
            else
                total+=11.23
                @@receipt << "CF1 x#{@@cart['CF1']}          11.23"
            end
        end
        if @@cart['AP1'] >= 3 
            ap1 = 4.5 * @@cart['AP1'] 
            discount = @@cart['AP1']*6 - 4.5 * @@cart['AP1']
            total += ap1
            @@receipt << "AP1 x#{@@cart['AP1']}          #{'%.2f'%(@@cart['AP1']*6.00)}"
            @@receipt << "      APPL      -#{'%.2f'%discount}"
        end
        if @@cart['AP1'] < 3 && @@cart['AP1'] != 0
            ap1 = 6.0 * @@cart['AP1'] 
            total += ap1
            @@receipt << "AP1 x#{@@cart['AP1']}          #{'%.2f'%(@@cart['AP1']*6.00)}" 
        end

        if @@cart['CH1'] > 0 
            ch1 = @@cart['CH1']*3.11 
            total += ch1
            @@receipt << "CH1 x#{@@cart['CH1']}          #{'%.2f'%(@@cart['CH1']*3.11)}" 
            if @@cart['MK1'] > 0 
                discount = 4.75
                total -= discount
                @@receipt << "      CHMK      -#{'%.2f'%discount}"    
            end
            
        end
        if @@cart['MK1'] > 0
            mk1 = @@cart['MK1'] * 4.75
            @@receipt << "MK1 x#{@@cart['MK1']}          #{'%.2f'%(@@cart['MK1']*4.75)}" 
            total += mk1
        end
        @@receipt << '_____________________' << "Total           #{'%.2f'%total} \n"
        total
    end
    def receipt 
        puts @@receipt
    end
    def test 
        puts "Tests for current baskets"
        baskets = [
            ['CH1', 'AP1', 'CF1', 'MK1'],
            ['MK1', 'AP1'],
            ['CF1', 'CF1'],
            ['AP1', 'AP1', 'CH1', 'AP1'],
            ['CH1', 'AP1', 'AP1', 'AP1', 'MK1']
        ]
        baskets.each_with_index do | basket, index|
            puts "\nBasket ##{index+1}\n"
            basket.each do |item|
                self.scan item
            end
            self.register
            self.receipt
            self.reset
        end
    end
    def reset 
        @@cart['CH1'] = 0
        @@cart['AP1'] = 0
        @@cart['CF1'] = 0
        @@cart['MK1'] = 0
        @@receipt.clear
        @@receipt[0] = DEFAULT_RECEIPT
    end
    def cart 
        puts "Chai 🍵  > #{@@cart['CH1']} \nApple 🍎  > #{@@cart['AP1']}\nCoffee ☕  > #{@@cart['CF1']}\nMilk 🥛  > #{@@cart['MK1']}"
    end
end
