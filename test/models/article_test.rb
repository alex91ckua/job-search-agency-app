require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'should not save article without admin_user' do
    article = Article.new(title: 'Title',
                          description: 'Description',
                          tags: 'Tags')
    assert_not article.save
  end
end
