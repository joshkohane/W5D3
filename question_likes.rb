require_relative "QuestionsDatabase.rb"

class QuestionLikes
    attr_accessor :id, :users_id, :questions_id
    def initialize(options)
        @id = options['id']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end

    def self.all
        likes = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        likes.map { |like| QuestionLikes.new(like) }
    end

    def self.find_by_users_id(users_id)
        user = QuestionsDatabase.instance.execute(<<-SQL, users_id)
        SELECT * FROM question_likes WHERE users_id = ?
        SQL
        user.map { |person| QuestionLikes.new(person)}
    end

    def self.find_by_questions_id(questions_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, questions_id)
        SELECT * FROM question_likes WHERE questions_id = ?
        SQL
        questions.map { |question| QuestionLikes.new(question)}
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * FROM question_likes WHERE id = ?
        SQL
        QuestionLikes.new(question.first)
    end

end