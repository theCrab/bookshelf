module Web::Controllers::Books
  class Index
    include Web::Action
    include Hanami::Fumikiri::Skip
    expose :books

    def call(params)
      @books = BookRepository.new.all
    end
  end
end
