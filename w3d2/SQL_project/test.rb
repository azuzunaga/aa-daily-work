class QuestionLike
  attr_accessor :user_like, :user_id, :question_id

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM question_likes')
    p data
    data.map {|datum| QuestionLike.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_like = options['user_like']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise "#{self} already exists" if @id
    QuestionsDB.instance.execute(<<-SQL, @user_like, @user_id,  @question_id)
      INSERT INTO
        question_likes (user_like, user_id, question_id)
      VALUES
        (?, ?, ?);
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id
    QuestionsDB.instance.execute(<<-SQL, @user_like, @user_id, @question_id, @id)
      UPDATE
        question_likes
      SET
        user_like = ?, user_id = ?, question_id = ?
      WHERE
        id = ?;
    SQL
  end


  # def self.likers_for_question_id(question_id)
  #
  # end

end
