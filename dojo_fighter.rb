

#######################
## FIGHTER CLASS
#######################
class Fighter
    attr_accessor :name, :defense, :strength, :luck, :life, :skill_points
    def initialize name, defense=10, strength=10, luck=10, life=100, skill_points = 20
        @name = name
        @defense = defense
        @strength = strength
        @luck = luck
        @life = life
        @skill_points = skill_points
    end
 
    def attack(opponent)
        ## Takes a random number between 1 and 100, subtracts the luck and if that is less than zero, you get a critical hit.
        ## Critical hits cannot be defended against which makes makes the infinite loop impossible.
        
        critical_hit = rand(1...100)-self.luck < 0
        if critical_hit
            p "#{self.name} makes a critical hit on #{opponent.name} for #{self.strength} damage"
            opponent.life -= self.strength
        else
            damage = rand(1...self.strength)-rand(opponent.defense)
            damage < 0 ? damage = 0 : damage = damage
            opponent.life -= damage
            puts "#{self.name} did #{damage} damage to #{opponent.name}"
        end

    end 

    def stats
        stats = <<-STATS
        My name is #{self.name}
        My Strength is #{self.strength}
        My Defense is #{self.defense}
        My Luck is #{self.luck}

        STATS
        puts stats
    end

    def life_remaining
        puts "#{self.name} has #{self.life} life remaining."
    end
end

#######################
## DOJO CLASS
#######################

class Dojo

    ## Note, the training options have logic built in so if a stat is above 50, it can't be further trained.
    ## If below 50, the stat is increased by a random number between 1 & 10 + a random number between 1 and the Player's luck.

    ## Weights increases strength
    def Dojo.train_weights(fighter)
        if fighter.strength >= 50 
            
            puts "#{fighter.name} has maxed out their strength"
        else
        fighter.strength += (rand(1..10+rand(1..fighter.luck)))
        puts "#{fighter.name}'s Strength is now #{fighter.strength}"

        end
    end

    ## Cardio increases defense
    def Dojo.train_cardio(fighter)
        if fighter.defense >= 50 
            ## No stat can exceed 50.
            puts "#{fighter.name} has maxed out their defense"
        else
        fighter.defense += (rand(1..10+rand(1..fighter.luck)))
        puts "#{fighter.name}'s Defense is now #{fighter.defense}"
        end
    end

    ## Blackjack increases luck.
    def Dojo.train_blackjack(fighter)
        if fighter.luck >= 50 
            ## No stat can exceed 50.
            puts "#{fighter.name} has maxed out their luck"
        else
            fighter.luck += (rand(1..10+rand(1..fighter.luck)))
            puts "#{fighter.name}'s Luck is now #{fighter.luck}"
        end
    end
end 

#######################
## GAMEPLAY
#######################
continue = "yes"

## START GAME
while continue != "no" && continue != "n"

    ## PLAY OR NOT
    puts "Do you want to |play| or |quit|?"

    input = gets.chomp
    while input != "play" && input != "quit"
        "Do you want to |play| or |quit|?"
    end

    if input == "play"
        puts "you are playing"
    elsif input == "quit"
        puts "you are quitting"
        continue="no"
        return
    end

    puts "Please enter your name"
    name = gets.chomp!

    puts "Welcome #{name}, you are player #456\nYou will fight player #218.\nPress Enter to Continue"
    gets.chomp
    player1 = Fighter.new "456"
    player1.stats

    player2 = Fighter.new "218"
    player2.stats

    ## TRAINING LOOP
    training_counter = 1
    puts "Training: train with weights to increase strength, cardio to incraese defense, or blackjack to increase luck."
    while training_counter < 11
        puts "Training Week ##{training_counter}.\nWould you like to practice |weights|, |cardio|, or |blackjack|?"

        activity = gets.chomp!.downcase
        while activity != "weights" && activity != "cardio" && activity != "blackjack"
            p "Invalid selection. Would you like to practice |weights|, |cardio|, or |blackjack|?"
            activity = gets.chomp!.downcase
        end

        activity == "weights" ? Dojo.train_weights(player1) : activity == "cardio" ? Dojo.train_cardio(player1) : Dojo.train_blackjack(player1)
        
        ## Trains AI based on random ints.
        ai_activity = rand(1..3)
        ai_activity == 1 ? Dojo.train_weights(player2) : ai_activity == 2 ? Dojo.train_cardio(player2) : Dojo.train_blackjack(player2)

        player1.stats
        player2.stats
        training_counter += 1
    end

    puts "Time to play the game! Press enter to continue."
    gets.chomp

    
    round_counter = 1
    while player1.life > 0 && player2.life > 0
        p "Round #{round_counter} press enter to attack"
        gets.chomp
        player1.attack(player2)
        player2.attack(player1)
        player1.life_remaining
        player2.life_remaining
        round_counter += 1
    end

    if player1.life < player2.life
        puts "#{player2.name} Wins"
    elsif player1.life > player2.life
        puts "#{player1.name} Wins"
    else
        puts "The Match is a Draw"
    end

    puts "Continue? |yes| or |no|"

    continue = gets.chomp!

    while continue != "yes" && continue != "no"
        puts "Continue? |yes| or |no|"
        continue = gets.chomp!
    end

end


