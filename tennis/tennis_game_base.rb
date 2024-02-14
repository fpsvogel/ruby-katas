class TennisGame
  def won_point
    raise NotImplementedError, "#{self.class} should have implemented #{__method__}"
  end

  def score
    raise NotImplementedError, "#{self.class} should have implemented #{__method__}"
  end

  def self.inherited(subclass)
    @subclasses ||= []
    @subclasses << subclass
  end

  def self.subclasses
    @subclasses
  end
end
