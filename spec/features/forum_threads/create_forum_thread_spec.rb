require 'rails_helper'

RSpec.feature 'creating a thread' do
  context 'with valid details' do
    let(:forum_category_1) { ForumCategory.create(title: 'Category name 1') }
    let(:forum_category_2) { ForumCategory.create(title: 'Category name 2') }

    before do
      forum_category_1
      forum_category_2
    end

    it 'creates the thread' do
      visit new_forum_thread_path

      fill_in 'Title', with: 'New forum thread'
      select forum_category_2.title, from: 'Forum category'
      click_on 'Create thread'

      expect(page).to have_content 'Thread created'
    end
  end

  context 'with invalid details' do
    it 'returns an error' do
      visit new_forum_thread_path

      fill_in 'Title', with: ''
      click_on 'Create thread'

      expect(page).to have_content 'Invalid details'
    end
  end
end
