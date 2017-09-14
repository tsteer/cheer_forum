require 'rails_helper'

RSpec.describe 'forum_categories/index' do
  let(:forum_category_1) { ForumCategory.create(title: 'Category name 1') }
  let(:forum_category_2) { ForumCategory.create(title: 'Category name 2') }

  context 'with no categories' do
    it 'displays a message' do
      assign(:forum_categories, [])

      render

      expect(rendered).to match /There are no categories/
    end
  end

  context 'with 2 categories' do 
    it 'displays the categories' do
      assign(:forum_categories, [forum_category_1, forum_category_2])
      
      render

      expect(rendered).to match /Category name 1/
      expect(rendered).to match /Category name 2/
    end
  end
end
