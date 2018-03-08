class Card
  attr_reader :face_value, :state

  def initialize(face_value)
    @face_value = face_value
    @state = :face_down
  end

  def reveal
    @state = :face_up
    @face_value
  end

  def hide
    @state = :face_down
  end

  def to_s
    @face_value.to_s
  end

  def show_card
    if @state == :face_down
      "?".center(4)
    else
      @face_value.to_s.center(4)
    end
  end

  def pop
    @face_value
  end

  def ==(card)
    @face_value == card.face_value
  end
end
