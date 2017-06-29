require_relative './market'

checkout = Market.new
instruction = "Welcome! \nTo scan an item type: 'SCAN' then item name Ex. 'SCAN CF1' \nTo view all scanned items type: 'VIEW' \nTo checkout type: 'CHECK' \nTo print out your receipt type: 'PRINT' \nTo clear type: 'CLEAR'. Besure to clear after every checkout \nTo run a test type: 'TEST'"
puts instruction
puts 'To exit enter q or quit'
input = ''
while input != 'Q' or input != 'QUIT' 
    input = gets.chomp.upcase
    case input
        when /SCAN/
            val = input.split
            if val[1] 
                if val[1] === "CH1" || val[1] === "AP1" || val[1] === "CF1" || val[1] === "MK1"
                    checkout.scan val[1]
                    puts "Item successfully scanned: #{val[1]}"
                else
                    puts "Error! Unexpected Input! Be sure to strictly use these values: 'CH1', 'AP1', 'CF1', 'MK1'"
                end
            else
                puts "Error missing item!"
            end
        when 'VIEW'
            checkout.cart
        when 'CHECK'
            checkout.register
            puts "Successfully checked out your items. PRINT to view your receipt or CLEAR to start all over"
        when 'PRINT'
            checkout.receipt
        when 'CLEAR'
            checkout.reset
            puts 'Cart is clear'
        when 'I'
            puts instruction
        when 'TEST'
            checkout.reset
            checkout.test
        when 'Q' ,'QUIT'
            break
        else
            puts "Unrecognized Command\nType 'I' for instructions."
    end
end