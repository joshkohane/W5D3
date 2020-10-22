require_relative "QuestionsDatabase.rb"

class QuestionFollows
    attr_accessor :id, :users_id, :questions_id
    def initialize(options)
        @id = options['id']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end

    def self.all
        follows = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        follows.map { |follow| QuestionFollows.new(follow) }
    end

    def self.find_by_users_id(users_id)
        user = QuestionsDatabase.instance.execute(<<-SQL, users_id)
        SELECT * FROM question_follows WHERE users_id = ?
        SQL
        user.map { |person| QuestionFollows.new(person)}
    end

    def self.find_by_questions_id(questions_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, questions_id)
        SELECT * FROM question_follows WHERE questions_id = ?
        SQL
        questions.map { |question| QuestionFollows.new(question)}
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * FROM question_follows WHERE id = ?
        SQL
        QuestionFollows.new(question.first)
    end

end