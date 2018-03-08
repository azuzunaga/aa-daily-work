require 'sqlite3'
require 'singleton'

class QuestionsDB < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :fname, :lname

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM users')
    data.map {|datum| User.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def create
    raise "#{self} already exists" if @id
    QuestionsDB.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?);
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id
    QuestionsDB.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?;
    SQL
  end

  def self.find_by_id(id)
    found = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?;
    SQL
    return nil if found.length.zero?

    User.new(found.first)
  end

  def self.find_by_name(fname, lname)
    found = QuestionsDB.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?;
    SQL
    return nil if found.length.zero?

    User.new(found.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    # raise 'you dont ask nuff questions' if authored_questions.nil?
    # divisor = authored_questions.count #divisor
    # total_likes = liked_questions.reduce(0) {|total_likes, liked_question| total_likes + liked_question.num_likes}
    # total_likes/divisor.to_f
    total_questions_asked = QuestionsDB.instance.execute(<<-SQL, @id)
    SELECT
      COUNT(DISTINCT(title)) as total_qusetions
    FROM
      questions
    LEFT OUTER JOIN
      question_likes ON question_likes.question_id = questions.id
    WHERE
        questions.user_id = ?;
    GROUP BY
      questions.user_id

    SQL
    total_likes = QuestionsDB.instance.execute(<<-SQL, @id)
    SELECT
      COUNT(*) as total_likes
    FROM
      questions
    LEFT OUTER JOIN
      question_likes ON question_likes.question_id = questions.id
    WHERE
        questions.user_id = ? AND question_likes.id NOT NULL
    GROUP BY
      question_likes.question_id

    SQL
    p total_questions_asked.first['total_qusetions']
    p total_likes.first['total_likes']
    total_questions_asked.first['total_qusetions'] / total_likes.first['total_likes'].to_f
  end

end

class Question

  attr_accessor :title, :body, :user_id

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM questions')
    data.map {|datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def create
    raise "#{self} already exists" if @id
    QuestionsDB.instance.execute(<<-SQL, @title, @body, @user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?);
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id
    QuestionsDB.instance.execute(<<-SQL, @title, @body, @user_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, user_id = ?
      WHERE
        id = ?;
    SQL
  end

  def self.find_by_id(id)
    found = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?;
    SQL
    return nil if found.length.zero?

    Question.new(found.first)
  end

  def self.find_by_author_id(author_id)
    found = QuestionsDB.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      user_id = ?
    SQL
    return nil if found.length.zero?

    found.map {|el| Question.new(el)}
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
end

class QuestionFollow
  attr_accessor  :question_id, :user_id

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM questions_follows')
    data.map {|datum| QuestionFollow.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def create
    raise "#{self} already exists" if @id
    QuestionsDB.instance.execute(<<-SQL, @question_id, @user_id)
      INSERT INTO
        questions_follows (question_id, user_id)
      VALUES
        (?, ?);
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id
    QuestionsDB.instance.execute(<<-SQL, @question_id, @user_id, @id)
      UPDATE
        questions_follows
      SET
        question_id = ?, user_id = ?
      WHERE
        id = ?;
    SQL
  end

  def self.find_by_id(id)
    found = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions_follows
      WHERE
        id = ?;
    SQL
    return nil if found.length.zero?

    QuestionFollow.new(found.first)
  end

  def self.followers_for_question_id(question_id)
    found = QuestionsDB.instance.execute(<<-SQL, question_id)
    SELECT
      user_id AS id,
      fname,
      lname
    FROM
      questions_follows
    JOIN
      users on users.id = questions_follows.user_id
    WHERE
      question_id = ?
    SQL
    found.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    found = QuestionsDB.instance.execute(<<-SQL, user_id)
    SELECT
      question_id AS id,
      title,
      body,
      questions_follows.user_id

    FROM
      questions_follows
    JOIN
      questions ON questions.id = questions_follows.question_id
    WHERE
      questions_follows.user_id = ?
    SQL

    found.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    found = QuestionsDB.instance.execute(<<-SQL, n)
    SELECT
      Count(*), question_id
    FROM
      questions_follows
    JOIN
      questions
      ON questions.id = questions_follows.question_id
    GROUP BY
      question_id
    ORDER BY
      Count(*) DESC
    LIMIT
      ?
    SQL
    # questions = []
    found.map { |finds| Question.find_by_id(finds['question_id'])}
  end

end

class Reply
  attr_accessor :question_id, :user_id, :parent_id, :body

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM replies')
    data.map {|datum| Reply.new(datum) }
  end


  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
    @body = options['body']
  end

  def create
    raise "#{self} already exists" if @id
    QuestionsDB.instance.execute(<<-SQL, @question_id, @user_id, @parent_id, @body)
      INSERT INTO
        replies (question_id, user_id, parent_id, body)
      VALUES
        (?, ?, ?, ?);
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id
    QuestionsDB.instance.execute(<<-SQL, @question_id, @user_id, @parent_id, @body, @id)
      UPDATE
        replies
      SET
        question_id = ?, user_id = ?, parent_id = ?, body = ?
      WHERE
        id = ?;
    SQL
  end

  def self.find_by_id(id)
    found = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?;
    SQL
    return nil if found.length.zero?

    Reply.new(found.first)
  end

  def self.find_by_user_id(user_id)
    found = QuestionsDB.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL
    return nil if found.length.zero?

    found.map { |el| Reply.new(el) }
  end

  def self.find_by_question_id(question_id)
    found = QuestionsDB.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL
    return nil if found.length.zero?

    found.map { |el| Reply.new(el) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    found = QuestionsDB.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?
    SQL
    return nil if found.length.zero?

    found.map { |el| Reply.new(el) }
  end

end

class QuestionLike
  attr_accessor :user_like, :user_id, :question_id

  def self.all
    data = QuestionsDB.instance.execute('SELECT * FROM question_likes')
    data.map {|datum| QuestionLike.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise "#{self} already exists" if @id
    QuestionsDB.instance.execute(<<-SQL, @user_id, @question_id)
      INSERT INTO
        question_likes (user_id, question_id)
      VALUES
        (?, ?);
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id
    QuestionsDB.instance.execute(<<-SQL, @user_id, @question_id, @id)
      UPDATE
        question_likes
      SET
        user_id = ?, question_id = ?
      WHERE
        id = ?;
    SQL
  end


  def self.likers_for_question_id(question_id)
    found = QuestionsDB.instance.execute(<<-SQL, question_id)
    SELECT
      question_likes.user_id
    FROM
      question_likes
    JOIN
      users
      ON
        users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?
    SQL
    p found
    found.map { |user_id| User.find_by_id(user_id['user_id']) }
  end

  def self.num_likes_for_question_id(question_id)
    found = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) as count
      FROM
        question_likes
      WHERE
        question_id = ?
      GROUP BY
        question_id;
    SQL
    found.first['count']
  end

  def self.liked_questions_for_user_id(user_id)
    found = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?
    SQL
    found.map {|el| Question.new(el)}
  end

  def self.most_liked_questions(n)
    found = QuestionsDB.instance.execute(<<-SQL, n)
    SELECT
      COUNT(*), question_id
    FROM
      question_likes
    JOIN
      questions ON questions.id = question_likes.question_id
    GROUP BY
      question_id
    ORDER BY
      COUNT(*) DESC
    LIMIT
      ?

    SQL
    found.map {|el| Question.find_by_id(el['question_id'])}
  end


end
