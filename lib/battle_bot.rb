class BattleBot
  attr_reader :name, :health, :enemies, :weapon, :dead

  @@count = 0

  def self.count
    @@count
  end

  def initialize(name,health=100)
    raise ArgumentError, "no name given" if name == nil
    @name = name
    @health = health
    @weapon = nil
    @enemies = []
    @dead = false
    @@count += 1
  end

  def dead?
    !!@dead
  end

  def has_weapon?
    !!@weapon
  end

  def pick_up(weapon)
    raise ArgumentError, "not a weapon" if !weapon.is_a?(Weapon)
    raise ArgumentError, "weapon already wielded" if weapon.bot != nil
    if @weapon == nil
      weapon.bot = self
      @weapon = weapon
    else
      nil
    end
  end

  def drop_weapon
    @weapon.bot = nil
    @weapon = nil
  end

  def take_damage(damage)
    raise ArgumentError, "not a Fixnum" if !damage.is_a? Fixnum
    if @health - damage >= 0
      @health -= damage
    else
      @health = 0
      @dead = true
      @@count -= 1
    end
    @health
  end

  def heal
    if !dead?
      if @health + 10 <= 100
        @health += 10
      else
        @health = 100
      end
      @health
    end
  end

  def attack(enemy)
    raise ArgumentError, "enemy is not a BattleBot" if !enemy.is_a?(BattleBot)
    raise ArgumentError, "cannot attack yourself" if enemy == self
    raise ArgumentError, "no weapon" if @weapon == nil
    enemy.receive_attack_from(self)
  end

  def receive_attack_from(attacking_bot)
    raise ArgumentError, "enemy is not a BattleBot" if !attacking_bot.is_a?(BattleBot)
    raise ArgumentError, "cannot attack yourself" if attacking_bot == self
    raise ArgumentError, "attacking bot is unarmed" if attacking_bot.weapon == nil
    take_damage(attacking_bot.weapon.damage)
    @enemies << attacking_bot unless @enemies.include?(attacking_bot)
    defend_against(attacking_bot)
  end

  def defend_against(enemy)
    if !dead? && has_weapon?
      attack(enemy)
    end
  end
  
  def has_weapon?
    !!@weapon
  end
end
