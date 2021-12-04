class Fighter
    attr_accessor :name, :defense, :strength, :luck, :life
    def initialize name, defense=10
        @name = name
        @defense = defense
    end
end

Gi-Hun = Fighter.new "Seong Gi-Hun"

Sang-Woo = Fighter.new "Cho Sang-Woo"
