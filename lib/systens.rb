class Systens
  NAME = {
    1 => 'Odin',
    2 => 'Box',
    3 => 'SAED',
    4 => 'Egide'
  }.freeze

  class << self
    def name(code)
      NAME[code]
    end

    def system_code(name)
      NAME.key(name)
    end
  end
end
