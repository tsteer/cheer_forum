require 'rails_helper'

RSpec.feature 'updating a category' do
  context 'with no category' do
    it 'returns an error' do
      visit edit_forum_category_path(id: 9999)

      expect(page).to have_content '404'
    end
  end
  
  context 'with invalid details' do
  let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }

    it 'returns an error' do
      visit edit_forum_category_path(forum_category_1)

      fill_in 'Title', with: ''
      click_on 'Update category'

      expect(page).to have_content 'Invalid details'
    end
  end

  context 'with valid details' do
  let(:forum_category_1) { ForumCategory.create(title: 'Forum category title 1') }

    it 'updates the category title' do
      visit edit_forum_category_path(forum_category_1)

      fill_in 'Title', with: 'New category title'
      click_on 'Update category'

      expect(page).to have_content 'Category updated'
    end
  end
end
