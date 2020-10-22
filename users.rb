require_relative "require.rb"

class User
    attr_accessor :id, :f_name, :l_name
    def initialize(options)
        @id = options['id']
        @f_name = options['f_name']
        @l_name = options['l_name']
    end

    def self.all
        users = QuestionsDatabase.instance.execute("SELECT * FROM users")
        users.map { |user| User.new(user)}
    end

    def self.find_by_f_name(f_name)
        name = QuestionsDatabase.instance.execute(<<-SQL, f_name)
        SELECT * FROM users WHERE f_name = ?
        SQL
        name.map { |person| User.new(person)}
    end

    def self.find_by_l_name(l_name)
        name = QuestionsDatabase.instance.execute(<<-SQL, l_name)
        SELECT * FROM users WHERE l_name = ?
        SQL
        name.map { |person| User.new(person)}
    end

    def self.find_by_name(f_name,l_name)
        name = QuestionsDatabase.instance.execute(<<-SQL, f_name, l_name)
        SELECT * FROM users WHERE f_name = ? AND l_name = ?
        SQL
        User.new(name.first)
    end   
    
    def self.find_by_user_id(user_id)
        name = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT * FROM users WHERE id = ?
        SQL
        User.new(name.first)
    end 

    def authored_questions
        Question.find_by_author_id(self.id)
    end


    def authored_replies
        Replies.find_by_user_id(self.id)
    end
    
end