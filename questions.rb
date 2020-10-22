require_relative "require.rb"

class Question
    attr_accessor :id, :title, :body, :author_id
    def self.all
        results = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        results.map { |data| Question.new(data) }
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * FROM questions WHERE id = ?
        SQL
        Question.new(question.first)
    end

    def self.find_by_author_id(author_id)
        author = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT * FROM questions WHERE author_id = ?
        SQL
        author.map { |person| Question.new(person)}
    end

    def self.find_by_title(title)
        name = QuestionsDatabase.instance.execute(<<-SQL, title)
        SELECT * FROM questions WHERE title = ?
        SQL
        Question.new(name.first)
    end

    def replies
        Replies.find_by_question_id(self.id)
    end

    def author
        Users.find_by_user_id(self.author_id)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

end