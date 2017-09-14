require 'rails_helper'

RSpec.feature 'creating a category' do
  context 'with invalid details' do
    it 'returns an error' do
      visit new_forum_category_path

      fill_in 'Title', with: ''
      click_on 'Create category'

      expect(page).to have_content 'Invalid details'
    end
  end

  context 'with valid details' do
    it 'creates the category' do
      visit new_forum_category_path

      fill_in 'Title', with: 'New category title'
      click_on 'Create category'

      expect(page).to have_content 'Category created'
    end
  end
end
