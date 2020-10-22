require_relative "require.rb"

class Replies
    attr_accessor :id, :user_id, :question_id, :body, :parent_id
    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
        @body = options['body']
        @parent_id = options['parent_id']
    end

    def self.all
        replies = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        replies.map { |reply| Replies.new(reply) }
    end

    def self.find_by_question_id(question_id)
        question = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id = ?
        SQL
        Replies.new(question.first)
    end

    def self.find_by_user_id(user_id)
        user = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ?
        SQL
        user.map { |person| Replies.new(person) }
    end

    def self.find_by_parent_id(parent_id)
        parent = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
            SELECT
                *
            FROM
                replies
            WHERE
                parent_id = ?
        SQL
        Replies.new(parent.first)
    end

    
end