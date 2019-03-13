# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'


feature 'Visitor creates a new initiative' do
  scenario 'clicks new initiative button' do
    visit root_path
    click_link 'New Initiative'
    expect(page).to have_content('New Initiative')   
  end
  scenario 'with title target date and description' do
    visit new_initiative_path
    fill_in 'Initiative Name', with: 'TestJ'
    fill_in 'Target Date', with: '01/01/2020'
    fill_in 'Description', with: 'TestJ'
    click_button 'Submit'
    expect(page).to have_content('TestJ')
  end
end

feature 'Visitor edits a initiative' do 
  background do
    @initiative = Initiative.create!(:title => 'TestA', :target_date => '01/02/2020')
  end
  scenario 'clicks initiative on list view' do
    visit edit_initiative_path(@initiative)
    expect(page).to have_content('Edit Initiative')
  end
  scenario 'change initiative name and target date' do
    visit edit_initiative_path(@initiative)
    fill_in 'Initiative Name', with: 'TestB'
    fill_in 'Target Date', with: '01/01/2020'
    fill_in 'Description', with: 'TestJ'
    click_button 'Submit'
    expect(page).to have_content('TestB')
  end
end


