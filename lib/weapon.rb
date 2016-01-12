class Weapon
  attr_reader :name, :damage, :bot
  def initialize(weapon_name, damage=0)
    raise ArgumentError, "no name provided" if weapon_name == nil
    raise ArgumentError,"name is not a string" if !weapon_name.is_a?(String)
    raise ArgumentError, "damage is not a Fixnum" if !damage.is_a?(Fixnum)
    @name = weapon_name
    @damage = damage
    @bot = nil
  end

  def bot=(battle_bot)
    if !battle_bot.is_a?(BattleBot) && !battle_bot.is_a?(NilClass)
      raise ArgumentError, "not a bot!"
    end
    @bot = battle_bot
  end

  def picked_up?
    !!@bot
  end
end
