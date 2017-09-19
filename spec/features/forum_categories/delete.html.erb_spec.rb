require 'rails_helper'

RSpec.feature 'forum_categories/show' do
  context 'with no category' do
    let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }
    it 'displays an error' do
      visit forum_category_path(forum_category_1)

      click_on 'Delete category'

      expect(page).to have_content 'Category deleted'
      expect(ForumCategory.count).to eq(0)
    end
  end
end
